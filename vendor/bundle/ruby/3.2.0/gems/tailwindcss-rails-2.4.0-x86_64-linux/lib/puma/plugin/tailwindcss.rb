require "puma/plugin"

Puma::Plugin.create do
  attr_reader :puma_pid, :tailwind_pid, :log_writer

  def start(launcher)
    @log_writer = launcher.log_writer
    @puma_pid = $$
    @tailwind_pid = fork do
      Thread.new { monitor_puma }
      system(*Tailwindcss::Commands.watch_command)
    end

    launcher.events.on_stopped { stop_tailwind }

    in_background do
      monitor_tailwind
    end
  end

  private
    def stop_tailwind
      Process.waitpid(tailwind_pid, Process::WNOHANG)
      log "Stopping tailwind..."
      Process.kill(:INT, tailwind_pid) if tailwind_pid
      Process.wait(tailwind_pid)
    rescue Errno::ECHILD, Errno::ESRCH
    end

    def monitor_puma
      monitor(:puma_dead?, "Detected Puma has gone away, stopping tailwind...")
    end

    def monitor_tailwind
      monitor(:tailwind_dead?, "Detected tailwind has gone away, stopping Puma...")
    end

    def monitor(process_dead, message)
      loop do
        if send(process_dead)
          log message
          Process.kill(:INT, $$)
          break
        end
        sleep 2
      end
    end

    def tailwind_dead?
      Process.waitpid(tailwind_pid, Process::WNOHANG)
      false
    rescue Errno::ECHILD, Errno::ESRCH
      true
    end

    def puma_dead?
      Process.ppid != puma_pid
    end

    def log(...)
      log_writer.log(...)
    end
end
