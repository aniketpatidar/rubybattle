import{e,a as r,b as n}from"./_/zUudoq8i.js";import o from"./lib/util.js";var t={};t.GREATEST_LOWER_BOUND=1;t.LEAST_UPPER_BOUND=2;
/**
 * Recursive implementation of binary search.
 *
 * @param aLow Indices here and lower do not contain the needle.
 * @param aHigh Indices here and higher do not contain the needle.
 * @param aNeedle The element being searched for.
 * @param aHaystack The non-empty array being searched.
 * @param aCompare Function which takes two elements and returns -1, 0, or 1.
 * @param aBias Either 'binarySearch.GREATEST_LOWER_BOUND' or
 *     'binarySearch.LEAST_UPPER_BOUND'. Specifies whether to return the
 *     closest element that is smaller than or greater than the one we are
 *     searching for, respectively, if the exact element cannot be found.
 */function recursiveSearch(e,r,n,o,i,a){var u=Math.floor((r-e)/2)+e;var s=i(n,o[u],true);return s===0?u:s>0?r-u>1?recursiveSearch(u,r,n,o,i,a):a==t.LEAST_UPPER_BOUND?r<o.length?r:-1:u:u-e>1?recursiveSearch(e,u,n,o,i,a):a==t.LEAST_UPPER_BOUND?u:e<0?-1:e}
/**
 * This is an implementation of binary search which will always try and return
 * the index of the closest element if there is no exact hit. This is because
 * mappings between original and generated line/col pairs are single points,
 * and there is an implicit region between each of them, so a miss just means
 * that you aren't on the very start of a region.
 *
 * @param aNeedle The element you are looking for.
 * @param aHaystack The array that is being searched.
 * @param aCompare A function which takes the needle and an element in the
 *     array and returns -1, 0, or 1 depending on whether the needle is less
 *     than, equal to, or greater than the element, respectively.
 * @param aBias Either 'binarySearch.GREATEST_LOWER_BOUND' or
 *     'binarySearch.LEAST_UPPER_BOUND'. Specifies whether to return the
 *     closest element that is smaller than or greater than the one we are
 *     searching for, respectively, if the exact element cannot be found.
 *     Defaults to 'binarySearch.GREATEST_LOWER_BOUND'.
 */t.search=function search(e,r,n,o){if(r.length===0)return-1;var i=recursiveSearch(-1,r.length,e,r,n,o||t.GREATEST_LOWER_BOUND);if(i<0)return-1;while(i-1>=0){if(n(r[i],r[i-1],true)!==0)break;--i}return i};var i={};function SortTemplate(e){
/**
   * Swap the elements indexed by `x` and `y` in the array `ary`.
   *
   * @param {Array} ary
   *        The array.
   * @param {Number} x
   *        The index of the first item.
   * @param {Number} y
   *        The index of the second item.
   */
function swap(e,r,n){var o=e[r];e[r]=e[n];e[n]=o}
/**
   * Returns a random integer within the range `low .. high` inclusive.
   *
   * @param {Number} low
   *        The lower bound on the range.
   * @param {Number} high
   *        The upper bound on the range.
   */function randomIntInRange(e,r){return Math.round(e+Math.random()*(r-e))}
/**
   * The Quick Sort algorithm.
   *
   * @param {Array} ary
   *        An array to sort.
   * @param {function} comparator
   *        Function to use to compare two items.
   * @param {Number} p
   *        Start index of the array
   * @param {Number} r
   *        End index of the array
   */function doQuickSort(e,r,n,o){if(n<o){var t=randomIntInRange(n,o);var i=n-1;swap(e,t,o);var a=e[o];for(var u=n;u<o;u++)if(r(e[u],a,false)<=0){i+=1;swap(e,i,u)}swap(e,i+1,u);var s=i+1;doQuickSort(e,r,n,s-1);doQuickSort(e,r,s+1,o)}}return doQuickSort}function cloneSort(e){let r=SortTemplate.toString();let n=new Function(`return ${r}`)();return n(e)}
/**
 * Sort the given array in-place with the given comparator function.
 *
 * @param {Array} ary
 *        An array to sort.
 * @param {function} comparator
 *        Function to use to compare two items.
 */let a=new WeakMap;i.quickSort=function(e,r,n=0){let o=a.get(r);if(o===void 0){o=cloneSort(r);a.set(r,o)}o(e,r,n,e.length-1)};var u=typeof globalThis!=="undefined"?globalThis:typeof self!=="undefined"?self:global;var s={};var l=o;var c=t;var p=e.ArraySet;var g=r;var d=i.quickSort;function SourceMapConsumer$1(e,r){var n=e;typeof e==="string"&&(n=l.parseSourceMapInput(e));return n.sections!=null?new IndexedSourceMapConsumer(n,r):new BasicSourceMapConsumer(n,r)}SourceMapConsumer$1.fromSourceMap=function(e,r){return BasicSourceMapConsumer.fromSourceMap(e,r)};SourceMapConsumer$1.prototype._version=3;SourceMapConsumer$1.prototype.__generatedMappings=null;Object.defineProperty(SourceMapConsumer$1.prototype,"_generatedMappings",{configurable:true,enumerable:true,get:function(){(this||u).__generatedMappings||this._parseMappings((this||u)._mappings,(this||u).sourceRoot);return(this||u).__generatedMappings}});SourceMapConsumer$1.prototype.__originalMappings=null;Object.defineProperty(SourceMapConsumer$1.prototype,"_originalMappings",{configurable:true,enumerable:true,get:function(){(this||u).__originalMappings||this._parseMappings((this||u)._mappings,(this||u).sourceRoot);return(this||u).__originalMappings}});SourceMapConsumer$1.prototype._charIsMappingSeparator=function SourceMapConsumer_charIsMappingSeparator(e,r){var n=e.charAt(r);return n===";"||n===","};SourceMapConsumer$1.prototype._parseMappings=function SourceMapConsumer_parseMappings(e,r){throw new Error("Subclasses must implement _parseMappings")};SourceMapConsumer$1.GENERATED_ORDER=1;SourceMapConsumer$1.ORIGINAL_ORDER=2;SourceMapConsumer$1.GREATEST_LOWER_BOUND=1;SourceMapConsumer$1.LEAST_UPPER_BOUND=2;
/**
 * Iterate over each mapping between an original source/line/column and a
 * generated line/column in this source map.
 *
 * @param Function aCallback
 *        The function that is called with each mapping.
 * @param Object aContext
 *        Optional. If specified, this object will be the value of `this` every
 *        time that `aCallback` is called.
 * @param aOrder
 *        Either `SourceMapConsumer.GENERATED_ORDER` or
 *        `SourceMapConsumer.ORIGINAL_ORDER`. Specifies whether you want to
 *        iterate over the mappings sorted by the generated file's line/column
 *        order or the original's source/line/column order, respectively. Defaults to
 *        `SourceMapConsumer.GENERATED_ORDER`.
 */SourceMapConsumer$1.prototype.eachMapping=function SourceMapConsumer_eachMapping(e,r,n){var o=r||null;var t=n||SourceMapConsumer$1.GENERATED_ORDER;var i;switch(t){case SourceMapConsumer$1.GENERATED_ORDER:i=(this||u)._generatedMappings;break;case SourceMapConsumer$1.ORIGINAL_ORDER:i=(this||u)._originalMappings;break;default:throw new Error("Unknown order of iteration.")}var a=(this||u).sourceRoot;var s=e.bind(o);var c=(this||u)._names;var p=(this||u)._sources;var g=(this||u)._sourceMapURL;for(var d=0,h=i.length;d<h;d++){var m=i[d];var f=m.source===null?null:p.at(m.source);f=l.computeSourceURL(a,f,g);s({source:f,generatedLine:m.generatedLine,generatedColumn:m.generatedColumn,originalLine:m.originalLine,originalColumn:m.originalColumn,name:m.name===null?null:c.at(m.name)})}};SourceMapConsumer$1.prototype.allGeneratedPositionsFor=function SourceMapConsumer_allGeneratedPositionsFor(e){var r=l.getArg(e,"line");var n={source:l.getArg(e,"source"),originalLine:r,originalColumn:l.getArg(e,"column",0)};n.source=this._findSourceIndex(n.source);if(n.source<0)return[];var o=[];var t=this._findMapping(n,(this||u)._originalMappings,"originalLine","originalColumn",l.compareByOriginalPositions,c.LEAST_UPPER_BOUND);if(t>=0){var i=(this||u)._originalMappings[t];if(e.column===void 0){var a=i.originalLine;while(i&&i.originalLine===a){o.push({line:l.getArg(i,"generatedLine",null),column:l.getArg(i,"generatedColumn",null),lastColumn:l.getArg(i,"lastGeneratedColumn",null)});i=(this||u)._originalMappings[++t]}}else{var s=i.originalColumn;while(i&&i.originalLine===r&&i.originalColumn==s){o.push({line:l.getArg(i,"generatedLine",null),column:l.getArg(i,"generatedColumn",null),lastColumn:l.getArg(i,"lastGeneratedColumn",null)});i=(this||u)._originalMappings[++t]}}}return o};s.SourceMapConsumer=SourceMapConsumer$1;function BasicSourceMapConsumer(e,r){var n=e;typeof e==="string"&&(n=l.parseSourceMapInput(e));var o=l.getArg(n,"version");var t=l.getArg(n,"sources");var i=l.getArg(n,"names",[]);var a=l.getArg(n,"sourceRoot",null);var s=l.getArg(n,"sourcesContent",null);var c=l.getArg(n,"mappings");var g=l.getArg(n,"file",null);if(o!=(this||u)._version)throw new Error("Unsupported version: "+o);a&&(a=l.normalize(a));t=t.map(String).map(l.normalize).map((function(e){return a&&l.isAbsolute(a)&&l.isAbsolute(e)?l.relative(a,e):e}));(this||u)._names=p.fromArray(i.map(String),true);(this||u)._sources=p.fromArray(t,true);(this||u)._absoluteSources=(this||u)._sources.toArray().map((function(e){return l.computeSourceURL(a,e,r)}));(this||u).sourceRoot=a;(this||u).sourcesContent=s;(this||u)._mappings=c;(this||u)._sourceMapURL=r;(this||u).file=g}BasicSourceMapConsumer.prototype=Object.create(SourceMapConsumer$1.prototype);BasicSourceMapConsumer.prototype.consumer=SourceMapConsumer$1;BasicSourceMapConsumer.prototype._findSourceIndex=function(e){var r=e;(this||u).sourceRoot!=null&&(r=l.relative((this||u).sourceRoot,r));if((this||u)._sources.has(r))return(this||u)._sources.indexOf(r);var n;for(n=0;n<(this||u)._absoluteSources.length;++n)if((this||u)._absoluteSources[n]==e)return n;return-1};
/**
 * Create a BasicSourceMapConsumer from a SourceMapGenerator.
 *
 * @param SourceMapGenerator aSourceMap
 *        The source map that will be consumed.
 * @param String aSourceMapURL
 *        The URL at which the source map can be found (optional)
 * @returns BasicSourceMapConsumer
 */BasicSourceMapConsumer.fromSourceMap=function SourceMapConsumer_fromSourceMap(e,r){var n=Object.create(BasicSourceMapConsumer.prototype);var o=n._names=p.fromArray(e._names.toArray(),true);var t=n._sources=p.fromArray(e._sources.toArray(),true);n.sourceRoot=e._sourceRoot;n.sourcesContent=e._generateSourcesContent(n._sources.toArray(),n.sourceRoot);n.file=e._file;n._sourceMapURL=r;n._absoluteSources=n._sources.toArray().map((function(e){return l.computeSourceURL(n.sourceRoot,e,r)}));var i=e._mappings.toArray().slice();var a=n.__generatedMappings=[];var u=n.__originalMappings=[];for(var s=0,c=i.length;s<c;s++){var g=i[s];var h=new Mapping;h.generatedLine=g.generatedLine;h.generatedColumn=g.generatedColumn;if(g.source){h.source=t.indexOf(g.source);h.originalLine=g.originalLine;h.originalColumn=g.originalColumn;g.name&&(h.name=o.indexOf(g.name));u.push(h)}a.push(h)}d(n.__originalMappings,l.compareByOriginalPositions);return n};BasicSourceMapConsumer.prototype._version=3;Object.defineProperty(BasicSourceMapConsumer.prototype,"sources",{get:function(){return(this||u)._absoluteSources.slice()}});function Mapping(){(this||u).generatedLine=0;(this||u).generatedColumn=0;(this||u).source=null;(this||u).originalLine=null;(this||u).originalColumn=null;(this||u).name=null}const h=l.compareByGeneratedPositionsDeflatedNoLine;function sortGenerated(e,r){let n=e.length;let o=e.length-r;if(!(o<=1))if(o==2){let n=e[r];let o=e[r+1];if(h(n,o)>0){e[r]=o;e[r+1]=n}}else if(o<20)for(let o=r;o<n;o++)for(let n=o;n>r;n--){let r=e[n-1];let o=e[n];if(h(r,o)<=0)break;e[n-1]=o;e[n]=r}else d(e,h,r)}BasicSourceMapConsumer.prototype._parseMappings=function SourceMapConsumer_parseMappings(e,r){var n=1;var o=0;var t=0;var i=0;var a=0;var s=0;var c=e.length;var p=0;var h={};var m=[];var f=[];var S,_,C,v;let M=0;while(p<c)if(e.charAt(p)===";"){n++;p++;o=0;sortGenerated(f,M);M=f.length}else if(e.charAt(p)===",")p++;else{S=new Mapping;S.generatedLine=n;for(C=p;C<c;C++)if(this._charIsMappingSeparator(e,C))break;e.slice(p,C);_=[];while(p<C){g.decode(e,p,h);v=h.value;p=h.rest;_.push(v)}if(_.length===2)throw new Error("Found a source, but no line and column");if(_.length===3)throw new Error("Found a source and line, but no column");S.generatedColumn=o+_[0];o=S.generatedColumn;if(_.length>1){S.source=a+_[1];a+=_[1];S.originalLine=t+_[2];t=S.originalLine;S.originalLine+=1;S.originalColumn=i+_[3];i=S.originalColumn;if(_.length>4){S.name=s+_[4];s+=_[4]}}f.push(S);if(typeof S.originalLine==="number"){let e=S.source;while(m.length<=e)m.push(null);m[e]===null&&(m[e]=[]);m[e].push(S)}}sortGenerated(f,M);(this||u).__generatedMappings=f;for(var y=0;y<m.length;y++)m[y]!=null&&d(m[y],l.compareByOriginalPositionsNoSource);(this||u).__originalMappings=[].concat(...m)};BasicSourceMapConsumer.prototype._findMapping=function SourceMapConsumer_findMapping(e,r,n,o,t,i){if(e[n]<=0)throw new TypeError("Line must be greater than or equal to 1, got "+e[n]);if(e[o]<0)throw new TypeError("Column must be greater than or equal to 0, got "+e[o]);return c.search(e,r,t,i)};BasicSourceMapConsumer.prototype.computeColumnSpans=function SourceMapConsumer_computeColumnSpans(){for(var e=0;e<(this||u)._generatedMappings.length;++e){var r=(this||u)._generatedMappings[e];if(e+1<(this||u)._generatedMappings.length){var n=(this||u)._generatedMappings[e+1];if(r.generatedLine===n.generatedLine){r.lastGeneratedColumn=n.generatedColumn-1;continue}}r.lastGeneratedColumn=Infinity}};BasicSourceMapConsumer.prototype.originalPositionFor=function SourceMapConsumer_originalPositionFor(e){var r={generatedLine:l.getArg(e,"line"),generatedColumn:l.getArg(e,"column")};var n=this._findMapping(r,(this||u)._generatedMappings,"generatedLine","generatedColumn",l.compareByGeneratedPositionsDeflated,l.getArg(e,"bias",SourceMapConsumer$1.GREATEST_LOWER_BOUND));if(n>=0){var o=(this||u)._generatedMappings[n];if(o.generatedLine===r.generatedLine){var t=l.getArg(o,"source",null);if(t!==null){t=(this||u)._sources.at(t);t=l.computeSourceURL((this||u).sourceRoot,t,(this||u)._sourceMapURL)}var i=l.getArg(o,"name",null);i!==null&&(i=(this||u)._names.at(i));return{source:t,line:l.getArg(o,"originalLine",null),column:l.getArg(o,"originalColumn",null),name:i}}}return{source:null,line:null,column:null,name:null}};BasicSourceMapConsumer.prototype.hasContentsOfAllSources=function BasicSourceMapConsumer_hasContentsOfAllSources(){return!!(this||u).sourcesContent&&((this||u).sourcesContent.length>=(this||u)._sources.size()&&!(this||u).sourcesContent.some((function(e){return e==null})))};BasicSourceMapConsumer.prototype.sourceContentFor=function SourceMapConsumer_sourceContentFor(e,r){if(!(this||u).sourcesContent)return null;var n=this._findSourceIndex(e);if(n>=0)return(this||u).sourcesContent[n];var o=e;(this||u).sourceRoot!=null&&(o=l.relative((this||u).sourceRoot,o));var t;if((this||u).sourceRoot!=null&&(t=l.urlParse((this||u).sourceRoot))){var i=o.replace(/^file:\/\//,"");if(t.scheme=="file"&&(this||u)._sources.has(i))return(this||u).sourcesContent[(this||u)._sources.indexOf(i)];if((!t.path||t.path=="/")&&(this||u)._sources.has("/"+o))return(this||u).sourcesContent[(this||u)._sources.indexOf("/"+o)]}if(r)return null;throw new Error('"'+o+'" is not in the SourceMap.')};BasicSourceMapConsumer.prototype.generatedPositionFor=function SourceMapConsumer_generatedPositionFor(e){var r=l.getArg(e,"source");r=this._findSourceIndex(r);if(r<0)return{line:null,column:null,lastColumn:null};var n={source:r,originalLine:l.getArg(e,"line"),originalColumn:l.getArg(e,"column")};var o=this._findMapping(n,(this||u)._originalMappings,"originalLine","originalColumn",l.compareByOriginalPositions,l.getArg(e,"bias",SourceMapConsumer$1.GREATEST_LOWER_BOUND));if(o>=0){var t=(this||u)._originalMappings[o];if(t.source===n.source)return{line:l.getArg(t,"generatedLine",null),column:l.getArg(t,"generatedColumn",null),lastColumn:l.getArg(t,"lastGeneratedColumn",null)}}return{line:null,column:null,lastColumn:null}};s.BasicSourceMapConsumer=BasicSourceMapConsumer;function IndexedSourceMapConsumer(e,r){var n=e;typeof e==="string"&&(n=l.parseSourceMapInput(e));var o=l.getArg(n,"version");var t=l.getArg(n,"sections");if(o!=(this||u)._version)throw new Error("Unsupported version: "+o);(this||u)._sources=new p;(this||u)._names=new p;var i={line:-1,column:0};(this||u)._sections=t.map((function(e){if(e.url)throw new Error("Support for url field in sections not implemented.");var n=l.getArg(e,"offset");var o=l.getArg(n,"line");var t=l.getArg(n,"column");if(o<i.line||o===i.line&&t<i.column)throw new Error("Section offsets must be ordered and non-overlapping.");i=n;return{generatedOffset:{generatedLine:o+1,generatedColumn:t+1},consumer:new SourceMapConsumer$1(l.getArg(e,"map"),r)}}))}IndexedSourceMapConsumer.prototype=Object.create(SourceMapConsumer$1.prototype);IndexedSourceMapConsumer.prototype.constructor=SourceMapConsumer$1;IndexedSourceMapConsumer.prototype._version=3;Object.defineProperty(IndexedSourceMapConsumer.prototype,"sources",{get:function(){var e=[];for(var r=0;r<(this||u)._sections.length;r++)for(var n=0;n<(this||u)._sections[r].consumer.sources.length;n++)e.push((this||u)._sections[r].consumer.sources[n]);return e}});IndexedSourceMapConsumer.prototype.originalPositionFor=function IndexedSourceMapConsumer_originalPositionFor(e){var r={generatedLine:l.getArg(e,"line"),generatedColumn:l.getArg(e,"column")};var n=c.search(r,(this||u)._sections,(function(e,r){var n=e.generatedLine-r.generatedOffset.generatedLine;return n||e.generatedColumn-r.generatedOffset.generatedColumn}));var o=(this||u)._sections[n];return o?o.consumer.originalPositionFor({line:r.generatedLine-(o.generatedOffset.generatedLine-1),column:r.generatedColumn-(o.generatedOffset.generatedLine===r.generatedLine?o.generatedOffset.generatedColumn-1:0),bias:e.bias}):{source:null,line:null,column:null,name:null}};IndexedSourceMapConsumer.prototype.hasContentsOfAllSources=function IndexedSourceMapConsumer_hasContentsOfAllSources(){return(this||u)._sections.every((function(e){return e.consumer.hasContentsOfAllSources()}))};IndexedSourceMapConsumer.prototype.sourceContentFor=function IndexedSourceMapConsumer_sourceContentFor(e,r){for(var n=0;n<(this||u)._sections.length;n++){var o=(this||u)._sections[n];var t=o.consumer.sourceContentFor(e,true);if(t||t==="")return t}if(r)return null;throw new Error('"'+e+'" is not in the SourceMap.')};IndexedSourceMapConsumer.prototype.generatedPositionFor=function IndexedSourceMapConsumer_generatedPositionFor(e){for(var r=0;r<(this||u)._sections.length;r++){var n=(this||u)._sections[r];if(n.consumer._findSourceIndex(l.getArg(e,"source"))!==-1){var o=n.consumer.generatedPositionFor(e);if(o){var t={line:o.line+(n.generatedOffset.generatedLine-1),column:o.column+(n.generatedOffset.generatedLine===o.line?n.generatedOffset.generatedColumn-1:0)};return t}}}return{line:null,column:null}};IndexedSourceMapConsumer.prototype._parseMappings=function IndexedSourceMapConsumer_parseMappings(e,r){(this||u).__generatedMappings=[];(this||u).__originalMappings=[];for(var n=0;n<(this||u)._sections.length;n++){var o=(this||u)._sections[n];var t=o.consumer._generatedMappings;for(var i=0;i<t.length;i++){var a=t[i];var s=o.consumer._sources.at(a.source);s=l.computeSourceURL(o.consumer.sourceRoot,s,(this||u)._sourceMapURL);(this||u)._sources.add(s);s=(this||u)._sources.indexOf(s);var c=null;if(a.name){c=o.consumer._names.at(a.name);(this||u)._names.add(c);c=(this||u)._names.indexOf(c)}var p={source:s,generatedLine:a.generatedLine+(o.generatedOffset.generatedLine-1),generatedColumn:a.generatedColumn+(o.generatedOffset.generatedLine===a.generatedLine?o.generatedOffset.generatedColumn-1:0),originalLine:a.originalLine,originalColumn:a.originalColumn,name:c};(this||u).__generatedMappings.push(p);typeof p.originalLine==="number"&&(this||u).__originalMappings.push(p)}}d((this||u).__generatedMappings,l.compareByGeneratedPositionsDeflated);d((this||u).__originalMappings,l.compareByOriginalPositions)};s.IndexedSourceMapConsumer=IndexedSourceMapConsumer;var m=typeof globalThis!=="undefined"?globalThis:typeof self!=="undefined"?self:global;var f={};var S=n.SourceMapGenerator;var _=o;var C=/(\r?\n)/;var v=10;var M="$$$isSourceNode$$$";
/**
 * SourceNodes provide a way to abstract over interpolating/concatenating
 * snippets of generated JavaScript source code while maintaining the line and
 * column information associated with the original source code.
 *
 * @param aLine The original line number.
 * @param aColumn The original column number.
 * @param aSource The original source's filename.
 * @param aChunks Optional. An array of strings which are snippets of
 *        generated JS, or other SourceNodes.
 * @param aName The original identifier.
 */function SourceNode$1(e,r,n,o,t){(this||m).children=[];(this||m).sourceContents={};(this||m).line=e==null?null:e;(this||m).column=r==null?null:r;(this||m).source=n==null?null:n;(this||m).name=t==null?null:t;(this||m)[M]=true;o!=null&&this.add(o)}
/**
 * Creates a SourceNode from generated code and a SourceMapConsumer.
 *
 * @param aGeneratedCode The generated code
 * @param aSourceMapConsumer The SourceMap for the generated code
 * @param aRelativePath Optional. The path that relative sources in the
 *        SourceMapConsumer should be relative to.
 */SourceNode$1.fromStringWithSourceMap=function SourceNode_fromStringWithSourceMap(e,r,n){var o=new SourceNode$1;var t=e.split(C);var i=0;var shiftNextLine=function(){var e=getNextLine();var r=getNextLine()||"";return e+r;function getNextLine(){return i<t.length?t[i++]:void 0}};var a=1,u=0;var s=null;r.eachMapping((function(e){if(s!==null){if(!(a<e.generatedLine)){var r=t[i]||"";var n=r.substr(0,e.generatedColumn-u);t[i]=r.substr(e.generatedColumn-u);u=e.generatedColumn;addMappingWithCode(s,n);s=e;return}addMappingWithCode(s,shiftNextLine());a++;u=0}while(a<e.generatedLine){o.add(shiftNextLine());a++}if(u<e.generatedColumn){r=t[i]||"";o.add(r.substr(0,e.generatedColumn));t[i]=r.substr(e.generatedColumn);u=e.generatedColumn}s=e}),this||m);if(i<t.length){s&&addMappingWithCode(s,shiftNextLine());o.add(t.splice(i).join(""))}r.sources.forEach((function(e){var t=r.sourceContentFor(e);if(t!=null){n!=null&&(e=_.join(n,e));o.setSourceContent(e,t)}}));return o;function addMappingWithCode(e,r){if(e===null||e.source===void 0)o.add(r);else{var t=n?_.join(n,e.source):e.source;o.add(new SourceNode$1(e.originalLine,e.originalColumn,t,r,e.name))}}};
/**
 * Add a chunk of generated JS to this source node.
 *
 * @param aChunk A string snippet of generated JS code, another instance of
 *        SourceNode, or an array where each member is one of those things.
 */SourceNode$1.prototype.add=function SourceNode_add(e){if(Array.isArray(e))e.forEach((function(e){this.add(e)}),this||m);else{if(!e[M]&&typeof e!=="string")throw new TypeError("Expected a SourceNode, string, or an array of SourceNodes and strings. Got "+e);e&&(this||m).children.push(e)}return this||m};
/**
 * Add a chunk of generated JS to the beginning of this source node.
 *
 * @param aChunk A string snippet of generated JS code, another instance of
 *        SourceNode, or an array where each member is one of those things.
 */SourceNode$1.prototype.prepend=function SourceNode_prepend(e){if(Array.isArray(e))for(var r=e.length-1;r>=0;r--)this.prepend(e[r]);else{if(!e[M]&&typeof e!=="string")throw new TypeError("Expected a SourceNode, string, or an array of SourceNodes and strings. Got "+e);(this||m).children.unshift(e)}return this||m};
/**
 * Walk over the tree of JS snippets in this node and its children. The
 * walking function is called once for each snippet of JS and is passed that
 * snippet and the its original associated source's line/column location.
 *
 * @param aFn The traversal function.
 */SourceNode$1.prototype.walk=function SourceNode_walk(e){var r;for(var n=0,o=(this||m).children.length;n<o;n++){r=(this||m).children[n];r[M]?r.walk(e):r!==""&&e(r,{source:(this||m).source,line:(this||m).line,column:(this||m).column,name:(this||m).name})}};
/**
 * Like `String.prototype.join` except for SourceNodes. Inserts `aStr` between
 * each of `this.children`.
 *
 * @param aSep The separator.
 */SourceNode$1.prototype.join=function SourceNode_join(e){var r;var n;var o=(this||m).children.length;if(o>0){r=[];for(n=0;n<o-1;n++){r.push((this||m).children[n]);r.push(e)}r.push((this||m).children[n]);(this||m).children=r}return this||m};
/**
 * Call String.prototype.replace on the very right-most source snippet. Useful
 * for trimming whitespace from the end of a source node, etc.
 *
 * @param aPattern The pattern to replace.
 * @param aReplacement The thing to replace the pattern with.
 */SourceNode$1.prototype.replaceRight=function SourceNode_replaceRight(e,r){var n=(this||m).children[(this||m).children.length-1];n[M]?n.replaceRight(e,r):typeof n==="string"?(this||m).children[(this||m).children.length-1]=n.replace(e,r):(this||m).children.push("".replace(e,r));return this||m};
/**
 * Set the source content for a source file. This will be added to the SourceMapGenerator
 * in the sourcesContent field.
 *
 * @param aSourceFile The filename of the source file
 * @param aSourceContent The content of the source file
 */SourceNode$1.prototype.setSourceContent=function SourceNode_setSourceContent(e,r){(this||m).sourceContents[_.toSetString(e)]=r};
/**
 * Walk over the tree of SourceNodes. The walking function is called for each
 * source file content and is passed the filename and source content.
 *
 * @param aFn The traversal function.
 */SourceNode$1.prototype.walkSourceContents=function SourceNode_walkSourceContents(e){for(var r=0,n=(this||m).children.length;r<n;r++)(this||m).children[r][M]&&(this||m).children[r].walkSourceContents(e);var o=Object.keys((this||m).sourceContents);for(r=0,n=o.length;r<n;r++)e(_.fromSetString(o[r]),(this||m).sourceContents[o[r]])};SourceNode$1.prototype.toString=function SourceNode_toString(){var e="";this.walk((function(r){e+=r}));return e};SourceNode$1.prototype.toStringWithSourceMap=function SourceNode_toStringWithSourceMap(e){var r={code:"",line:1,column:0};var n=new S(e);var o=false;var t=null;var i=null;var a=null;var u=null;this.walk((function(e,s){r.code+=e;if(s.source!==null&&s.line!==null&&s.column!==null){t===s.source&&i===s.line&&a===s.column&&u===s.name||n.addMapping({source:s.source,original:{line:s.line,column:s.column},generated:{line:r.line,column:r.column},name:s.name});t=s.source;i=s.line;a=s.column;u=s.name;o=true}else if(o){n.addMapping({generated:{line:r.line,column:r.column}});t=null;o=false}for(var l=0,c=e.length;l<c;l++)if(e.charCodeAt(l)===v){r.line++;r.column=0;if(l+1===c){t=null;o=false}else o&&n.addMapping({source:s.source,original:{line:s.line,column:s.column},generated:{line:r.line,column:r.column},name:s.name})}else r.column++}));this.walkSourceContents((function(e,r){n.setSourceContent(e,r)}));return{code:r.code,map:n}};f.SourceNode=SourceNode$1;var y={};y.SourceMapGenerator=n.SourceMapGenerator;y.SourceMapConsumer=s.SourceMapConsumer;y.SourceNode=f.SourceNode;const A=y.SourceMapGenerator,L=y.SourceMapConsumer,w=y.SourceNode;export{L as SourceMapConsumer,A as SourceMapGenerator,w as SourceNode,y as default};

