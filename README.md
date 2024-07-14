# RubyBattle

RubyBattle is an interactive platform crafted for Ruby enthusiasts to code, share insights through posts, and build connections. The application harnesses advanced features like CodeMirror for seamless coding and Hotwire for real-time updates.

## Key Features

- **Real-time Ruby Code**: Implemented using CodeMirror, allowing users to write and execute Ruby code within the application.
- **Connection Requests**: Users can send connection requests to interact and collaborate with other users.
- **CRUD Operations for Posts**: Users can create, read, update, and delete their own posts. Additionally, they can view posts created by other users.
- **Real-time Updates**: Utilized Hotwire to provide real-time updates, enhancing the responsiveness of the application.

## Technologies Used

- **Ruby**: The programming language.
- **Ruby on Rails**: The web application framework.
- **PostgreSQL**: The database management system.
- **Hotwire**: Utilized for real-time updates and improved responsiveness.
- **CodeMirror**: Integrated for real-time code editing and output display.

## Installation

To get a local copy up and running, follow these simple steps.

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/rubybattle.git
   cd rubybattle
   ```
2. **Install dependencies**:
   ```bash
   bundle install
   yarn install
   ```
3. **Set up the database:**:
   ```bash
   rails db:create
   rails db:migrate
   ```
4. **Start the Rails server**:
   ```bash
   rails server
   ```
5. **Navigate to http://localhost:3000 in your web browser.**

## Usage

Once the application is running, users can:

- Register and log in to their accounts.
- Edit Ruby code in real-time using the integrated CodeMirror editor.
- Send and accept connection requests to collaborate with other users.
- Create, view, update, and delete posts.
- Receive real-time updates and notifications, enhancing the interactive experience.
