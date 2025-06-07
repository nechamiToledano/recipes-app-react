var ASPx = ASPx || {};
var dx = dx || {};
(function module(ASPx, dx) {
ASPx.modules = { Utils: module };
if(!ASPx.attachToReady)
 ASPx.attachToReady = function (callback) { ASPx.Evt.AttachEventToElement(window, "load", callback); };
if(!ASPx.attachToLoad)
 ASPx.attachToLoad = function(callback) { ASPx.Evt.AttachEventToDocumentCore("DOMContentLoaded", callback); };
ASPx.EmptyObject = { };
ASPx.FalseFunction = function() { return false; };
ASPx.SSLSecureBlankUrl = '/DXR.axd?r=1_88-pAI4u';
ASPx.EmptyImageUrl = '/DXR.axd?r=1_89-pAI4u';
ASPx.VersionInfo = 'Version=\'20.2.3.0\', File Version=\'20.2.3.20325\', Date Modified=\'06/01/2025 09:39:07\'';
ASPx.Platform = 'ASP';
ASPx.DoctypeMode = 'Xhtml';
ASPx.InvalidDimension = -10000;
ASPx.InvalidPosition = -10000;
ASPx.AbsoluteLeftPosition = -10000;
ASPx.EmptyGuid = "00000000-0000-0000-0000-000000000000";
ASPx.CallbackSeparator = ":";
ASPx.ItemIndexSeparator = "i";
ASPx.CallbackResultPrefix = "/*DX*/";
ASPx.StyleValueEncodedSemicolon = "DXsmcln";
ASPx.AccessibilityEmptyUrl = "javascript:;";
ASPx.AccessibilityPronounceTimeout = 500;
ASPx.MaxMobileWindowWidth = 576;
ASPx.PossibleNumberDecimalSeparators = [",", "."];
ASPx.CultureInfo = {
 twoDigitYearMax: 2029,
 ts: ":",
 ds: "/",
 am: "AM",
 pm: "PM",
 monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
 genMonthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
 abbrMonthNames: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""],
 abbrDayNames: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
 dayNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
 invariantCultureDecimalPoint: ".",
 numDecimalPoint: ".",
 numPrec: 2,
 numGroupSeparator: ",", 
 numGroups: [ 3 ],
 numNegPattern: 1,
 numPosInf: "Infinity", 
 numNegInf: "-Infinity", 
 numNan: "NaN",
 currency: "$",
 currDecimalPoint: ".",
 currPrec: 2,
 currGroupSeparator: ",",
 currGroups: [ 3 ],
 currPosPattern: 0,
 currNegPattern: 0,
 percentPattern: 0,
 shortTime: "h:mm tt",
 longTime: "h:mm:ss tt",
 shortDate: "M/d/yyyy",
 longDate: "dddd, MMMM d, yyyy",
 monthDay: "MMMM d",
 yearMonth: "MMMM yyyy"
};
ASPx.CultureInfo.genMonthNames = ASPx.CultureInfo.monthNames;
ASPx.Position = {
 Left: "Left",
 Right: "Right",
 Top: "Top",
 Bottom: "Bottom"
};
ASPx.FOCUS_TIMEOUT = 100;
function setInnerHtmlInternal(el, trustedHtmlString) { 
 el.innerHTML = trustedHtmlString;
}
var DateUtils = { };
DateUtils.GetInvariantDateString = function(date) {
 if(!date)
  return "01/01/0001";
 var day = date.getDate();
 var month = date.getMonth() + 1;
 var year = date.getFullYear();
 var result = "";
 if(month < 10)
  result += "0";
 result += month.toString() + "/";
 if(day < 10)
  result += "0";
 result += day.toString() + "/";
 if(year < 1000)
  result += "0";
 result += year.toString();
 return result;
};
DateUtils.GetInvariantDateTimeString = function(date) {
 var dateTimeString = DateUtils.GetInvariantDateString(date);
 var time = {
  h: date.getHours(),
  m: date.getMinutes(),
  s: date.getSeconds()
 };
 for(var key in time) {
  if(time.hasOwnProperty(key)) {
   var str = time[key].toString();
   if(str.length < 2)
    str = "0" + str;
   time[key] = str;
  }
 }
 dateTimeString += " " + time.h + ":" + time.m + ":" + time.s;
 var msec = date.getMilliseconds();
 if(msec > 0)
  dateTimeString += "." + ("000" + msec.toString()).substr(-3);
 return dateTimeString;
};
DateUtils.ExpandTwoDigitYear = function(value) {
 value += 1900;
 if(value + 99 < ASPx.CultureInfo.twoDigitYearMax)
  value += 100;
 return value;  
};
DateUtils.GetTimeZoneOffsetDifference = function(firstDate, secondDate) {
 if(!secondDate)
  secondDate = DateUtils.GetUtcDate(firstDate);
 return 60000 * (firstDate.getTimezoneOffset() - secondDate.getTimezoneOffset());
};
DateUtils.GetTimeZoneOffset = function(date) {
 var isECMA262Support = ASPx.Browser.Chrome && ASPx.Browser.Version >= 67;
 if(!isECMA262Support)
  return date.getTimezoneOffset() * 60000;
 var utcDate = DateUtils.GetUtcDate(date);
 var utcTimezoneOffsetDifference = DateUtils.GetTimeZoneOffsetDifference(date);
 if(utcTimezoneOffsetDifference !== 0)
  utcDate.setTime(utcDate.valueOf() + utcTimezoneOffsetDifference);
 return utcDate - date;
};
DateUtils.GetUtcDate = function(date) {
 var utcFullYear = date.getUTCFullYear();
 var result = new Date(utcFullYear, date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds(), date.getUTCMilliseconds());
 if(utcFullYear < 100)
  result.setFullYear(utcFullYear);
 return result;
};
DateUtils.ToUtcTime = function(date) {
 var result = new Date();
 result.setTime(date.valueOf() + ASPx.DateUtils.GetTimeZoneOffset(date));
 return result;
};
DateUtils.ToLocalTime = function(date) {
 var result = new Date();
 result.setTime(date.valueOf() - ASPx.DateUtils.GetTimeZoneOffset(date));
 return result; 
};
DateUtils.AreDatesEqualExact = function(date1, date2) {
 if(date1 == null && date2 == null)
  return true;
 if(date1 == null || date2 == null)
  return false;
 return date1.getTime() == date2.getTime(); 
};
DateUtils.FixTimezoneGap = function(oldDate, newDate) {
 var diff = newDate.getHours() - oldDate.getHours();
 if(diff == 0)
  return;
 var sign = (diff == 1 || diff == -23) ? -1 : 1;
 var trial = new Date(newDate.getTime() + sign * 3600000);
 var isDateChangedAsExpected = newDate.getHours() - trial.getHours() === diff;
 if(isDateChangedAsExpected && (sign > 0 || trial.getDate() == newDate.getDate()))
  newDate.setTime(trial.getTime());
};
DateUtils.GetDecadeStartYear = function(year) {
 return 10 * Math.floor(year / 10);
};
DateUtils.GetCenturyStartYear = function(year) {
 return 100 * Math.floor(year / 100);
};
DateUtils.GetCorrectedYear = function(date, pickerType) {
 var year = date.getFullYear();
 return pickerType != ASPx.DatePickerType.Decades ? year : DateUtils.GetDecadeStartYear(year);
};
DateUtils.GetCorrectedMonth = function(date, pickerType) {
 return pickerType < ASPx.DatePickerType.Years ? date.getMonth() : 0;
};
DateUtils.GetCorrectedDay = function(date, pickerType) {
 return pickerType == ASPx.DatePickerType.Days ? date.getDate() : 1;
};
DateUtils.CorrectDateByPickerType = function(date, pickerType) {
 if(!ASPx.IsExists(pickerType))
  pickerType = ASPx.DatePickerType.Days;
 if(!date || pickerType == ASPx.DatePickerType.Days)
  return date;
 var correctedYear = DateUtils.GetCorrectedYear(date, pickerType);
 var result = new Date(
  correctedYear,
  DateUtils.GetCorrectedMonth(date, pickerType),
  DateUtils.GetCorrectedDay(date, pickerType),
  date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds()
 );
 result.setFullYear(correctedYear);
 return result;
};
DateUtils.GetYearRangeFormatString = function(startYear, rangeLength) {
 return startYear + " - " + (startYear + rangeLength - 1);
};
ASPx.DateUtils = DateUtils;
var Timer = { };
Timer.ClearTimer = function(timerID){
 if(timerID > -1)
  window.clearTimeout(timerID);
 return -1;
};
Timer.ClearInterval = function(timerID){
 if(timerID > -1)
  window.clearInterval(timerID);
 return -1;
};
var setControlBoundTimer = function(handler, control, setTimerFunction, clearTimerFunction, delay) {
 var timerId;
 var getTimerId = function() { return timerId; };
 var controlMainElement = control.GetMainElement();
 var boundHandler = function() {
  var controlExists = control && ASPx.GetControlCollection().Get(control.name) === control && control.GetMainElement() === controlMainElement;
  if(controlExists)
   handler.aspxBind(control)();
  else {
   clearTimerFunction(getTimerId());
   controlMainElement = null;
  }
 };
 timerId = setTimerFunction(boundHandler, delay);
 return timerId;
};
Timer.SetControlBoundTimeout = function(handler, control, delay) {
 return setControlBoundTimer(handler, control, window.setTimeout, Timer.ClearTimer, delay);
};
Timer.SetControlBoundInterval = function(handler, control, delay) {
 return setControlBoundTimer(handler, control, window.setInterval, Timer.ClearInterval, delay);
};
Timer.Throttle = function(func, delay) {
 var isThrottled = false,
   savedArgs,
   savedThis = this;
 function wrapper() {
  if(isThrottled) {
   savedArgs = arguments;
   savedThis = this;
   return;
  }
  func.apply(this, arguments);
  isThrottled = true;
  setTimeout(function() {
   isThrottled = false;
   if(savedArgs) {
    wrapper.apply(savedThis, savedArgs);
    savedArgs = null;
   }
  }, delay);
 }
 wrapper.cancel = function() {
  clearTimeout(delay);
  delay = savedArgs = savedThis = null;
 };
 return wrapper;
};
ASPx.Timer = Timer;
var Browser = { };
Browser.UserAgent = navigator.userAgent.toLowerCase();
Browser.Mozilla = false;
Browser.IE = false;
Browser.Firefox = false;
Browser.Netscape = false;
Browser.Safari = false;
Browser.Chrome = false;
Browser.Opera = false;
Browser.Edge = false;
Browser.Version = undefined; 
Browser.MajorVersion = undefined; 
Browser.WindowsPlatform = false;
Browser.MacOSPlatform = false;
Browser.MacOSMobilePlatform = false;
Browser.AndroidMobilePlatform = false;
Browser.PlaformMajorVersion = false;
Browser.WindowsPhonePlatform = false;
Browser.AndroidDefaultBrowser = false;
Browser.AndroidChromeBrowser = false;
Browser.SamsungAndroidDevice = false;
Browser.WebKitTouchUI = false;
Browser.MSTouchUI = false;
Browser.TouchUI = false;
Browser.WebKitFamily = false; 
Browser.NetscapeFamily = false; 
Browser.HardwareAcceleration = false;
Browser.VirtualKeyboardSupported = false;
Browser.Info = "";
Browser.IsQuirksMode = document.compatMode === "BackCompat";
function indentPlatformMajorVersion(userAgent) {
 var regex = /(?:(?:windows nt|macintosh|mac os|cpu os|cpu iphone os|android|windows phone|linux) )(\d+)(?:[-0-9_.])*/;
 var matches = regex.exec(userAgent);
 if(matches)
  Browser.PlaformMajorVersion = matches[1];
}
function getIECompatibleVersionString() {
 if(document.compatible) {
  for(var i = 0; i < document.compatible.length; i++)
   if(document.compatible[i].userAgent === "IE" && document.compatible[i].version)
    return document.compatible[i].version.toLowerCase();
 }
 return "";
}
Browser.IdentUserAgent = function(userAgent, ignoreDocumentMode) {
 var browserTypesOrderedList = [ "Mozilla", "IE", "Firefox", "Netscape", "Safari", "Chrome", "Opera", "Opera10", "Edge" ];
 var defaultBrowserType = "IE";
 var defaultPlatform = "Win";
 var defaultVersions = { Safari: 2, Chrome: 0.1, Mozilla: 1.9, Netscape: 8, Firefox: 2, Opera: 9, IE: 6, Edge: 12 };
 if(!userAgent || userAgent.length == 0) {
  fillUserAgentInfo(browserTypesOrderedList, defaultBrowserType, defaultVersions[defaultBrowserType], defaultPlatform);
  return;
 }
 userAgent = userAgent.toLowerCase();
 indentPlatformMajorVersion(userAgent);
 try {
  var platformIdentStrings = {
   "Windows": "Win",
   "Macintosh": "Mac",
   "Mac OS": "Mac",
   "Mac_PowerPC": "Mac",
   "cpu os": "MacMobile",
   "cpu iphone os": "MacMobile",
   "Android": "Android",
   "!Windows Phone": "WinPhone",
   "!WPDesktop": "WinPhone",
   "!ZuneWP": "WinPhone"
  };
  var optSlashOrSpace = "(?:/|\\s*)?";
  var version = "(\\d+)(?:\\.((?:\\d+?[1-9])|\\d)0*?)?";
  var optVersion = "(?:" + version + ")?";
  var patterns = {
   Safari: "applewebkit(?:.*?(?:version/" + version + "[\\.\\w\\d]*?(?:\\s+mobile\/\\S*)?\\s+safari))?",
   Chrome: "(?:chrome|crios)(?!frame)" + optSlashOrSpace + optVersion,
   Mozilla: "mozilla(?:.*rv:" + optVersion + ".*Gecko)?",
   Netscape: "(?:netscape|navigator)\\d*/?\\s*" + optVersion,
   Firefox: "firefox" + optSlashOrSpace + optVersion,
   Opera: "(?:opera|\sopr)" + optSlashOrSpace + optVersion,
   Opera10: "opera.*\\s*version" + optSlashOrSpace + optVersion,
   IE: "msie\\s*" + optVersion,
   Edge: "edge" + optSlashOrSpace + optVersion
  };
  var browserType;
  var version = -1;
  for(var i = 0; i < browserTypesOrderedList.length; i++) {
   var browserTypeCandidate = browserTypesOrderedList[i];
   var regExp = new RegExp(patterns[browserTypeCandidate], "i");
   if(regExp.compile)
    regExp.compile(patterns[browserTypeCandidate], "i");
   var matches = regExp.exec(userAgent);
   if(matches && matches.index >= 0) {
    if(browserType == "IE" && version >= 11 && browserTypeCandidate == "Safari") 
     continue;
    browserType = browserTypeCandidate;
    if(browserType == "Opera10")
     browserType = "Opera";
    var tridentPattern = "trident" + optSlashOrSpace + optVersion;
    version = Browser.GetBrowserVersion(userAgent, matches, tridentPattern, getIECompatibleVersionString());
    if(browserType == "Mozilla" && version >= 11)
     browserType = "IE";
   }
  }
  if(!browserType)
   browserType = defaultBrowserType;
  var browserVersionDetected = version != -1;
  if(!browserVersionDetected)
   version = defaultVersions[browserType];
  var platform;
  var minOccurenceIndex = Number.MAX_VALUE;
  for(var identStr in platformIdentStrings) {
   if(!platformIdentStrings.hasOwnProperty(identStr)) continue;
   var importantIdent = identStr.substr(0,1) == "!";
   var occurenceIndex = userAgent.indexOf((importantIdent ? identStr.substr(1) : identStr).toLowerCase());
   if(occurenceIndex >= 0 && (occurenceIndex < minOccurenceIndex || importantIdent)) {
    minOccurenceIndex = importantIdent ? 0 : occurenceIndex;
    platform = platformIdentStrings[identStr];
   }
  }
  var samsungPattern = "SM-[A-Z]";
  var matches = userAgent.toUpperCase().match(samsungPattern);
  var isSamsungAndroidDevice = matches && matches.length > 0;
  if(platform == "WinPhone" && version < 9)
   version = Math.floor(getVersionFromTrident(userAgent, "trident" + optSlashOrSpace + optVersion));
  if(!ignoreDocumentMode && browserType == "IE" && version > 7 && document.documentMode < version)
   version = document.documentMode;
  if(platform == "WinPhone")
   version = Math.max(9, version);
  if(!platform)
   platform = defaultPlatform;
  if(platform == platformIdentStrings["cpu os"] && !browserVersionDetected) 
   version = 4;
  fillUserAgentInfo(browserTypesOrderedList, browserType, version, platform, isSamsungAndroidDevice);
 } catch(e) {
  fillUserAgentInfo(browserTypesOrderedList, defaultBrowserType, defaultVersions[defaultBrowserType], defaultPlatform);
 }
};
function getVersionFromMatches(matches) {
 var result = -1;
 var versionStr = "";
 if(matches[1]) {
  versionStr += matches[1];
  if(matches[2])
   versionStr += "." + matches[2];
 }
 if(versionStr != "") {
  result = parseFloat(versionStr);
  if(isNaN(result))
   result = -1;
 }
 return result;
}
function getVersionFromTrident(userAgent, tridentPattern) {
 var tridentDiffFromVersion = 4;
 var matches = new RegExp(tridentPattern, "i").exec(userAgent);
 return getVersionFromMatches(matches) + tridentDiffFromVersion;
}
Browser.GetBrowserVersion = function(userAgent, matches, tridentPattern, ieCompatibleVersionString) {
 var version = getVersionFromMatches(matches);
 if(ieCompatibleVersionString) {
  var versionFromTrident = getVersionFromTrident(userAgent, tridentPattern);
  if(ieCompatibleVersionString === "edge" || parseInt(ieCompatibleVersionString) === versionFromTrident)
   return versionFromTrident;
 }
 return version;
};
function fillUserAgentInfo(browserTypesOrderedList, browserType, version, platform, isSamsungAndroidDevice) {
 for(var i = 0; i < browserTypesOrderedList.length; i++) {
  var type = browserTypesOrderedList[i];
  Browser[type] = type == browserType;
 }
 Browser.Version = Math.floor(10.0 * version) / 10.0;
 Browser.MajorVersion = Math.floor(Browser.Version);
 Browser.WindowsPlatform = platform == "Win" || platform == "WinPhone";
 Browser.MacOSPlatform = platform == "Mac";
 var isMacWithTouchSupport = platform == "Mac" && (!!window.ontouchstart || getMaxTouchPoints() > 0); 
 Browser.MacOSMobilePlatform = platform == "MacMobile" || isMacWithTouchSupport;
 if(Browser.MacOSMobilePlatform)
  Browser.MacOSPlatform = false;
 Browser.AndroidMobilePlatform = platform == "Android";
 Browser.WindowsPhonePlatform = platform == "WinPhone";
 Browser.WebKitFamily = Browser.Safari || Browser.Chrome || Browser.Opera && Browser.MajorVersion >= 15;
 Browser.NetscapeFamily = Browser.Netscape || Browser.Mozilla || Browser.Firefox;
 Browser.HardwareAcceleration = (Browser.IE && Browser.MajorVersion >= 9) || (Browser.Firefox && Browser.MajorVersion >= 4) || 
  (Browser.AndroidMobilePlatform && Browser.Chrome) || (Browser.Chrome && Browser.MajorVersion >= 37) || 
  (Browser.Safari && !Browser.WindowsPlatform) || Browser.Edge || (Browser.Opera && Browser.MajorVersion >= 46);
 Browser.WebKitTouchUI = Browser.MacOSMobilePlatform || Browser.AndroidMobilePlatform;
 var isIETouchUI = Browser.IE && Browser.MajorVersion > 9 && Browser.WindowsPlatform && Browser.UserAgent.toLowerCase().indexOf("touch") >= 0;
 Browser.MSTouchUI = isIETouchUI || (Browser.Edge && !!getMaxTouchPoints());
 Browser.TouchUI = Browser.WebKitTouchUI || Browser.MSTouchUI;
 Browser.MobileUI = Browser.WebKitTouchUI || Browser.WindowsPhonePlatform;
 Browser.AndroidDefaultBrowser = Browser.AndroidMobilePlatform && !Browser.Chrome;
 Browser.AndroidChromeBrowser = Browser.AndroidMobilePlatform && Browser.Chrome;
 if(isSamsungAndroidDevice)
  Browser.SamsungAndroidDevice = isSamsungAndroidDevice;
 if(Browser.MSTouchUI) {
  var isARMArchitecture = Browser.UserAgent.toLowerCase().indexOf("arm;") > -1;    
  Browser.VirtualKeyboardSupported = isARMArchitecture || Browser.WindowsPhonePlatform;   
 } else {
  Browser.VirtualKeyboardSupported = Browser.MobileUI;
 }
 fillDocumentElementBrowserTypeClassNames(browserTypesOrderedList);
}
function getMaxTouchPoints() { 
 var result = navigator.maxTouchPoints;
 if(window.testingTouchMode)
  result = 10;
 return result;
}
function fillDocumentElementBrowserTypeClassNames(browserTypesOrderedList) {
 var documentElementClassName = "";
 var browserTypeslist = browserTypesOrderedList.concat(["WindowsPlatform", "MacOSPlatform", "MacOSMobilePlatform", "AndroidMobilePlatform",
   "WindowsPhonePlatform", "WebKitFamily", "WebKitTouchUI", "MSTouchUI", "TouchUI", "AndroidDefaultBrowser", "MobileUI"]);
 for(var i = 0; i < browserTypeslist.length; i++) {
  var type = browserTypeslist[i];
  if(Browser[type])
   documentElementClassName += "dx" + type + " ";
 }
 documentElementClassName += "dxBrowserVersion-" + Browser.MajorVersion;
 if(document && document.documentElement) {
  if(document.documentElement.className != "")
   documentElementClassName = " " + documentElementClassName;
  document.documentElement.className += documentElementClassName;
  Browser.Info = documentElementClassName;
 }
}
Browser.SupportsStickyPositioning = function() {
 return this.Chrome && this.MajorVersion >= 56
  || this.Firefox && this.MajorVersion >= 32
  || this.Safari && this.MajorVersion >= 6 && this.Version !== "6"
  || this.Opera && this.MajorVersion >= 42;
};
Browser.IdentUserAgent(Browser.UserAgent);
ASPx.Browser = Browser;
ASPx.BlankUrl = Browser.IE ? ASPx.SSLSecureBlankUrl : (Browser.Opera ? "about:blank" : "");
var Data = { };
Data.ArrayInsert = function(array, element, position){
 if(0 <= position && position < array.length){
  for(var i = array.length; i > position; i --)
   array[i] = array[i - 1];
  array[position] = element;
 }
 else
  array.push(element);
};
Data.ArrayRemove = function(array, element){
 var index = Data.ArrayIndexOf(array, element);
 if(index > -1) Data.ArrayRemoveAt(array, index);
};
Data.ArrayRemoveAt = function(array, index){
 if(index >= 0  && index < array.length){
  for(var i = index; i < array.length - 1; i++)
   array[i] = array[i + 1];
  array.pop();
 }
};
Data.ArrayClear = function(array){
 while(array.length > 0)
  array.pop();
};
Data.ArrayIndexOf = function(array, element, comparer) {
 if(!comparer) {
  for(var i = 0; i < array.length; i++) {
   if(array[i] == element)
    return i;
  }
 } else {
  for(var i = 0; i < array.length; i++) {
   if(comparer(array[i], element))
    return i;
  }
 }
 return -1;
};
Data.ArrayContains = function(array, element) { 
 return Data.ArrayIndexOf(array, element) >= 0;
};
Data.ArrayEqual = function(array1, array2) {
 var count1 = array1.length;
 var count2 = array2.length;
 if(count1 != count2)
  return false;
 for(var i = 0; i < count1; i++)
  if(array1[i] != array2[i])
   return false;
 return true;
};
Data.ArraySame = function(array1, array2) {
 if(array1.length !== array2.length)
  return false;
 return array1.every(function(elem) { return Data.ArrayContains(array2, elem); });
};
Data.ArrayGetIntegerEdgeValues = function(array) {
 var arrayToSort = Data.CollectionToArray(array);
 Data.ArrayIntegerAscendingSort(arrayToSort);
 return {
  start: arrayToSort[0],
  end: arrayToSort[arrayToSort.length - 1]
 };
};
Data.ArrayIntegerAscendingSort = function(array){
 Data.ArrayIntegerSort(array);
};
Data.ArrayIntegerSort = function(array, desc) {
 array.sort(function(i1, i2) {
  var res = 0;
  if(i1 > i2)
   res = 1;
  else if(i1 < i2)
   res = -1;
  if(desc)
   res *= -1;
  return res;
 });
};
Data.CollectionsUnionToArray = function(firstCollection, secondCollection) {
 var result = [];
 var firstCollectionLength = firstCollection.length;
 var secondCollectionLength = secondCollection.length;
 for(var i = 0; i < firstCollectionLength + secondCollectionLength; i++) {
  if(i < firstCollectionLength)
   result.push(firstCollection[i]);
  else
   result.push(secondCollection[i - firstCollectionLength]);
 }
 return result;
};
Data.CollectionToArray = function(collection) {
 var array = [];
 for(var i = 0; i < collection.length; i++)
  array.push(collection[i]);
 return array;
};
Data.CreateHashTableFromArray = function(array) {
 var hash = [];
 for(var i = 0; i < array.length; i++)
  hash[array[i]] = 1;
 return hash;
};
Data.CreateIndexHashTableFromArray = function(array) {
 var hash = [];
 for(var i = 0; i < array.length; i++)
  hash[array[i]] = i;
 return hash;
};
Data.ArrayToHash = function(array, getKeyFunc, getValueFunc) {
 if(!(array instanceof Array)) 
  return { };
 return array.reduce(function(map, element, index) { 
  var key = getKeyFunc(element, index);
  var value = getValueFunc(element, index);
  map[key] = value;
  return map; 
 }, { });
};
Data.Sum = function(array, getValueFunc) {
 if(!(array instanceof Array)) 
  return 0;
 return array.reduce(function(prevValue, item) {
  var value = getValueFunc ? getValueFunc(item) : item;
  if(!ASPx.IsNumber(value))
   value = 0;
  return prevValue + value;
 }, 0);
};
Data.Min = function(array, getValueFunc) { return CalculateArrayMinMax(array, getValueFunc, false); };
Data.Max = function(array, getValueFunc) { return CalculateArrayMinMax(array, getValueFunc, true); };
var CalculateArrayMinMax = function(array, getValueFunc, isMax) {
 if(!(array instanceof Array)) 
  return 0;
 var startValue = isMax ? Number.NEGATIVE_INFINITY : Number.POSITIVE_INFINITY;
 return array.reduce(function(prevValue, item) {
  var value = getValueFunc ? getValueFunc(item) : item;
  if(!ASPx.IsNumber(value))
   value = startValue;
  var func = isMax ? Math.max : Math.min;
  return func(value, prevValue);
 }, startValue);
};
var defaultBinarySearchComparer = function(array, index, value) {
 var arrayElement = array[index];
 if(arrayElement == value)
  return 0;
 else
  return arrayElement < value ? -1 : 1;
};
Data.NearestLeftBinarySearchComparer = function(array, index, value) { 
 var arrayElement = array[index];
 var leftPoint = arrayElement < value;
 var lastLeftPoint = leftPoint && index == array.length - 1;
 var nearestLeftPoint = lastLeftPoint || (leftPoint && array[index + 1] >= value);
 if(nearestLeftPoint)
  return 0;
 else
  return arrayElement < value ? -1 : 1;
};
Data.ArrayBinarySearch = function(array, value, binarySearchComparer, startIndex, length) {
 if(!binarySearchComparer)
  binarySearchComparer = defaultBinarySearchComparer;
 if(!ASPx.IsExists(startIndex))
  startIndex = 0;
 if(!ASPx.IsExists(length))
  length = array.length - startIndex;
 var endIndex = (startIndex + length) - 1;
 while(startIndex <= endIndex) {
  var middle = (startIndex + ((endIndex - startIndex) >> 1));
  var compareResult = binarySearchComparer(array, middle, value);
  if(compareResult == 0)
   return middle;
  if(compareResult < 0)
   startIndex = middle + 1;
  else
   endIndex = middle - 1;
 }
 return -(startIndex + 1);
};
Data.ArrayFlatten = function(arrayOfArrays) {
 return [].concat.apply([], arrayOfArrays);
};
Data.GetDistinctArray = function(array) {
 var resultArray = [];
 for(var i = 0; i < array.length; i++) {
  var currentEntry = array[i];
  if(Data.ArrayIndexOf(resultArray, currentEntry) == -1) {
   resultArray.push(currentEntry);
  }
 }
 return resultArray;
};
Data.ForEach = function(arr, callback) {
 if(Array.prototype.forEach) {
  Array.prototype.forEach.call(arr, callback);
 } else {
  for(var i = 0, len = arr.length; i < len; i++) {
   callback(arr[i], i, arr);
  }
 }
};
Data.MergeHashTables = function(target, object) {
 if(!object || typeof (object) == "string")
  return target;
 if(!target)
  target = {};
 for(var key in object)
  if(key && !(key in target))
   target[key] = object[key];
 return target;
};
Data.Range = function(count, start) {
 count = parseInt(count) || 0;
 start = parseInt(start) || 0;
 if(count < 0) count = 0;
 if(start < 0) start = 0;
 return Array.apply(null, Array(count)).map(function(val, i) { return start + i; });
};
ASPx.Data = Data;
var Cookie = { };
Cookie.DelCookie = function(name){
 setCookieInternal(name, "", new Date(1970, 1, 1));
};
Cookie.GetCookie = function(name) {
 name = escape(name);
 var cookies = document.cookie.split(';');
 for(var i = 0; i < cookies.length; i++) {
  var cookie = Str.Trim(cookies[i]);
  if(cookie.indexOf(name + "=") == 0)
   return unescape(cookie.substring(name.length + 1, cookie.length));
  else if(cookie.indexOf(name + ";") == 0 || cookie === name)
   return "";
 }
 return null;
};
Cookie.SetCookie = function(name, value, expirationDate){
 if(!ASPx.IsExists(value)) {
  Cookie.DelCookie(name);
  return;
 }
 if(!ASPx.Ident.IsDate(expirationDate)) {
  expirationDate = new Date();
  expirationDate.setFullYear(expirationDate.getFullYear() + 1);
 }
 setCookieInternal(name, value, expirationDate);
};
function setCookieInternal(name, value, date){
 document.cookie = escape(name) + "=" + escape(value.toString()) + "; expires=" + date.toGMTString() + "; path=/";
}
ASPx.Cookie = Cookie;
ASPx.ImageUtils = {
 GetImageSrc: function (image){
  return image.src;
 },
 SetImageSrc: function(image, src){
  if(isSourceResetRequired())
   image.src = "";
  image.src = src;
 },
 SetSize: function(image, width, height){
  image.style.width = width + "px";
  image.style.height = height + "px";
 },
 GetSize: function(image, isWidth) {
  return (isWidth ? ASPx.GetElementOffsetWidth(image) : ASPx.GetElementOffsetHeight(image));
 }
};
var Str = { };
Str.ApplyReplacement = function(text, replecementTable) {
 if(typeof(text) != "string")
  text = text.toString();
 for(var i = 0; i < replecementTable.length; i++) {
  var replacement = replecementTable[i];
  text = text.replace(replacement[0], replacement[1]);
 }
 return text;
};
Str.CompleteReplace = function(text, regexp, newSubStr) {
 if(typeof(text) != "string")
  text = text.toString();
 var textPrev;
 do {
  textPrev = text;
  text = text.replace(regexp, newSubStr);
 } while(text != textPrev);
 return text;
};
Str.EncodeHtml = function(html) {
 return Str.ApplyReplacement(html, [
  [ /&amp;/g,  '&ampx;'  ], [ /&/g, '&amp;'  ],
  [ /&quot;/g, '&quotx;' ], [ /"/g, '&quot;' ],
  [ /&lt;/g,   '&ltx;'   ], [ /</g, '&lt;'   ],
  [ /&gt;/g,   '&gtx;'   ], [ />/g, '&gt;'   ]
 ]);
};
Str.DecodeHtml = function(html) {
 return Str.ApplyReplacement(html, [
  [ /&gt;/g,   '>' ], [ /&gtx;/g,  '&gt;'   ],
  [ /&lt;/g,   '<' ], [ /&ltx;/g,  '&lt;'   ],
  [ /&quot;/g, '"' ], [ /&quotx;/g,'&quot;' ],
  [ /&amp;/g,  '&' ], [ /&ampx;/g, '&amp;'  ]
 ]);
};
Str.DecodeHtmlViaTextArea = function(html) {
 var textArea = document.createElement("TEXTAREA");
 setInnerHtmlInternal(textArea, html);
 return textArea.value;
};
Str.TrimStart = function(str) { 
 return trimInternal(str, true);
};
Str.TrimEnd = function(str) { 
 return trimInternal(str, false, true);
};
Str.Trim = function(str) { 
 return trimInternal(str, true, true); 
};
Str.EscapeForRegEx = function(str) {
 return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
};
var whiteSpaces = { 
 0x0009: 1, 0x000a: 1, 0x000b: 1, 0x000c: 1, 0x000d: 1, 0x0020: 1, 0x0085: 1, 
 0x00a0: 1, 0x1680: 1, 0x180e: 1, 0x2000: 1, 0x2001: 1, 0x2002: 1, 0x2003: 1, 
 0x2004: 1, 0x2005: 1, 0x2006: 1, 0x2007: 1, 0x2008: 1, 0x2009: 1, 0x200a: 1, 
 0x200b: 1, 0x2028: 1, 0x2029: 1, 0x202f: 1, 0x205f: 1, 0x3000: 1
};
var caretWidth = 1;
function trimInternal(source, trimStart, trimEnd) {
 var len = source.length;
 if(!len)
  return source;
 var result = "";
 if(len < 0xBABA1) 
  result = trimSource(source, trimStart, trimEnd);
 else
  result = trimLargeSource(source, len, trimStart, trimEnd);
 return Str.ClearString(result);
}
function trimSource(source, trimStart, trimEnd) {
 var result = source;
 if(trimStart)
  result = result.replace(/^\s+/, "");
 if(trimEnd)
  result = result.replace(/\s+$/, "");
 return result;
}
function trimLargeSource(source, len, trimStart, trimEnd) {
 var start = 0;
 if(trimEnd) {
  while(len > 0 && whiteSpaces[source.charCodeAt(len - 1)]) {
   len--;
  }
 }
 if(trimStart && len > 0) {
  while(start < len && whiteSpaces[source.charCodeAt(start)]) {
   start++;
  }
 }
 return source.substring(start, len);
}
var inlineStringLength = 12;
Str.ClearString = function(str) { 
 if(!ASPx.Browser.Chrome)
  return str;
 return str.length < inlineStringLength ? str : JSON.parse(JSON.stringify(str));
};
Str.Insert = function(str, subStr, index) { 
 var leftText = str.slice(0, index);
 var rightText = str.slice(index);
 return leftText + subStr + rightText;
};
Str.InsertEx = function(str, subStr, startIndex, endIndex) { 
 var leftText = str.slice(0, startIndex);
 var rightText = str.slice(endIndex);
 return leftText + subStr + rightText;
};
var greekSLFSigmaChar = String.fromCharCode(962);
var greekSLSigmaChar = String.fromCharCode(963);
Str.PrepareStringForFilter = function(s){
 s = s.toLowerCase();
 if(ASPx.Browser.WebKitFamily) {
  return s.replace(new RegExp(greekSLFSigmaChar, "g"), greekSLSigmaChar);
 }
 return s;
};
Str.GetCoincideCharCount = function(text, filter, textMatchingDelegate) {
 var coincideText = ASPx.Str.PrepareStringForFilter(filter);
 var originText = ASPx.Str.PrepareStringForFilter(text);
 while(coincideText != "" && !textMatchingDelegate(originText, coincideText)) {
  coincideText = coincideText.slice(0, -1);
 }
 return coincideText.length;
};
ASPx.Str = Str;
var Xml = { };
Xml.Parse = function(xmlStr) {
 if(window.DOMParser) {
  var parser = new DOMParser();
  return parser.parseFromString(xmlStr, "text/xml");
 }
 else if(window.ActiveXObject) {
  var xmlDoc = new window.ActiveXObject("Microsoft.XMLDOM");
  if(xmlDoc) {
   xmlDoc.async = false;
   xmlDoc.loadXML(xmlStr);
   return xmlDoc;
  }
 }
 return null;
};
ASPx.Xml = Xml;
ASPx.Key = {
 F1     : 112,
 F2     : 113,
 F3     : 114,
 F4     : 115,
 F5     : 116,
 F6     : 117,
 F7     : 118,
 F8     : 119,
 F9     : 120,
 F10    : 121,
 F11    : 122,
 F12    : 123,
 Ctrl   : 17,
 Shift  : 16,
 Alt    : 18,
 Enter  : 13,
 Home   : 36,
 End    : 35,
 Left   : 37,
 Right  : 39,
 Up     : 38,
 Down   : 40,
 PageUp    : 33,
 PageDown  : 34,
 Esc    : 27,
 Space  : 32,
 Tab    : 9,
 Backspace : 8,
 Delete    : 46,
 Insert    : 45,
 ContextMenu  : 93,
 Windows   : 91,
 Decimal   : 110
};
ASPx.ModifierKey = {
 None: 0,
 Ctrl: 1 << (0 + 16),
 Shift: 1 << (2 + 16),
 Alt: 1 << (4 + 16),
 Meta: 1 << (8 + 16)
};
ASPx.KeyCode = {
 Backspace : 8,
 Tab    : 9,
 Enter  : 13,
 Pause  : 19,
 CapsLock  : 20,
 Esc    : 27,
 Space  : 32,
 PageUp    : 33,
 PageDown  : 34,
 End    : 35,
 Home   : 36,
 Left   : 37,
 Up     : 38,
 Right  : 39,
 Down   : 40,
 Insert    : 45,
 Delete    : 46,
 Key_0  : 48,
 Key_1  : 49,
 Key_2  : 50,
 Key_3  : 51,
 Key_4  : 52,
 Key_5  : 53,
 Key_6  : 54,
 Key_7  : 55,
 Key_8  : 56,
 Key_9  : 57,
 Key_a  : 65,
 Key_b  : 66,
 Key_c  : 67,
 Key_d  : 68,
 Key_e  : 69,
 Key_f  : 70,
 Key_g  : 71,
 Key_h  : 72,
 Key_i  : 73,
 Key_j  : 74,
 Key_k  : 75,
 Key_l  : 76,
 Key_m  : 77,
 Key_n  : 78,
 Key_o  : 79,
 Key_p  : 80,
 Key_q  : 81,
 Key_r  : 82,
 Key_s  : 83,
 Key_t  : 84,
 Key_u  : 85,
 Key_v  : 86,
 Key_w  : 87,
 Key_x  : 88,
 Key_y  : 89,
 Key_z  : 90,
 Windows   : 91,
 ContextMenu  : 93,
 Numpad_0  : 96,
 Numpad_1  : 97,
 Numpad_2  : 98,
 Numpad_3  : 99,
 Numpad_4  : 100,
 Numpad_5  : 101,
 Numpad_6  : 102,
 Numpad_7  : 103,
 Numpad_8  : 104,
 Numpad_9  : 105,
 Multiply  : 106,
 Add    : 107,
 Subtract  : 109,
 Decimal   : 110,
 Divide    : 111,
 F1     : 112,
 F2     : 113,
 F3     : 114,
 F4     : 115,
 F5     : 116,
 F6     : 117,
 F7     : 118,
 F8     : 119,
 F9     : 120,
 F10    : 121,
 F11    : 122,
 F12    : 123,
 NumLock   : 144,
 ScrollLock   : 145,
 Semicolon : 186,
 Equals    : 187,
 Comma  : 188,
 Dash   : 189,
 Period    : 190,
 ForwardSlash : 191,
 GraveAccent  : 192,
 OpenBracket  : 219,
 BackSlash : 220,
 CloseBracket : 221,
 SingleQuote  : 222
};
ASPx.ScrollBarMode = { Hidden: 0, Visible: 1, Auto: 2 };
ASPx.ColumnResizeMode = { None: 0, Control: 1, NextColumn: 2 };
var Selection = { };
Selection.Set = function(input, startPos, endPos, scrollToSelection, isApi) {
 if(!ASPx.IsExistsElement(input))
  return;
 var isInputFocused = ASPx.GetActiveElement() === input;
 var isInputNativeFocusLocked = ASPx.VirtualKeyboardUI.getInputNativeFocusLocked();
 if(!isApi && Browser.VirtualKeyboardSupported && (!isInputFocused || isInputNativeFocusLocked))
  return;
 var textLen = input.value.length;
 startPos = ASPx.GetDefinedValue(startPos, 0);
 endPos = ASPx.GetDefinedValue(endPos, textLen);
 if(startPos < 0)
  startPos = 0;
 if(endPos < 0 || endPos > textLen)
  endPos = textLen;
 if(startPos > endPos)
  startPos = endPos;
 var makeReadOnly = false;
 if(Browser.WebKitFamily && input.readOnly) {
  input.readOnly = false;
  makeReadOnly = true;
 }
 try {
  if(Browser.Firefox && Browser.Version >= 8) 
   input.setSelectionRange(startPos, endPos, "backward");
  else if(Browser.IE && input.createTextRange) {
   var range = input.createTextRange();
   range.collapse(true);
   range.moveStart("character", startPos);
   range.moveEnd("character", endPos - startPos);
   range.select();
  } else {
   forceScrollToSelectionRange(input, startPos, endPos);
   input.setSelectionRange(startPos, endPos);
  }
  if(Browser.Opera || Browser.Firefox || Browser.Chrome || Browser.Edge) 
   input.focus();
 } catch(e) { }
 if(scrollToSelection && input.tagName == 'TEXTAREA') {
  var scrollHeight = input.scrollHeight;
  var approxCaretPos = startPos;
  var scrollTop = Math.max(Math.round(approxCaretPos * scrollHeight / textLen  - input.clientHeight / 2), 0);
  input.scrollTop = scrollTop;
 }
 if(makeReadOnly)
  input.readOnly = true;
};
var getTextWidthBeforePos = function(input, pos) {
 return ASPx.GetSizeOfText(input.value.toString().substr(0, pos), ASPx.GetCurrentStyle(input)).width;
};
var forceScrollToSelectionRange = function(input, startPos, endPos) {
 if(endPos === input.value.length)
  input.scrollLeft = input.scrollWidth;
 else if(startPos === 0 && endPos === 0)
  input.scrollLeft = 0;
 else {
  var inputRawWidth = ASPx.GetElementOffsetWidth(input) - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(input);
  if(inputRawWidth < input.scrollWidth) {
   var widthBeforeEndPos = getTextWidthBeforePos(input, endPos) + caretWidth;
   if(input.scrollLeft < widthBeforeEndPos - inputRawWidth)
    input.scrollLeft = widthBeforeEndPos - inputRawWidth;
   else {
    var widthBeforeStartPos = getTextWidthBeforePos(input, startPos) - caretWidth;
    if(input.scrollLeft > widthBeforeStartPos)
     input.scrollLeft = widthBeforeStartPos;
   }
  }
 }
};
Selection.GetInfo = function(input) {
 var start, end;
 if(Browser.IE && Browser.Version < 9) {
  var range = document.selection.createRange();
  var rangeCopy = range.duplicate();
  range.move('character', -input.value.length);
  range.setEndPoint('EndToStart', rangeCopy);
  start = range.text.length;
  end = start + rangeCopy.text.length;
 } else {
  try {
   start = input.selectionStart;
   end = input.selectionEnd;
  } catch (e) {
  }
 }
 return { startPos: start, endPos: end };
};
Selection.GetExtInfo = function(input) {
 var start = 0, end = 0, textLen = 0;
 if(Browser.IE && Browser.Version < 9) {
  var normalizedValue;
  var range, textInputRange, textInputEndRange;
  range = document.selection.createRange();
  if(range && range.parentElement() == input) {
   textLen = input.value.length;
   normalizedValue = input.value.replace(/\r\n/g, "\n");
   textInputRange = input.createTextRange();
   textInputRange.moveToBookmark(range.getBookmark());
   textInputEndRange = input.createTextRange();
   textInputEndRange.collapse(false);
   if(textInputRange.compareEndPoints("StartToEnd", textInputEndRange) > -1) {
    start = textLen;
    end = textLen;
   } else {
    start = normalizedValue.slice(0, start).split("\n").length - textInputRange.moveStart("character", -textLen) -1;
    if(textInputRange.compareEndPoints("EndToEnd", textInputEndRange) > -1)
     end = textLen;
    else
     end = normalizedValue.slice(0, end).split("\n").length - textInputRange.moveEnd("character", -textLen) - 1;    
   }
  }
  return {startPos: start, endPos: end};
 }
 try {
  start = input.selectionStart;
  end = input.selectionEnd;
 } catch (e) {
 }
 return {startPos: start, endPos: end}; 
};
Selection.SetCaretPosition = function(input, caretPos) {
 if(typeof caretPos === "undefined" || caretPos < 0)
  caretPos = input.value.length;
 Selection.Set(input, caretPos, caretPos, true);
};
Selection.GetCaretPosition = function(element, isDialogMode) {
 var pos = 0;
 if("selectionStart" in element) {
  pos = element.selectionStart;
 } else if("selection" in document) {
  element.focus();
  var sel = document.selection.createRange(),
   selLength = document.selection.createRange().text.length;
  sel.moveStart("character", -element.value.length);
  pos = sel.text.length - selLength;
 }
 if(isDialogMode && !pos) {
  pos = element.value.length - 1;
 }
 return pos;
};
Selection.Clear = function() {
 try {
  if(window.getSelection) {
   window.getSelection().removeAllRanges();
  }
  else if(document.selection) {
   if(document.selection.empty)
    document.selection.empty();
   else if(document.selection.clear)
    document.selection.clear();
  }
 } catch(e) {
 }
};
Selection.ClearOnMouseMove = function(evt) {
 if(!Browser.IE || (evt.button != 0)) 
  Selection.Clear();
};
Selection.SetElementSelectionEnabled = function(element, value) {
 var userSelectValue = value ? "" : "none";
 var func = value ? Evt.DetachEventFromElement : Evt.AttachEventToElement;
 if(Browser.Firefox)
  element.style.MozUserSelect = userSelectValue;
 else if(Browser.WebKitFamily)
  element.style.webkitUserSelect = userSelectValue;
 else if(Browser.IE && Browser.Version > 10 || Browser.Edge)
  element.style.msUserSelect = userSelectValue;
 else if(Browser.Opera)
  func(element, "mousemove", Selection.Clear);
 else {
  func(element, "selectstart", ASPx.FalseFunction);
  func(element, "mousemove", Selection.Clear);
 }
};
Selection.SetElementAsUnselectable = function(element, isWithChild, recursive) {
 if(element && element.nodeType == 1) {
  element.unselectable = "on";
  if(Browser.NetscapeFamily)
   element.onmousedown = ASPx.FalseFunction;
  if((Browser.IE && Browser.Version >= 9) || Browser.WebKitFamily)
   Evt.AttachEventToElement(element, "mousedown", Evt.PreventEventAndBubble);
  if(isWithChild === true){
   for(var j = 0; j < element.childNodes.length; j ++)
    Selection.SetElementAsUnselectable(element.childNodes[j], (!!recursive ? true : false), (!!recursive));
  }
 }
};
Selection.AreEqual = function(selection1, selection2) {
 return selection1.startPos === selection2.startPos && selection1.endPos === selection2.endPos;
};
ASPx.Selection = Selection;
var MouseScroller = { };
MouseScroller.MinimumOffset = 10;
MouseScroller.Create = function(getElement, getScrollXElement, getScrollYElement, needPreventScrolling, vertRecursive, onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed) {
 var element = getElement();
 if(!element) 
  return;
 if(!element.dxMouseScroller)
  element.dxMouseScroller = new MouseScroller.Extender(getElement, getScrollXElement, getScrollYElement, needPreventScrolling, vertRecursive, onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed);
 return element.dxMouseScroller;
};
MouseScroller.Extender = function(getElement, getScrollXElement, getScrollYElement, needPreventScrolling, vertRecursive, onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed) {
 this.getElement = getElement;
 this.getScrollXElement = getScrollXElement;
 this.getScrollYElement = getScrollYElement;
 this.needPreventScrolling = needPreventScrolling;
 this.vertRecursive = !!vertRecursive;
 this.createHandlers(onMouseDown || function() { }, onMouseMove || function() { }, onMouseUp || function() { }, onMouseUpMissed || function() { });
 this.update();
};
MouseScroller.Extender.prototype = {
 update: function() {
  if(this.element)
   Evt.DetachEventFromElement(this.element, ASPx.TouchUIHelper.touchMouseDownEventName, this.mouseDownHandler);
  this.element = this.getElement();
  Evt.AttachEventToElement(this.element, ASPx.TouchUIHelper.touchMouseDownEventName, this.mouseDownHandler);  
  Evt.AttachEventToElement(this.element, "click", this.mouseClickHandler);   
  if(Browser.MSTouchUI && this.element.className.indexOf(ASPx.TouchUIHelper.msTouchDraggableClassName) < 0)
   this.element.className += " " + ASPx.TouchUIHelper.msTouchDraggableClassName;
  this.scrollXElement = this.getScrollXElement();
  this.scrollYElement = this.getScrollYElement();
 },
 createHandlers: function(onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed) {
  var mouseDownCounter = 0;
  this.onMouseDown = onMouseDown;
  this.onMouseMove = onMouseMove;
  this.onMouseUp = onMouseUp;  
  this.mouseDownHandler = function(e) {
   if(mouseDownCounter++ > 0) {
    this.finishScrolling();
    onMouseUpMissed();
   }
   var eventSource = Evt.GetEventSource(e);
   var requirePreventCustonScroll = ASPx.IsExists(ASPx.TouchUIHelper.RequirePreventCustomScroll) && ASPx.TouchUIHelper.RequirePreventCustomScroll(eventSource, this.element);
   this.requirePreventScroll = requirePreventCustonScroll || this.needPreventScrolling && this.needPreventScrolling(eventSource);
   if(this.requirePreventScroll)
    return;
   this.scrollableTreeLine = this.GetScrollableElements();
   this.firstX = this.prevX = Evt.GetEventX(e);
   this.firstY = this.prevY = Evt.GetEventY(e);
   Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseMoveEventName, this.mouseMoveHandler);
   Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, this.mouseUpHandler);
   this.onMouseDown(e);
  }.aspxBind(this);
  this.mouseMoveHandler = function(e) {
   if(ASPx.TouchUIHelper.isGesture)
    return;
   var x = Evt.GetEventX(e);
   var y = Evt.GetEventY(e);
   var xDiff = this.prevX - x;
   var yDiff = this.prevY - y;
   if(this.vertRecursive) {
    var isTopDirection = yDiff < 0;
    this.scrollYElement = this.GetElementForVertScrolling(isTopDirection, this.prevIsTopDirection, this.scrollYElement);
    this.prevIsTopDirection = isTopDirection;
   }
   if(this.scrollXElement && xDiff != 0)
    this.scrollXElement.scrollLeft += xDiff;
   if(this.scrollYElement && yDiff != 0) {
    this.scrollYElement.scrollTop += yDiff;
    var isOuterScrollableElement = this.scrollableTreeLine[this.scrollableTreeLine.length - 1] == this.scrollYElement;
    if(isOuterScrollableElement)
     y += yDiff;
   }
   this.prevX = x;
   this.prevY = y;
   Evt.PreventEvent(e);
   this.onMouseMove(e);
  }.aspxBind(this);
  this.mouseUpHandler = function(e) {
   this.finishScrolling();
   this.onMouseUp(e);
  }.aspxBind(this);
  this.mouseClickHandler = function(e){
   if(this.requirePreventScroll || (ASPx.IsExists(e.isTrusted) && !e.isTrusted))
    return;
   var xDiff = this.firstX - Evt.GetEventX(e);
   var yDiff = this.firstY - Evt.GetEventY(e);
   if(xDiff > MouseScroller.MinimumOffset || yDiff > MouseScroller.MinimumOffset)
    return Evt.PreventEventAndBubble(e);
  }.aspxBind(this);
  this.finishScrolling = function() {
   Evt.DetachEventFromDocument(ASPx.TouchUIHelper.touchMouseMoveEventName, this.mouseMoveHandler);
   Evt.DetachEventFromDocument(ASPx.TouchUIHelper.touchMouseUpEventName, this.mouseUpHandler);
   this.scrollableTreeLine = [];
   this.prevIsTopDirection = null;
   mouseDownCounter--;
  };
 },
 GetScrollableElements: function() {
  if(!this.vertRecursive) return [ ];
  var isHtmlScrollableElement = !ASPx.Browser.IsQuirksMode && !ASPx.Browser.Safari;
  var outerScrollableElementTag = isHtmlScrollableElement ? "HTML" : "BODY";
  return ASPx.GetElementTreeLine(this.element, null, function(el) { return el == document; })
   .filter(function(el) {
    var tagName = el.tagName;
    if(isHtmlScrollableElement && tagName == "BODY")
     return false;
    return ASPx.IsScrollableElement(el, false, true) || tagName == outerScrollableElementTag || el.dxScrollable;
   }.bind(this));
 },
 GetElementForVertScrolling: function(currentIsTop, prevIsTop, prevElement) {
  if(prevElement && currentIsTop === prevIsTop && this.GetVertScrollExcess(prevElement, currentIsTop) > 0)
   return prevElement;
  for(var i = 0; i < this.scrollableTreeLine.length; i++) {
   var element = this.scrollableTreeLine[i];
   var excess = this.GetVertScrollExcess(element, currentIsTop);
   if(excess > 0)
    return element;
  }
  return null;
 },
 GetVertScrollExcess: function(element, isTop) {
  if(isTop)
   return element.scrollTop;
  var isDocument = element.tagName == "HTML" || ASPx.Browser.Safari && !ASPx.Browser.IsQuirksMode && element.tagName == "BODY";
  var clientHeight = isDocument ? ASPx.GetDocumentClientHeight() : element.clientHeight;
  return element.scrollHeight - clientHeight - element.scrollTop;
 }
};
ASPx.MouseScroller = MouseScroller;
var Evt = { };
Evt.GetEvent = function(evt){
 return (typeof(event) != "undefined" && event != null && Browser.IE) ? event : evt; 
};
Evt.IsEventPrevented = function(evt) {
 return evt.defaultPrevented || evt.returnValue === false;
};
Evt.PreventEvent = function(evt){
 if(evt.preventDefault) {
  if(evt.cancelable)
   evt.preventDefault();
 }
 else
  evt.returnValue = false;
 return false;
};
Evt.PreventEventAndBubble = function(evt){
 Evt.PreventEvent(evt);
 if(evt.stopPropagation)
  evt.stopPropagation();
 evt.cancelBubble = true;
 return false;
};
Evt.CancelBubble = function(evt){
 evt.stopPropagation();
 return false;
};
Evt.PreventImageDragging = function(image) {
 if(image)
  image.ondragstart = function() { return false; };
};
Evt.PreventDragStart = function(evt) {
 evt = Evt.GetEvent(evt);
 var element = Evt.GetEventSource(evt);
 if(element.releaseCapture)
  element.releaseCapture(); 
 return false;
};
Evt.PreventElementDrag = function(element) {
 if(Browser.IE)
  Evt.AttachEventToElement(element, "dragstart", Evt.PreventEvent);
 else
  Evt.AttachEventToElement(element, "mousedown", Evt.PreventEvent);
};
Evt.PreventElementDragAndSelect = function(element, skipMouseMove, skipIESelect){
 if(Browser.WebKitFamily)
  Evt.AttachEventToElement(element, "selectstart", Evt.PreventEventAndBubble);
 if(Browser.IE){
  if(!skipIESelect)
   Evt.AttachEventToElement(element, "selectstart", ASPx.FalseFunction);
  if(!skipMouseMove)
   Evt.AttachEventToElement(element, "mousemove", Selection.ClearOnMouseMove);
  Evt.AttachEventToElement(element, "dragstart", Evt.PreventDragStart);
 }
};
Evt.GetEventSource = function(evt){
 if(!ASPx.IsExists(evt)) return null; 
 return evt.srcElement ? evt.srcElement : evt.target;
};
Evt.GetKeyCode = function(srcEvt) {
 return Browser.NetscapeFamily || Browser.Opera ? srcEvt.which : srcEvt.keyCode;
};
function clientEventRequiresDocScrollCorrection() {
 var isSafariVerLess3 = Browser.Safari && Browser.Version < 3,
  isMacOSMobileVerLess51 = Browser.MacOSMobilePlatform && Browser.Version < 5.1;
 return Browser.AndroidDefaultBrowser || Browser.AndroidChromeBrowser || !(isSafariVerLess3 || isMacOSMobileVerLess51);
}
Evt.GetEventX = function(evt){
 if(ASPx.TouchUIHelper.isTouchEvent(evt))
  return ASPx.TouchUIHelper.getEventX(evt);
 return evt.clientX + (clientEventRequiresDocScrollCorrection() ? ASPx.GetDocumentScrollLeft() : 0);
};
Evt.GetEventY = function(evt){
 if(ASPx.TouchUIHelper.isTouchEvent(evt))
  return ASPx.TouchUIHelper.getEventY(evt);
 return evt.clientY + (clientEventRequiresDocScrollCorrection() ? ASPx.GetDocumentScrollTop() : 0 );
};
Evt.IsLeftButtonPressed = function(evt) {
 if(ASPx.TouchUIHelper.isTouchEvent(evt))
  return true;
 evt = Evt.GetEvent(evt);
 if(!evt) return false;
 if(Browser.IE && Browser.Version < 11) {
  if(Browser.MSTouchUI)
   return true;
  return evt.button % 2 == 1; 
 } else if(Browser.WebKitFamily) {
  if(evt.type === "pointermove")
   return evt.buttons === 1;
  return evt.which == 1;
 } else if(Browser.NetscapeFamily || Browser.Edge || (Browser.IE && Browser.Version >= 11)) {
  if(evt.type === ASPx.TouchUIHelper.touchMouseMoveEventName)
   return evt.buttons === 1;
  return evt.which == 1;
 } else if(Browser.Opera)
  return evt.button == 0;
 return true;
};
Evt.IsRightButtonPressed = function(evt){
 evt = Evt.GetEvent(evt);
 if(!ASPx.IsExists(evt)) return false;
 if(Browser.IE || Browser.Edge) {
  if(evt.type === "pointermove")
   return evt.buttons === 2;
  return evt.button == 2;
 }
 else if(Browser.NetscapeFamily || Browser.WebKitFamily)
  return evt.which == 3;
 else if (Browser.Opera)
  return evt.button == 1;
 return true;
};
Evt.GetWheelDelta = function(evt) {
 var ret;
 if(Browser.NetscapeFamily && Browser.MajorVersion < 17)
  ret = -evt.detail;
 else if(Browser.Safari)
  ret = evt.wheelDelta;
 else
  ret = -evt.deltaY;
 if(Browser.Opera && Browser.Version < 9)
  ret = -ret;
 return ret;
};
Evt.IsWheelEventWithDirection = function(evt) {
 return ASPx.Data.ArrayContains(["wheel", "mousewheel"], evt.type);
};
Evt.GetWheelDeltaX = function(evt) {
 if(evt.type === "wheel")
  return -evt.deltaX;
 if(evt.type === "mousewheel")
  return evt.wheelDeltaX;
};
Evt.GetWheelDeltaY = function(evt) {
 if(evt.type === "wheel")
  return -evt.deltaY;
 if(evt.type === "mousewheel")
  return evt.wheelDeltaY;
};
Evt.IsPassiveListenersSupported = function() {
 if(Browser.Chrome && Browser.MajorVersion > 69 || Browser.Edge && Browser.MajorVersion > 15 || Browser.Firefox && Browser.MajorVersion > 62)
  return true;
 if(Evt.isPassiveListenersSupported === undefined) {
  Evt.isPassiveListenersSupported = false;
  try {
   var options = Object.defineProperty({}, "passive", { get: function() { Evt.isPassiveListenersSupported = true; } });
   window.addEventListener("test", options, options);
   window.removeEventListener("test", options, options);
  }
  catch(err) { Evt.isPassiveListenersSupported = false; }
 }
 return !!Evt.isPassiveListenersSupported;
};
Evt.AttachEventToElement = function(element, eventName, func, onlyBubbling, passive) {
 if(element.addEventListener)
  element.addEventListener(eventName, func, Evt.IsPassiveListenersSupported() ? { capture: !onlyBubbling, passive: !!passive } : !onlyBubbling);
 else
  element.attachEvent("on" + eventName, func);
};
Evt.DetachEventFromElement = function(element, eventName, func, onlyBubbling) {
 if(element.removeEventListener)
  element.removeEventListener(eventName, func, Evt.IsPassiveListenersSupported() ? { capture: !onlyBubbling } : !onlyBubbling);
 else
  element.detachEvent("on" + eventName, func);
};
Evt.AttachEventToDocument = function(eventName, func) {
 var attachingAllowed = ASPx.TouchUIHelper.onEventAttachingToDocument(eventName, func);
 if(attachingAllowed)
  Evt.AttachEventToDocumentCore(eventName, func);
};
Evt.AttachEventToDocumentCore = function(eventName, func) {
 Evt.AttachEventToElement(document, eventName, func);
};
Evt.DetachEventFromDocument = function(eventName, func) {
 Evt.DetachEventFromDocumentCore(eventName, func);
 ASPx.TouchUIHelper.onEventDettachedFromDocument(eventName, func);
};
Evt.DetachEventFromDocumentCore = function(eventName, func){
 Evt.DetachEventFromElement(document, eventName, func);
};
Evt.GetMouseWheelEventName = function() {
 if(Browser.Safari)
  return "mousewheel";
 if(Browser.NetscapeFamily && Browser.MajorVersion < 17)
  return "DOMMouseScroll";
 return "wheel";
};
Evt.AttachMouseEnterToElement = function (element, onMouseOverHandler, onMouseOutHandler) {
 Evt.AttachEventToElement(element, ASPx.TouchUIHelper.pointerEnabled ? ASPx.TouchUIHelper.pointerOverEventName : "mouseover", function (evt) { mouseEnterHandler(evt, element, onMouseOverHandler, onMouseOutHandler); });
 Evt.AttachEventToElement(element, ASPx.TouchUIHelper.pointerEnabled ? ASPx.TouchUIHelper.pointerOutEventName : "mouseout", function (evt) { mouseEnterHandler(evt, element, onMouseOverHandler, onMouseOutHandler); });
};
Evt.GetEventRelatedTarget = function(evt, isMouseOverEvent) {
 return evt.relatedTarget || (isMouseOverEvent ? evt.srcElement : evt.toElement);
};
function mouseEnterHandler(evt, element, onMouseOverHandler, onMouseOutHandler) {
 var isMouseOverExecuted = !!element.dxMouseOverExecuted;
 var isMouseOverEvent = (evt.type == "mouseover" || evt.type == ASPx.TouchUIHelper.pointerOverEventName);
 if(isMouseOverEvent && isMouseOverExecuted || !isMouseOverEvent && !isMouseOverExecuted)
  return;
 var source = Evt.GetEventRelatedTarget(evt, isMouseOverEvent);
 if(!ASPx.GetIsParent(element, source)) {
  element.dxMouseOverExecuted = isMouseOverEvent;
  if(isMouseOverEvent)
   onMouseOverHandler(element);
  else
   onMouseOutHandler(element);
 }
 else if(isMouseOverEvent && !isMouseOverExecuted) {
  element.dxMouseOverExecuted = true;
  onMouseOverHandler(element);
 }
}
Evt.DispatchEvent = function(target, eventName, canBubble, cancellable) {
 var event;
 if(Browser.IE && Browser.Version < 9) {
  eventName = "on" + eventName;
  if(eventName in target) {
   event = document.createEventObject();
   target.fireEvent("on" + eventName, event);
  }
 } else {
  event = document.createEvent("Event");
  event.initEvent(eventName, canBubble || false, cancellable || false);
  target.dispatchEvent(event);
 }
};
Evt.EmulateDocumentOnMouseDown = function(evt) {
 Evt.EmulateOnMouseDown(document, evt);
};
Evt.EmulateOnMouseDown = function(element, evt) {
 if(Browser.IE && Browser.Version < 9)
  element.fireEvent("onmousedown", evt);
 else if(!Browser.WebKitFamily){
  var emulatedEvt = document.createEvent("MouseEvents");
  emulatedEvt.initMouseEvent("mousedown", true, true, window, 0, evt.screenX, evt.screenY, 
   evt.clientX, evt.clientY, evt.ctrlKey, evt.altKey, evt.shiftKey, false, 0, null);
  element.dispatchEvent(emulatedEvt);
 }
};
Evt.EmulateOnMouseEvent = function (type, element, evt) {
 evt.type = type;
 var emulatedEvt = document.createEvent("MouseEvents");
 emulatedEvt.initMouseEvent(type, true, true, window, 0, evt.screenX, evt.screenY,
  evt.clientX, evt.clientY, evt.ctrlKey, evt.altKey, evt.shiftKey, false, 0, null);
 emulatedEvt.target = element;
 element.dispatchEvent(emulatedEvt);
};
Evt.EmulateMouseClick = function (element, evt) {
 var x = ASPx.GetElementOffsetWidth(element) / 2;
 var y = ASPx.GetElementOffsetHeight(element) / 2;
 if (!evt)
  evt = {
   bubbles: true,
   cancelable: true,
   view: window,
   detail: 1,
   screenX: 0,
   screenY: 0,
   clientX: x,
   clientY: y,
   ctrlKey: false,
   altKey: false,
   shiftKey: false,
   metaKey: false,
   button: 0,
   relatedTarget: null
  };
 Evt.EmulateOnMouseEvent("mousedown", element, evt);
 Evt.EmulateOnMouseEvent("mouseup", element, evt);
 Evt.EmulateOnMouseEvent("click", element, evt);
};
Evt.DoElementClick = function(element) {
 try{
  element.click();
 }
 catch(e){ 
 }
};
Evt.IsActionKeyPressed = function(evt) {
 return evt.keyCode === ASPx.Key.Space ||
     evt.keyCode === ASPx.Key.Enter ||
    (evt.keyCode === ASPx.Key.Down && evt.altKey);
};
Evt.InvokeMouseClickByKeyDown = function(evt, handler) {
 if(Evt.IsActionKeyPressed(evt)) {
  ASPx.Evt.PreventEvent(evt); 
  if(!handler)
   ASPx.Evt.GetEventSource(evt).onclick();
  else
   handler(evt);
 }
};
Evt.AttachContextMenuToElement = function (element, handler, onlyBubbling) {
 if (ASPx.TouchUIHelper.useLongTapHelper())
  element.detachContextMenuEventHandler = ASPx.TouchUIHelper.attachLongTapHandler(element, handler, onlyBubbling);
 else
  Evt.AttachEventToElement(element, "contextmenu", handler, onlyBubbling);
};
Evt.DetachContextMenuFromElement = function (element, handler) {
 if (element.detachContextMenuEventHandler)
  element.detachContextMenuEventHandler();
 else
  Evt.DetachEventFromElement(element, "contextmenu", handler);
};
Evt.PreventContextMenuOnElement = function(element) {
 Evt.AttachContextMenuToElement(element, function(evt) {
  Evt.PreventEvent(evt);
 });
};
ASPx.Evt = Evt;
var Attr = { };
Attr.GetAttribute = function(obj, attrName){
 if(obj.getAttribute)
  return obj.getAttribute(attrName);
 else if(obj.getPropertyValue) {
  if(Browser.Firefox) { 
   try {
    return obj.getPropertyValue(attrName);
   } catch(e) {
    return obj[attrName];
   }
  }
  return obj.getPropertyValue(attrName);
 }
 return null;
};
Attr.SetAttribute = function(obj, attrName, value){
 if(obj.setAttribute) {
  if(isSourceResetRequired() && attrName.toLowerCase() === "src") 
   obj.setAttribute(attrName, "");
  obj.setAttribute(attrName, value);
 } else if(obj.setProperty)
  obj.setProperty(attrName, value, "");
};
Attr.ToggleAttribute = function(obj, attrName, value, condition) {
 if(condition)
  Attr.SetAttribute(obj, attrName, value);
 else
  Attr.RemoveAttribute(obj, attrName);
};
Attr.RemoveAttribute = function(obj, attrName){
 if(obj.removeAttribute)
  obj.removeAttribute(attrName);
 else if(obj.removeProperty)
  obj.removeProperty(attrName);
};
Attr.IsExistsAttribute = function(obj, attrName){
 var value = Attr.GetAttribute(obj, attrName);
 return (value != null) && (value !== "");
};
Attr.SetOrRemoveAttribute = function(obj, attrName, value) {
 if(!value)
  Attr.RemoveAttribute(obj, attrName);
 else
  Attr.SetAttribute(obj, attrName, value);
};
Attr.SaveAttribute = function(obj, attrName, savedObj, savedAttrName){
 if(!Attr.IsExistsAttribute(savedObj, savedAttrName)){
  var oldValue = Attr.IsExistsAttribute(obj, attrName) ? Attr.GetAttribute(obj, attrName) : ASPx.EmptyObject;
  Attr.SetAttribute(savedObj, savedAttrName, oldValue);
 }
};
Attr.SaveStyleAttribute = function(obj, attrName){
 Attr.SaveAttribute(obj.style, attrName, obj, "saved" + attrName);
};
Attr.ChangeAttributeExtended = function(obj, attrName, savedObj, savedAttrName, newValue){
 Attr.SaveAttribute(obj, attrName, savedObj, savedAttrName);
 Attr.SetAttribute(obj, attrName, newValue);
};
Attr.ChangeAttribute = function(obj, attrName, newValue){
 Attr.ChangeAttributeExtended(obj, attrName, obj, "saved" + attrName, newValue);
};
Attr.ChangeStyleAttribute = function(obj, attrName, newValue){
 Attr.ChangeAttributeExtended(obj.style, attrName, obj, "saved" + attrName, newValue);
};
Attr.ResetAttributeExtended = function(obj, attrName, savedObj, savedAttrName){
 Attr.SaveAttribute(obj, attrName, savedObj, savedAttrName);
 Attr.SetAttribute(obj, attrName, "");
 Attr.RemoveAttribute(obj, attrName);
};
Attr.ResetAttribute = function(obj, attrName){
 Attr.ResetAttributeExtended(obj, attrName, obj, "saved" + attrName);
};
Attr.ResetStyleAttribute = function(obj, attrName){
 Attr.ResetAttributeExtended(obj.style, attrName, obj, "saved" + attrName);
};
Attr.RestoreAttributeExtended = function(obj, attrName, savedObj, savedAttrName){
 if(Attr.IsExistsAttribute(savedObj, savedAttrName)){
  var oldValue = Attr.GetAttribute(savedObj, savedAttrName);
  if(oldValue != ASPx.EmptyObject)
   Attr.SetAttribute(obj, attrName, oldValue);
  else
   Attr.RemoveAttribute(obj, attrName);
  Attr.RemoveAttribute(savedObj, savedAttrName);
  return true;
 }
 return false;
};
Attr.RestoreAttribute = function(obj, attrName){
 return Attr.RestoreAttributeExtended(obj, attrName, obj, "saved" + attrName);
};
Attr.RestoreStyleAttribute = function(obj, attrName){
 return Attr.RestoreAttributeExtended(obj.style, attrName, obj, "saved" + attrName);
};
Attr.CopyAllAttributes = function(sourceElem, destElement) {
 var attrs = sourceElem.attributes;
 for(var n = 0; n < attrs.length; n++) {
  var attr = attrs[n];
  if(attr.specified) {
   var attrName = attr.nodeName;
   var attrValue = sourceElem.getAttribute(attrName, 2);
   if(attrValue == null)
    attrValue = attr.nodeValue;
   destElement.setAttribute(attrName, attrValue, 0); 
  }
 }
 if(sourceElem.style.cssText !== '')
  destElement.style.cssText = sourceElem.style.cssText;
};
Attr.RemoveAllAttributes = function(element, excludedAttributes) {
 var excludedAttributesHashTable = {};
 if(excludedAttributes)
  excludedAttributesHashTable = Data.CreateHashTableFromArray(excludedAttributes);
 if(element.attributes) {
  var attrArray = element.attributes;
  for(var i = 0; i < attrArray.length; i++) {
   var attrName = attrArray[i].name;
   if(!ASPx.IsExists(excludedAttributesHashTable[attrName.toLowerCase()])) {
    try {
     attrArray.removeNamedItem(attrName);
    } catch (e) { }
   }
  }
 }
};
Attr.RemoveStyleAttribute = function(element, attrName) {
 if(element.style) {
  if(Browser.Firefox && element.style[attrName]) 
   element.style[attrName] = "";
  if(element.style.removeAttribute && element.style.removeAttribute != "")
   element.style.removeAttribute(attrName);
  else if(element.style.removeProperty && element.style.removeProperty != "")
   element.style.removeProperty(attrName);
 }
};
Attr.RemoveAllStyles = function(element) {
 if(element.style) {
  for(var key in element.style)
   Attr.RemoveStyleAttribute(element, key);
    Attr.RemoveAttribute(element, "style");
 }
};
Attr.GetTabIndexAttributeName = function(){
 return Browser.IE  ? "tabIndex" : "tabindex";
};
Attr.ChangeTabIndexAttribute = function(element){
 var attribute = Attr.GetTabIndexAttributeName(); 
 if(Attr.GetAttribute(element, attribute) != -1)
    Attr.ChangeAttribute(element, attribute, -1);
};
Attr.SaveTabIndexAttributeAndReset = function(element) {
 var attribute = Attr.GetTabIndexAttributeName();
 Attr.SaveAttribute(element, attribute, element, "saved" + attribute);
 Attr.SetAttribute(element, attribute, -1);
};
Attr.RestoreTabIndexAttribute = function(element){
 var attribute = Attr.GetTabIndexAttributeName();
 if(Attr.IsExistsAttribute(element, attribute)) {
  if(Attr.GetAttribute(element, attribute) == -1) {
   if(Attr.IsExistsAttribute(element, "saved" + attribute)){
    var oldValue = Attr.GetAttribute(element, "saved" + attribute);
    if(oldValue != ASPx.EmptyObject)
     Attr.SetAttribute(element, attribute, oldValue);
    else {
     if(Browser.WebKitFamily) 
      Attr.SetAttribute(element, attribute, 0); 
     Attr.RemoveAttribute(element, attribute);   
    }
    Attr.RemoveAttribute(element, "saved" + attribute); 
   }
  }
 }
};
Attr.ChangeAttributesMethod = function(enabled){
 return enabled ? Attr.RestoreAttribute : Attr.ResetAttribute;
};
Attr.InitiallyChangeAttributesMethod = function(enabled){
 return enabled ? Attr.ChangeAttribute : Attr.ResetAttribute;
};
Attr.ChangeStyleAttributesMethod = function(enabled){
 return enabled ? Attr.RestoreStyleAttribute : Attr.ResetStyleAttribute;
};
Attr.InitiallyChangeStyleAttributesMethod = function(enabled){
 return enabled ? Attr.ChangeStyleAttribute : Attr.ResetStyleAttribute;
};
Attr.ChangeEventsMethod = function(enabled){
 return enabled ? Evt.AttachEventToElement : Evt.DetachEventFromElement;
};
Attr.ChangeDocumentEventsMethod = function(enabled){
 return enabled ? Evt.AttachEventToDocument : Evt.DetachEventFromDocument;
};
Attr.ChangeCellSpanCount = function(cell, value, isColumnSpan) {
 if(!cell) return;
 var propertyKey = isColumnSpan ? "colSpan" : "rowSpan";
 var prevValue = cell[propertyKey];
 if(value > 1)
  cell[propertyKey] = value;
 else if(prevValue !== 1)
  Attr.RemoveAttribute(cell, propertyKey);
};
function isSourceResetRequired() {
 return Browser.IE && Browser.MajorVersion >= 11;
}
Attr.AppendScriptType = function(script) {
 if(!isHtml5Mode())
  script.type = "text/javascript";
};
Attr.AppendStyleType = function(style) {
 if(!isHtml5Mode())
  style.type = "text/css";
};
function isHtml5Mode() {
 return ASPx.DoctypeMode === "Html5";
}
ASPx.Attr = Attr;
var Aria = {
 atomic: "aria-atomic",
 checked: "aria-checked",
 descendant: "aria-activedescendant",
 described: "aria-describedby",
 disabled: "aria-disabled",
 expanded: "aria-expanded",
 haspopup: "aria-haspopup",
 invalid: "aria-invalid",
 label: "aria-label",
 labelled: "aria-labelledby",
 level: "aria-level",
 owns: "aria-owns",
 posinset: "aria-posinset",
 role: "role",
 selected: "aria-selected",
 setsize: "aria-setsize",
 valuemax: "aria-valuemax",
 valuemin: "aria-valuemin",
 valuenow: "aria-valuenow"
};
Aria.SetOrRemoveDescendant = function(obj, value) {
 ASPx.Attr.SetOrRemoveAttribute(obj, Aria.descendant, value);
};
Aria.SetOrRemoveLabel = function(obj, value) {
 ASPx.Attr.SetOrRemoveAttribute(obj, Aria.label, value);
};
Aria.SetOrRemoveDisabled = function(obj, value) {
 ASPx.Attr.SetOrRemoveAttribute(obj, Aria.disabled, value);
};
Aria.AppendLabel = function(obj, value, checkExists) {
 var currentValue = ASPx.Attr.GetAttribute(obj, Aria.label) || "";
 var resultParts = [ ];
 if(currentValue)
  resultParts.push(currentValue);
 var needAppendValue = value && (!checkExists || currentValue.indexOf(value) == -1);
 if(needAppendValue)
  resultParts.push(value);
 ASPx.Attr.SetAttribute(obj, Aria.label, resultParts.join(" "));
};
Aria.SetOrRemoveLabelled = function(obj, value) {
 ASPx.Attr.SetOrRemoveAttribute(obj, Aria.labelled, value);
};
Aria.SetApplicationRole = function(obj) {
  ASPx.Attr.SetAttribute(obj, Aria.role, "application");
};
Aria.SetSilence = function(obj) {
 ASPx.Attr.SetAttribute(obj, Aria.label, ";");
};
Aria.SetExpanded = function(obj, expanded) {
 if(!obj || !ASPx.Attr.GetAttribute(obj, Aria.expanded)) return;
 Aria.SetBoolAttribute(obj, Aria.expanded, expanded);
};
Aria.SetAtomic = function(obj, value) {
 Aria.SetBoolAttribute(obj, Aria.atomic, value);
};
Aria.SetBoolAttribute = function(obj, attribute, value) {
 if(value)
  ASPx.Attr.SetAttribute(obj, attribute, true);
 else 
  ASPx.Attr.SetAttribute(obj, attribute, false);
};
ASPx.Attr.Aria = Aria;
var Color = { };
function _aspxToHex(d) {
 return (d < 16) ? ("0" + d.toString(16)) : d.toString(16);
}
Color.RGBRegexp = /rgb\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)\s*\)/;
Color.RGBARegexp = /rgba?\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)\s*,?\s*([0-9]*\.?[0-9]*)\s*\)/;
Color.ColorToHexadecimal = function(colorValue, isRGBA) {
 if(typeof(colorValue) == "number") {
  var r = colorValue & 0xFF;
  var g = (colorValue >> 8) & 0xFF;
  var b = (colorValue >> 16) & 0xFF;
  return "#" + _aspxToHex(r) + _aspxToHex(g) + _aspxToHex(b);
 }
 if(colorValue && (colorValue.substr(0, 3).toLowerCase() == "rgb")) {
  var regResult = colorValue.toLowerCase().match(isRGBA ? Color.RGBARegexp : Color.RGBRegexp);
  if(regResult) {
   var r = parseInt(regResult[1]);
   var g = parseInt(regResult[2]);
   var b = parseInt(regResult[3]);
   if (isRGBA)
    return { r: r, g: g, b: b, a: regResult[4] !== undefined ? parseFloat(regResult[4]) : 1 };
   return "#" + _aspxToHex(r) + _aspxToHex(g) + _aspxToHex(b);
  }
  return null;
 } 
 if(colorValue && (colorValue.charAt(0) == "#"))
  return colorValue;
 return null;
};
Color.Names = {
 AddColorNames: function(stringResourcesObj) {
  if(stringResourcesObj) {
   for(var key in stringResourcesObj)
    if(stringResourcesObj.hasOwnProperty(key))
     this[key] = stringResourcesObj[key];
  }
 }
};
ASPx.Color = Color;
var Url = { };
Url.Navigate = function(url, target) {
 var javascriptPrefix = "javascript:";
 if(!url || url === "")
  return;
 else if(url.indexOf(javascriptPrefix) != -1) 
  eval(url.substr(javascriptPrefix.length));
 else {
  try{
   if(target != "")
    navigateTo(url, target);
   else
    location.href = url;
  }
  catch(e){
  }
 }
};
Url.NavigateByLink = function(linkElement) {
 Url.Navigate(Attr.GetAttribute(linkElement, "href"), linkElement.target);
};
Url.GetAbsoluteUrl = function(url) {
 if(url)
  url = Url.getURLObject(url).href;
 return url;
};
Url.Redirect = function(url) {
 if(!ASPx.Browser.IE)
  window.location.href = url;
 else { 
  var fakeLink = document.createElement("a");
  fakeLink.href = url;
  document.body.appendChild(fakeLink);
  try { fakeLink.click(); } catch(e) { } 
 }
};
var absolutePathPrefixes = 
 [ "about:", "file:///", "ftp://", "gopher://", "http://", "https://", "javascript:", "mailto:", "news:", "res://", "telnet://", "view-source:" ];
Url.isAbsoluteUrl = function(url) {
 if (url) {
  for (var i = 0; i < absolutePathPrefixes.length; i++) {
   if(url.indexOf(absolutePathPrefixes[i]) == 0)
    return true;
  }
 }
 return false;
};
Url.getURLObject = function(url) {
 var link = document.createElement('A');
 link.href = url || "";
 return { 
  href: link.href,
  protocol: link.protocol,
  host: link.host,
  port: link.port,
  pathname: link.pathname,
  search: link.search,
  hash: link.hash
 }; 
};
Url.getRootRelativeUrl = function(url) {
 return getRelativeUrl(url, !Url.isRootRelativeUrl(url), true); 
};
Url.getPathRelativeUrl = function(url) {
 return getRelativeUrl(url, !Url.isPathRelativeUrl(url), false);
};
function getRelativeUrl(url, isValid, isRootRelative) {
 if(url && !(/data:([^;]+\/?[^;]*)(;charset=[^;]*)?(;base64,)/.test(url)) && isValid) {
  var urlObject = Url.getURLObject(url);
  var baseUrlObject = Url.getURLObject();
  if(!Url.isAbsoluteUrl(url) || urlObject.host === baseUrlObject.host && urlObject.protocol === baseUrlObject.protocol) {
   url = urlObject.pathname;
   if(!isRootRelative)
    url = getPathRelativeUrl(baseUrlObject.pathname, url);
   url = url + urlObject.search + urlObject.hash;
  }
 }
 return url;   
}
function getPathRelativeUrl(baseUrl, url) {
 var requestSegments = getSegments(baseUrl, false);
 var urlSegments = getSegments(url, true);
 return buildPathRelativeUrl(requestSegments, urlSegments, 0, 0, "");
}
function getSegments(url, addTail) {
 var segments = [];
 var startIndex = 0;
 var endIndex = -1;
 while ((endIndex = url.indexOf("/", startIndex)) != -1) {
  segments.push(url.substring(startIndex, ++endIndex));
  startIndex = endIndex;
 }
 if(addTail && startIndex < url.length)
  segments.push(url.substring(startIndex, url.length)); 
 return segments;
}
function buildPathRelativeUrl(requestSegments, urlSegments, reqIndex, urlIndex, buffer) {
 if(urlIndex >= urlSegments.length)
  return buffer;
 if(reqIndex >= requestSegments.length)
  return buildPathRelativeUrl(requestSegments, urlSegments, reqIndex, urlIndex + 1, buffer + urlSegments[urlIndex]);
 if(requestSegments[reqIndex] === urlSegments[urlIndex] && urlIndex === reqIndex)
  return buildPathRelativeUrl(requestSegments, urlSegments, reqIndex + 1, urlIndex + 1, buffer);
 return buildPathRelativeUrl(requestSegments, urlSegments, reqIndex + 1, urlIndex, buffer + "../");
}
Url.isPathRelativeUrl = function(url) {
 return !!url && !Url.isAbsoluteUrl(url) && url.indexOf("/") != 0;  
};
Url.isRootRelativeUrl = function(url) {
 return !!url && !Url.isAbsoluteUrl(url) && url.indexOf("/") == 0 && url.indexOf("//") != 0;
};
function navigateTo(url, target) {
 var lowerCaseTarget = target.toLowerCase();
 if("_top" == lowerCaseTarget)
  top.location.href = url;
 else if("_self" == lowerCaseTarget)
  location.href = url;
 else if("_search" == lowerCaseTarget)
  openInNewWindow(url);
 else if("_media" == lowerCaseTarget)
  openInNewWindow(url);
 else if("_parent" == lowerCaseTarget)
  window.parent.location.href = url;
 else if("_blank" == lowerCaseTarget)
  openInNewWindow(url);
 else {
  var frame = getFrame(top.frames, target);
  if(frame != null)
   frame.location.href = url;
  else
   openInNewWindow(url);
 }
}
function openInNewWindow(url) {
 if(ASPx.Browser.Safari)
  openInNewWindowViaIframe(url);
 else {
  var newWindow = window.open();
  newWindow.opener = null;
  newWindow.location = url;
 }
}
function openInNewWindowViaIframe(url) {
 var iframe = document.createElement('iframe');
 iframe.style.display = 'none';
 document.body.appendChild(iframe);
 var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
 var openArgs = '"' + url + '"';
 var script = iframeDoc.createElement('script');
 script.type = 'text/javascript';
 script.text = 'window.parent = null; ' +
  'window.top = null;' +
  'window.frameElement = null;' +
  'var child = window.open(' + openArgs + ');' +
  'child.opener = null';
 iframeDoc.body.appendChild(script);
 document.body.removeChild(iframe);
}
ASPx.Url = Url;
var Json = { };
function isValid(JsonString) {
 return !(/[^,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]/.test(JsonString.replace(/"(\\.|[^"\\])*"/g, '')));
}
Json.Eval = function(jsonString, controlName) {
 if(isValid(jsonString))
  return eval("(" + jsonString + ")");
 else
  throw new Error(controlName + " received incorrect JSON-data: " + jsonString);
};
Json.ToJson = function(param, skipEncodeHtml){
 var paramType = typeof(param);
 if((paramType == "undefined") || (param == null))
  return null;
 if((paramType == "object") && (typeof(param.__toJson) == "function"))
  return param.__toJson();
 if((paramType == "number") || (paramType == "boolean"))
  return param;
 if(param.constructor == Date)
  return dateToJson(param);
 if(paramType == "string") {
  var result = param.replace(/\\/g, "\\\\");
  result = result.replace(/"/g, "\\\"");
  result = result.replace(/\n/g, "\\n");
  result = result.replace(/\r/g, "\\r");
  if(!skipEncodeHtml) {
   result = result.replace(/</g, "\\u003c");
   result = result.replace(/>/g, "\\u003e");
  }
  return "\"" + result + "\"";
 }
 if(param.constructor == Array){
  var values = [];
  for(var i = 0; i < param.length; i++) {
   var jsonValue = Json.ToJson(param[i], skipEncodeHtml);
   if(jsonValue === null)
    jsonValue = "null";
   values.push(jsonValue);
  }
  return "[" + values.join(",") + "]";
 }
 var exceptKeys = {};
 if(ASPx.Ident.IsArray(param.__toJsonExceptKeys))
  exceptKeys = Data.CreateHashTableFromArray(param.__toJsonExceptKeys);
 exceptKeys["__toJsonExceptKeys"] = 1;
 var values = [];
 for(var key in param) {
  if(param.hasOwnProperty(key)) {
   if(ASPx.IsFunction(param[key]))
    continue;
   if(exceptKeys[key] == 1)
    continue;
   values.push(Json.ToJson(key) + ":" + Json.ToJson(param[key], skipEncodeHtml));
  }
 }
 return "{" + values.join(",") + "}";
};
function dateToJson(date) {
 var result = [ 
  date.getFullYear(),
  date.getMonth(),
  date.getDate()
 ];
 var time = {
  h: date.getHours(),
  m: date.getMinutes(),
  s: date.getSeconds(),
  ms: date.getMilliseconds()
 };
 if(time.h || time.m || time.s || time.ms)
  result.push(time.h);
 if(time.m || time.s || time.ms)
  result.push(time.m);
 if(time.s || time.ms)
  result.push(time.s);
 if(time.ms)
  result.push(time.ms);
 return "new Date(" + result.join() + ")";
}
ASPx.Json = Json;
ASPx.CreateClass = function(parentClass, properties) {
 if(arguments.length == 1) {
  properties = parentClass;
  parentClass = null;
 }
 var ret = function() {
  if(ret.preparing) 
   return delete(ret.preparing);
  if(ret.constr) {
   this.constructor = ret;
   ret.constr.apply(this, arguments);
  }
 };
 ret.prototype = {};
 if(parentClass) {
  parentClass.preparing = true;
  for(var name in parentClass) {
   if(parentClass.hasOwnProperty(name) && name != 'constr' && ASPx.IsFunction(parentClass[name]) && !ret[name])
    ret[name] = parentClass[name].aspxBind(parentClass);
  }
  ret.prototype = new parentClass;
  ret.prototype.constructor = parentClass;
  ret.constr = parentClass;
 }
 if(properties) {
  var constructorName = "constructor";
  for(var name in properties) {
   if(!properties.hasOwnProperty(name)) 
    continue;
   var getter = Object.getOwnPropertyDescriptor(properties, name).get;
   var setter = Object.getOwnPropertyDescriptor(properties, name).set;
   if(getter || setter)
    Object.defineProperty(ret.prototype, name, {
     set: setter,
     get: getter,
     enumerable: true,
     configurable: true
    });
   if(name != constructorName && !getter && !setter)
    ret.prototype[name] = properties[name];
  }
  if(properties[constructorName] && properties[constructorName] != Object)
   ret.constr = properties[constructorName];
 }
 return ret;
};
var registeredMixins = {};
ASPx.GetMixin = function (name, baseClass) {
 var mixinCache = baseClass._mixins || (baseClass._mixins = {});
 var resultClass = mixinCache[name];
 if (!resultClass) {
  var mixinCodeBuilder = registeredMixins[name];
  if (!mixinCodeBuilder)
   throw new Error("mixin with the '" + name + "' is not registered");
  var mixinCode = mixinCodeBuilder(baseClass);
  mixinCode.mixinName = name;
  resultClass = ASPx.CreateClass(baseClass, mixinCode);
  mixinCache[name] = resultClass;
 }
 return resultClass;
};
ASPx.RegisterMixin = function() {
 var name = arguments.length == 1 ? "mixin_" + ASPx.CreateGuid() : arguments[0];
 var mixinCodeBuilder = arguments[arguments.length - 1];
 if (registeredMixins[name])
  throw new Error("mixin with the '" + name + "' name is already defined");
 registeredMixins[name] = mixinCodeBuilder;
 return function(baseClass) { return ASPx.GetMixin(name, baseClass); };
};
ASPx.FormatCallbackArg = function(prefix, arg) {
 if(prefix == null && arg == null)
  return ""; 
 if(prefix == null) prefix = "";
 if(arg == null) arg = "";
 if(arg != null && !ASPx.IsExists(arg.length) && ASPx.IsExists(arg.value))
  arg = arg.value;
 arg = arg.toString();
 return [prefix, '|', arg.length, '|' , arg].join('');
};
ASPx.FormatCallbackArgs = function(callbackData) {
 var sb = [ ];
 for(var i = 0; i < callbackData.length; i++)
  sb.push(ASPx.FormatCallbackArg(callbackData[i][0], callbackData[i][1]));
 return sb.join("");
};
ASPx.ParseShortcutString = function(shortcutString) {
 if(!shortcutString)
  return 0;
 var isCtrlKey = false;
 var isShiftKey = false;
 var isAltKey = false;
 var isMetaKey = false;
 var keyCode = null;
 var shcKeys = shortcutString.toString().split("+");
 if(shcKeys.length > 0) {
  for(var i = 0; i < shcKeys.length; i++) {
   var key = Str.Trim(shcKeys[i].toUpperCase());
   switch (key) {
    case "CONTROL":
    case "CONTROLKEY":
    case "CTRL":
     isCtrlKey = true;
     break;
    case "SHIFT":
    case "SHIFTKEY":
     isShiftKey = true;
     break;
    case "ALT":
     isAltKey = true;
     break;
    case "CMD":
     isMetaKey = true;
     break;
    case "F1": keyCode = ASPx.Key.F1; break;
    case "F2": keyCode = ASPx.Key.F2; break;
    case "F3": keyCode = ASPx.Key.F3; break;
    case "F4": keyCode = ASPx.Key.F4; break;
    case "F5": keyCode = ASPx.Key.F5; break;
    case "F6": keyCode = ASPx.Key.F6; break;
    case "F7": keyCode = ASPx.Key.F7; break;
    case "F8": keyCode = ASPx.Key.F8; break;
    case "F9": keyCode = ASPx.Key.F9; break;
    case "F10":   keyCode = ASPx.Key.F10; break;
    case "F11":   keyCode = ASPx.Key.F11; break;
    case "F12":   keyCode = ASPx.Key.F12; break;
    case "RETURN":
    case "ENTER": keyCode = ASPx.Key.Enter; break;
    case "HOME":  keyCode = ASPx.Key.Home; break;
    case "END":   keyCode = ASPx.Key.End; break;
    case "LEFT":  keyCode = ASPx.Key.Left; break;
    case "RIGHT": keyCode = ASPx.Key.Right; break;
    case "UP": keyCode = ASPx.Key.Up; break;
    case "DOWN":  keyCode = ASPx.Key.Down; break;
    case "PAGEUP": keyCode = ASPx.Key.PageUp; break;
    case "PAGEDOWN": keyCode = ASPx.Key.PageDown; break;
    case "SPACE": keyCode = ASPx.Key.Space; break;
    case "TAB":   keyCode = ASPx.Key.Tab; break;
    case "BACKSPACE": 
    case "BACK": keyCode = ASPx.Key.Backspace; break;
    case "CONTEXT": keyCode = ASPx.Key.ContextMenu; break;
    case "ESCAPE":
    case "ESC":
     keyCode = ASPx.Key.Esc;
     break;
    case "DELETE":
    case "DEL":
     keyCode = ASPx.Key.Delete;
     break;
    case "INSERT":
    case "INS":
     keyCode = ASPx.Key.Insert;
     break;
    case "PLUS":
     keyCode = "+".charCodeAt(0);
     break;
    default:
     keyCode = key.charCodeAt(0);
     break;
   }
  }
 } else
  ASPx.ShowErrorAlert("Invalid shortcut");
 return ASPx.GetShortcutCode(keyCode, isCtrlKey, isShiftKey, isAltKey, isMetaKey);
};
ASPx.GetShortcutCode = function(keyCode, isCtrlKey, isShiftKey, isAltKey, isMetaKey) {
 var value = keyCode;
 value |= isCtrlKey ? ASPx.ModifierKey.Ctrl : 0;
 value |= isShiftKey ? ASPx.ModifierKey.Shift : 0;
 value |= isAltKey ? ASPx.ModifierKey.Alt : 0;
 value |= isMetaKey ? ASPx.ModifierKey.Meta : 0;
 return value;
};
ASPx.GetShortcutCodeByEvent = function(evt) {
 return ASPx.GetShortcutCode(Evt.GetKeyCode(evt), evt.ctrlKey, evt.shiftKey, evt.altKey, ASPx.Browser.MacOSPlatform ? evt.metaKey : false);
};
ASPx.IsPasteShortcut = function(evt) {
 if(evt.type === "paste")
  return true;
 var keyCode = Evt.GetKeyCode(evt);
 if(Browser.NetscapeFamily && evt.which == 0)  
  keyCode = evt.keyCode;
 return (evt.ctrlKey && (keyCode == 118  || (keyCode == 86))) ||
     (evt.shiftKey && !evt.ctrlKey && !evt.altKey &&
     (keyCode == ASPx.Key.Insert)) ;
};
var NotPrintableKeyCodes = null;
ASPx.IsPrintableKey = function(keyCode) {
 if (!NotPrintableKeyCodes)
  NotPrintableKeyCodes = Object.keys(ASPx.Key).map(function(key) { return ASPx.Key[key]; });
 return !ASPx.Data.ArrayContains(NotPrintableKeyCodes, keyCode);
};
ASPx.SetFocus = function(element, selectAction) {
 function focusCore(element, selectAction){
  try {
    element.focus();
    if(Browser.IE && document.activeElement != element)
     element.focus();
    if(selectAction) {
     var currentSelection = Selection.GetInfo(element);
     if(currentSelection.startPos == currentSelection.endPos) {
      switch(selectAction) {
       case "start":
        Selection.SetCaretPosition(element, 0);
        break;
       case "all":
        Selection.Set(element);
        break;
      }
     }
    }
   } catch (e) {
  }
 }
 if(ASPxClientUtils.iOSPlatform) 
  focusCore(element, selectAction);
 else {
  window.setTimeout(function() { 
   focusCore(element, selectAction);
  }, ASPx.FOCUS_TIMEOUT);
 }
};
ASPx.IsFocusableCore = function(element, skipContainerVisibilityCheck) {
 var current = element;
 while(current && current.nodeType == 1) {
  if(current == element || !skipContainerVisibilityCheck(current)) {
   var tagName = current.tagName.toUpperCase();
   if(tagName == "BODY")
    return true;
   var disabledElementTags = ["INPUT", "BUTTON", "TEXTAREA", "SELECT", "OPTION"];
   if(disabledElementTags.indexOf(tagName) !== -1 && current.disabled || !ASPx.GetElementDisplay(current) || !ASPx.GetElementVisibility(current))
    return false;
  }
  current = current.parentNode;
 }
 return true;
};
ASPx.IsFocusable = function(element) {
 return ASPx.IsFocusableCore(element, ASPx.FalseFunction);
};
var ActionElementsCache = ASPx.CreateClass(null, {
 constructor: function() {
  this.usageCounter = 0;
  this.elements = [ ];
  this.values = [ ];
 },
 IsActive: function() { return this.usageCounter > 0; },
 BeginUsage: function() {
  this.usageCounter++;
 },
 EndUsage: function() {
  this.usageCounter--;
  if(this.usageCounter === 0)
   this.Clear();
 },
 Add: function(element, value) {
  var index = this.elements.length;
  this.elements[index] = element;
  this.values[index] = value;
 },
 Get: function(element) { 
  var index = this.elements.indexOf(element);
  var hasValue = index > -1;
  var value = hasValue ? this.values[index] : undefined;
  return { hasValue: hasValue, value: value };
 },
 Clear: function() { 
  this.elements = [ ];
  this.values = [ ];
 }
});
ASPx.ActionElementsCache = new ActionElementsCache();
ASPx.IsActionElement = function(element) {
 if(!ASPx.IsExistsElement(element))
  return false;
 var useCache = ASPx.ActionElementsCache.IsActive();
 if(useCache) {
  var cacheValue = ASPx.ActionElementsCache.Get(element);
  if(cacheValue.hasValue)
   return cacheValue.value;
 }
 var isActionElement = ASPx.IsActionElementCore(element);
 if(useCache)
  ASPx.ActionElementsCache.Add(element, isActionElement);
 return isActionElement;
};
ASPx.IsActionElementCore = function(element) {
 var tabIndex = parseInt(ASPx.Attr.GetAttribute(element, ASPx.Attr.GetTabIndexAttributeName()));
 var hasTabIndex = !isNaN(tabIndex);
 var hasNonNegativeTabIndex = hasTabIndex && tabIndex > -1;
 var hasNegativeTabIndex = hasTabIndex && tabIndex < 0;
 var tagName = element.tagName;
 var focusableElementTags = ["BUTTON", "SELECT", "TEXTAREA", "OPTION", "IFRAME"];
 var isFocusableCore = ASPx.IsFocusable(element);
 var isFocusableTag = focusableElementTags.indexOf(tagName) !== -1;
 var isFocusableLink = tagName === "A" && (!!element.href || hasNonNegativeTabIndex);
 var isFocusableInput = tagName === "INPUT" && element.type.toLowerCase() !== "hidden";
 var isFocusableByTabIndex = tagName !== "INPUT" && hasNonNegativeTabIndex;
 var isEditableDiv = tagName == "DIV" && element.contentEditable === "true";
 return isFocusableCore && !hasNegativeTabIndex && (isFocusableTag || isFocusableLink || isFocusableInput || isFocusableByTabIndex || isEditableDiv);
};
ASPx.GetCanBeActiveElementsInContainer = function(container) {
 var canBeActiveTags = ["INPUT", "A", "UL", "BUTTON", "TEXTAREA", "SELECT", "IFRAME"],
  canBeActiveElements = [];
 Data.ForEach(canBeActiveTags, function(tag) {
  var elements = container.getElementsByTagName(tag);
  canBeActiveElements = canBeActiveElements.concat([].slice.call(elements));
 });
 return canBeActiveElements;
};
function isActionElementAllowedByPredicate(element, predicate) {
  var allowedByPredicate = !predicate || predicate(element);
  return allowedByPredicate && ASPx.IsActionElement(element);
}
ASPx.FindChildActionElements = function(container, predicate) {
 return ASPx.GetNodes(container, function(el) {
  return isActionElementAllowedByPredicate(el, predicate);
 });
};
ASPx.FindAllSortedActionElements = function(container, predicate) {
 var result = [ ];
 if(!container || !container.getElementsByTagName) return result;
 var actionElements = ASPx.FindChildActionElements(container, predicate);
 var getTabOrderValue = function(el) {
  var tabIndex = parseInt(ASPx.Attr.GetAttribute(el, ASPx.Attr.GetTabIndexAttributeName()));
  return isNaN(tabIndex) ? 0 : tabIndex;
 };
 var positiveTabIndexElements = actionElements.filter(function(x) { return getTabOrderValue(x) > 0; });
 var nonPositiveTabIndexElements = actionElements.filter(function(x) { return getTabOrderValue(x) === 0; });
 var sortedTabIndexElements = positiveTabIndexElements.sort(function(x, y) { return getTabOrderValue(x) - getTabOrderValue(y); });
 result = sortedTabIndexElements.concat(nonPositiveTabIndexElements);
 return result;
};
ASPx.FindFirstChildActionElement = function(container, predicate) {
 if(!container || isActionElementAllowedByPredicate(container, predicate))
  return !container ? null : container;
 var sortedActionElements = ASPx.FindAllSortedActionElements(container, predicate);
 return sortedActionElements[0];
};
ASPx.FindLastChildActionElement = function(container, predicate) {
 if(!container)
  return null;
 var sortedActionElements = ASPx.FindAllSortedActionElements(container, predicate);
 var actionElement = sortedActionElements[sortedActionElements.length - 1];
 if(!actionElement && isActionElementAllowedByPredicate(container, predicate))
  actionElement = container;
 return actionElement;
};
ASPx.GetParentClientControls = function(name) {
 var nameParts = name.split("_");
 var result = [ ];
 var controlCollection = ASPx.GetControlCollection();
 for(var i = 1; i <= nameParts.length; i++) {
  var controlName = nameParts.slice(0, i).join("_");
  var control = controlCollection.Get(controlName);
  if(control)
   result.push(control);
 }
 return result;
};
ASPx.GetRootClientControl = function(childControlName) {
 var parentControls = ASPx.GetParentClientControls(childControlName);
 return parentControls[0];
};
ASPx.GetClientControlByElementID = function(elementID) {
 var parentControls = ASPx.GetParentClientControls(elementID);
 return parentControls[parentControls.length - 1];
};
ASPx.IsExists = function(obj){
 return (typeof(obj) != "undefined") && (obj != null);
};
ASPx.IsFunction = function(obj){
 return typeof(obj) == "function";
};
ASPx.IsNumber = function(str) {
 return !isNaN(parseFloat(str)) && isFinite(str);
};
ASPx.GetDefinedValue = function(value, defaultValue){
 return (typeof(value) != "undefined") ? value : defaultValue;
};
ASPx.CorrectJSFloatNumber = function(number) {
 var ret = 21; 
 var numString = number.toPrecision(21);
 numString = numString.replace("-", ""); 
 var integerDigitsCount = numString.indexOf(ASPx.PossibleNumberDecimalSeparators[0]);
 if(integerDigitsCount < 0)
  integerDigitsCount = numString.indexOf(ASPx.PossibleNumberDecimalSeparators[1]);
 var floatDigitsCount = numString.length - integerDigitsCount - 1;
 if(floatDigitsCount < 10)
  return number;
 if(integerDigitsCount > 0) {
  ret = integerDigitsCount + 12;
 }
 var toPrecisionNumber = Math.min(ret, 21);
 var newValueString = number.toPrecision(toPrecisionNumber);
 return parseFloat(newValueString, 10);
};
ASPx.CorrectRounding = function(number, step) { 
 var regex = /[,|.](.*)/,
  isFloatValue = regex.test(number),
  isFloatStep = regex.test(step);
 if(isFloatValue || isFloatStep) {
  var valueAccuracy = (isFloatValue) ? regex.exec(number)[0].length - 1 : 0,
   stepAccuracy = (isFloatStep) ? regex.exec(step)[0].length - 1 : 0,
   accuracy = Math.max(valueAccuracy, stepAccuracy);
  var multiplier = Math.pow(10, accuracy);
  number = Math.round((number + step) * multiplier) / multiplier;
  return number;
 }
 return number + step;
};
ASPx.GetActiveElement = function() {
 try{ return document.activeElement; } catch(e) { return null; }
};
var verticalScrollBarWidth;
ASPx.GetVerticalScrollBarWidth = function() {
 if(typeof(verticalScrollBarWidth) == "undefined") {
  var container = document.createElement("DIV");
  container.style.cssText = "position: absolute; top: 0px; left: 0px; visibility: hidden; width: 200px; height: 150px; overflow: hidden; box-sizing: content-box";
  document.body.appendChild(container);
  var child = document.createElement("P");
  container.appendChild(child);
  child.style.cssText = "width: 100%; height: 200px;";
  var widthWithoutScrollBar = child.offsetWidth;
  container.style.overflow = "scroll";
  var widthWithScrollBar = child.offsetWidth;
  if(widthWithoutScrollBar == widthWithScrollBar)
   widthWithScrollBar = container.clientWidth;
  verticalScrollBarWidth = widthWithoutScrollBar - widthWithScrollBar;
  document.body.removeChild(container);
 }
 return verticalScrollBarWidth;
};
function hideScrollBarCore(element, scrollName) {
 if(element.tagName == "IFRAME") {
  if((element.scrolling == "yes") || (element.scrolling == "auto")) {
   Attr.ChangeAttribute(element, "scrolling", "no");
   return true;
  }
 }
 else if(element.tagName == "DIV") {
  if((element.style[scrollName] == "scroll") || (element.style[scrollName] == "auto")) {
   Attr.ChangeStyleAttribute(element, scrollName, "hidden");
   return true;
  }
 }
 return false;
}
function restoreScrollBarCore(element, scrollName) {
 if(element.tagName == "IFRAME")
  return Attr.RestoreAttribute(element, "scrolling");
 else if(element.tagName == "DIV")
  return Attr.RestoreStyleAttribute(element, scrollName);
 return false;
}
ASPx.SetScrollBarVisibilityCore = function(element, scrollName, isVisible) {
 return isVisible ? restoreScrollBarCore(element, scrollName) : hideScrollBarCore(element, scrollName);
};
ASPx.SetScrollBarVisibility = function(element, isVisible) {
 if(ASPx.SetScrollBarVisibilityCore(element, "overflow", isVisible)) 
  return true;
 var result = ASPx.SetScrollBarVisibilityCore(element, "overflowX", isVisible)
  || ASPx.SetScrollBarVisibilityCore(element, "overflowY", isVisible);
 return result;
};
ASPx.SetInnerHtml = function(element, html) {
 if(Browser.IE) {
  setInnerHtmlInternal(element, "<em>&nbsp;</em>" + html);
  element.removeChild(element.firstChild);
 } else
  setInnerHtmlInternal(element, html);
};
ASPx.GetInnerText = function(container) {
 if(Browser.Safari && Browser.MajorVersion <= 5) {
  var filter = getHtml2PlainTextFilter();
  setInnerHtmlInternal(filter, container.innerHTML);
  ASPx.SetElementDisplay(filter, true);
  var innerText = filter.innerText;
  ASPx.SetElementDisplay(filter, false);
  return innerText;
 } else if(Browser.NetscapeFamily || Browser.WebKitFamily || (Browser.IE && Browser.Version >= 9) || Browser.Edge) {
  return container.textContent;
 } else
  return container.innerText;
};
ASPx.GetEllipsisTooltipText = function(element) {
 var innerText = ASPx.GetInnerText(element);
 innerText = ASPx.RemoveComment(innerText);
 return innerText;
};
ASPx.RemoveComment = function(text) {
 var result = text;
 var commentStart = "<!--";
 var commentEnd = "//-->";
 var positionStart = result.indexOf(commentStart);
 while(positionStart > -1) {
  var positionEnd = result.indexOf(commentEnd);
  var startStr = result.substring(0, positionStart);
  var endStr = result.substring(positionEnd + commentEnd.length);
  result = startStr + endStr;
  positionStart = result.indexOf(commentStart);
 }
 return result;
};
var html2PlainTextFilter = null;
function getHtml2PlainTextFilter() {
 if(html2PlainTextFilter == null) {
  html2PlainTextFilter = document.createElement("DIV");
  html2PlainTextFilter.style.width = "0";
  html2PlainTextFilter.style.height = "0";
  html2PlainTextFilter.style.overflow = "visible";
  ASPx.SetElementDisplay(html2PlainTextFilter, false);
  document.body.appendChild(html2PlainTextFilter);
 }
 return html2PlainTextFilter;
}
ASPx.CreateHiddenField = function(name, id, parent) {
 var input = document.createElement("INPUT");
 input.setAttribute("type", "hidden");
 if(name)
  input.setAttribute("name", name);
 if(id)
  input.setAttribute("id", id);
 if(parent)
  parent.appendChild(input);
 return input;
};
ASPx.CloneObject = function(srcObject) {
 if(typeof(srcObject) != 'object' || srcObject == null)
  return srcObject;
 var newObject = {};
 for(var i in srcObject)
  newObject[i] = srcObject[i];
 return newObject;
};
ASPx.InsertRowsBefore = function(table, rowsHtml, index) {
 var row = null;
 if(index >= 0 && index < table.rows.length)
  row = table.rows[index];
 var func = ASPx.Browser.IE && ASPx.Browser.Version < 10 ? insertRowsBefore_IE9 : insertRowsBefore;
 func(table, rowsHtml, row);
};
var insertRowsBefore = function(table, rowsHtml, row) {
 if(!row && table.tBodies.length > 0) {
  row = document.createElement("TR");
  table.tBodies[0].appendChild(row);
  row.shouldRemove = true;
 }
 if(row) {
  row.insertAdjacentHTML("beforeBegin", rowsHtml);
  if(row.shouldRemove)
   ASPx.RemoveElement(row);
 }
};
var insertRowsBefore_IE9 = function(table, rowsHtml, nextRow) {
 var row = document.createElement("TR");
 var cell = document.createElement("TD");
 setInnerHtmlInternal(cell, "<table><tbody>" + rowsHtml + "</tbody></table>");
 var tbody = table.tBodies[0];
 tbody.appendChild(row);
 row.appendChild(cell);
 var newTable = ASPx.GetNodeByTagName(cell, "TABLE", 0);
 var rowCount = newTable.rows.length;
 for(var i = rowCount - 1; i >= 0; i--) {
  var newRow = newTable.rows[i];
  if(nextRow == null)
   tbody.appendChild(newRow);
  else
   tbody.insertBefore(newRow, nextRow);
  nextRow = newRow;
 }
 ASPx.RemoveElement(row);
};
ASPx.IsPercentageSize = function(size) {
 return size && size.indexOf('%') != -1;
};
ASPx.GetElementById = function(id) {
 if(document.getElementById)
  return document.getElementById(id);
 else
  return document.all[id];
};
ASPx.GetInputElementById = function(id) {
 var elem = ASPx.GetElementById(id);
 if(!Browser.IE)
  return elem;
 if(elem) {
  if(elem.id == id)
   return elem;
  else {
   for(var i = 1; i < document.all[id].length; i++) {
    if(document.all[id][i].id == id)
     return document.all[id][i];
   }
  }
 }
 return null;
};
ASPx.GetElementByIdInDocument = function(documentObj, id) {
 if(documentObj.getElementById)
  return documentObj.getElementById(id);
 else
  return documentObj.all[id];
};
ASPx.GetIsParent = function(parentElement, element) {
 if(!parentElement || !element)
  return false;
 while(element){
  if(element === parentElement)
   return true;
  if(element.tagName === "BODY")
   return false;
  element = element.parentNode;
 }
 return false;
};
ASPx.GetParentById = function(element, id) {
 element = element.parentNode;
 while(element){
  if(element.id === id)
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetParentByPartialId = function(element, idPart){
 while(element && element.tagName != "BODY") {
  if(element.id && element.id.match(idPart)) 
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetParentByTagName = function(element, tagName) {
 tagName = tagName.toUpperCase();
 while(element) {
  if(element.tagName === "BODY")
   return null;
  if(element.tagName === tagName)
   return element;
  element = element.parentNode;
 }
 return null;
};
function getParentByCondition(element, conditionArg, condition) {
 while(element != null) {
  if(element.tagName == "BODY" || element.nodeName == "#document")
   return null;
  if (condition(element, conditionArg))
   return element;
  element = element.parentNode;
 }
 return null;
}
ASPx.GetParentByPartialClassName = function(element, className) {
 return getParentByCondition(element, className, ASPx.ElementContainsCssClass);
};
ASPx.GetParentByClassName = function(element, className) {
 return getParentByCondition(element, className, ASPx.ElementHasCssClass);
};
ASPx.GetParentBySelector = function (element, selector) {
 return getParentByCondition(element, selector, ASPx.ElementMatchesSelector);
};
ASPx.GetParentByTagNameAndAttributeValue = function(element, tagName, attrName, attrValue) {
 tagName = tagName.toUpperCase();
 while(element != null) {
  if(element.tagName == "BODY")
   return null;
  if(element.tagName == tagName && element[attrName] == attrValue)
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetParent = function(element, testFunc){
 if (!ASPx.IsExists(testFunc)) return null;
 while(element != null && element.tagName != "BODY"){
  if(testFunc(element))
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetElementTreeLine = function(element, stopTagName, stopFunc) {
 var result = [];
 stopTagName = stopTagName || "BODY";
 while(element != null) {
  if(!stopFunc && element.tagName == stopTagName)
   break;
  if(stopFunc && stopFunc(element))
   break;
  result.push(element);
  element = element.parentNode;
 }
 return result;
};
ASPx.IsScrollableElement = function(element, isHorzScrollable, isVertScrollable) {
 isHorzScrollable = ASPx.IsExists(isHorzScrollable) ? isHorzScrollable : true;
 isVertScrollable = ASPx.IsExists(isVertScrollable) ? isVertScrollable : true;
 var style = ASPx.GetCurrentStyle(element);
 var overflowStyleNames = ["overflow"];
 if(isHorzScrollable)
  overflowStyleNames.push("overflowX");
 if(isVertScrollable)
  overflowStyleNames.push("overflowY");
 for(var i = 0; i < overflowStyleNames.length; i++)
  if(style[overflowStyleNames[i]] == "scroll" || style[overflowStyleNames[i]] == "auto")
   return true;
 return false;
};
ASPx.GetPreviousSibling = function(el) {
 if(el.previousElementSibling) {
  return el.previousElementSibling;
 } else {
  while(el = el.previousSibling) {
   if(el.nodeType === 1)
    return el;
  }
 }
};
ASPx.ElementMatchesSelector = (function (e) {
 return (function (matches) {
  return function (el, selector) { return !!el && !!selector && matches.call(el, selector); };
 })(e.matches || e.matchesSelector || e.webkitMatchesSelector || e.mozMatchesSelector || e.msMatchesSelector || e.oMatchesSelector);
})(Element.prototype);
ASPx.ElementHasCssClass = function(element, className) {
 try {
  var elementClasses;
  var classList = ASPx.GetClassNameList(element);
  if(!classList) {
   var elementClassName = ASPx.GetClassName(element);
   if(!elementClassName) {
    return false;
   }
   elementClasses = elementClassName.split(" ");
  }
  var classNames = className.split(" ");
  for(var i = classNames.length - 1; i >= 0; i--) {
   if(classList) {
    if(classList.indexOf(classNames[i]) === -1)
     return false;
    continue;
   }
   if(Data.ArrayIndexOf(elementClasses, classNames[i]) < 0)
    return false;
  }
  return true;
 } catch(e) {
  return false;
 }
};
ASPx.ElementContainsCssClass = function(element, className) {
 try {
  var elementClassName = ASPx.GetClassName(element);
  if(!elementClassName) {
   return false;
  }
  return elementClassName.indexOf(className) != -1;
 } catch(e) {
  return false;
 }
};
ASPx.AddClassNameToElement = function (element, className) {
 if(!element || typeof(className) !== "string" ) return;
 className = className.trim();
 if(!ASPx.ElementHasCssClass(element, className) && className !== "") {
  var oldClassName = ASPx.GetClassName(element);
  ASPx.SetClassName(element, (oldClassName === "") ? className : oldClassName + " " + className);
 }
};
ASPx.RemoveClassNameFromElement = function(element, className) {
 if(!element) return;
 var elementClassName = ASPx.GetClassName(element);
 var updClassName = " " + elementClassName + " ";
 var newClassName = updClassName.replace(" " + className + " ", " ");
 if(updClassName.length != newClassName.length)
  ASPx.SetClassName(element, Str.Trim(newClassName));  
};
ASPx.RemoveClassNamesFromElement = function(element, classNames) {
 if(!element) return;
 for(var i = 0; i < classNames.length; i++) {
  var className = classNames[i];
  if(ASPx.Browser.IE && ASPx.Browser.Version < 10)
   ASPx.RemoveClassNameFromElement(element, className);
  else
   element.classList.remove(className);
 }
};
ASPx.ToggleClassNameToElement = function(element, className, toggleState) {
 if(!toggleState)
  ASPx.RemoveClassNameFromElement(element, className);
 if(toggleState && !ASPx.ElementHasCssClass(element, className))
  ASPx.AddClassNameToElement(element, className);
};
ASPx.GetClassNameList = function(element) {
 var result = [];
 if(element) {
  if(element.tagName === "svg") {
   result = ASPx.GetClassName(element).replace(/^\s+|\s+$/g, '').split(/\s+/);
  }
  else {
   result = element.classList ? [].slice.call(element.classList) : ASPx.GetClassName(element).replace(/^\s+|\s+$/g, '').split(/\s+/);
  }
 }
 return result;
};
ASPx.GetClassName = function(element) {
 var result = "";
 if(element) {
  if(element.tagName === "svg") {
   result = element.className.baseVal;
  }
  else {
   result = element.className ? element.className : "";
  }
 }
 return result;
};
ASPx.SetClassName = function(element, className) {
 if(element.tagName === "svg") {
  element.className.baseVal = Str.Trim(className);
 }
 else {
  element.className = Str.Trim(className);
 }
};
ASPx.GetElementOffsetWidth = function(element) {
 if(element.tagName === "svg") {
  return element.getBoundingClientRect().width;
 }
 else {
  return element.offsetWidth;
 }
};
ASPx.GetElementOffsetHeight = function(element) {
 if(element.tagName === "svg") {
  return element.getBoundingClientRect().height;
 }
 else {
  return element.offsetHeight;
 }
};
function nodeListToArray(nodeList, filter) {
 var result = [];
 for(var i = 0, element; element = nodeList[i]; i++) {
  if(filter && !filter(element))
   continue;
  result.push(element);
 }
 return result;
}
ASPx.NodeListToArray = nodeListToArray;
function getItemByIndex(collection, index) {
 if(!index) index = 0;
 if(collection != null && collection.length > index)
  return collection[index];
 return null;
}
ASPx.GetChildNodesByQuerySelector = function (parent, selector) {
 return nodeListToArray(parent.querySelectorAll(selector), function (el) { return el.parentNode === parent; });
};
ASPx.GetChildNodesByClassName = function(parent, className) {
 if(!parent) return [];
 if(parent.querySelectorAll) {
  var children = parent.querySelectorAll('.' + className);
  return nodeListToArray(children, function(element) { 
   return element.parentNode === parent;
  });
 }
 return ASPx.GetChildNodes(parent, function(elem) { return elem.className && ASPx.ElementHasCssClass(elem, className); });
};
ASPx.GetChildNodesByPartialClassName = function(element, className) {
 return ASPx.GetChildElementNodesByPredicate(element,
  function(child) {
   return ASPx.ElementContainsCssClass(child, className);
  });
};
ASPx.GetChildByPartialClassName = function(element, className, index) {
 if(element != null){    
  var collection = ASPx.GetChildNodesByPartialClassName(element, className);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetChildByClassName = function(element, className, index) {
 if(element != null){    
  var collection = ASPx.GetChildNodesByClassName(element, className);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetNodesByPartialClassName = function(element, className) {
 if(element.querySelectorAll) {
  var list = element.querySelectorAll('*[class*=' + className + ']');
  return nodeListToArray(list);
 }
 var collection = element.all || element.getElementsByTagName('*');
 var ret = [ ];
 if(collection != null) {
  for(var i = 0; i < collection.length; i ++) {
   if(ASPx.ElementContainsCssClass(collection[i], className))
    ret.push(collection[i]);
  }
 }
 return ret;
};
ASPx.GetNodesByClassName = function(parent, className) {
 if(parent.querySelectorAll) {
  var children = parent.querySelectorAll('.' + className);
  return nodeListToArray(children);
 }
 return ASPx.GetNodes(parent, function(elem) { return elem.className && ASPx.ElementHasCssClass(elem, className); });
};
ASPx.GetNodeByClassName = function(element, className, index) {
 if(element != null){    
  var collection = ASPx.GetNodesByClassName(element, className);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetChildById = function(element, id) {
 if(element.all) {
  var child = element.all[id];
  if(!child) {
   child = element.all(id); 
   if(!child)
    return Browser.IE ? document.getElementById(id) : null; 
  } 
  if(!ASPx.IsExists(child.length)) 
   return child;
  else
   return ASPx.GetElementById(id);
 }
 else
  return ASPx.GetElementById(id);
};
ASPx.GetNodesByPartialId = function(element, partialName, list) {
 if(element.id && element.id.indexOf(partialName) > -1) 
  list.push(element);
 if(element.childNodes) {
  for(var i = 0; i < element.childNodes.length; i ++) 
   ASPx.GetNodesByPartialId(element.childNodes[i], partialName, list);
 }
};
ASPx.GetNodesByTagName = function(element, tagName) {
 var tagNameToUpper = tagName.toUpperCase();
 var result = null;
 if(element) {
  if(element.getElementsByTagName) {
   result = element.getElementsByTagName(tagNameToUpper);
   if(result.length === 0) {
    result = element.getElementsByTagName(tagName);
   }
  }
  else if(element.all && element.all.tags !== undefined)
   result = Browser.Netscape ? element.all.tags[tagNameToUpper] : element.all.tags(tagNameToUpper);
 }
 return result;
};
ASPx.GetNodeByTagName = function(element, tagName, index) {
 if(element != null){    
  var collection = ASPx.GetNodesByTagName(element, tagName);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetChildNodesByTagName = function(parent, tagName) {
 return ASPx.GetChildNodes(parent, function (child) { return child.tagName === tagName; });
};
ASPx.GetChildByTagName = function(element, tagName, index) {
 if(element != null){    
  var collection = ASPx.GetChildNodesByTagName(element, tagName);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.RetrieveByPredicate = function(scourceCollection, predicate) {
 var result = [];
 for(var i = 0; i < scourceCollection.length; i++) {
  var element = scourceCollection[i];
  if(!predicate || predicate(element)) 
   result.push(element);
 }
 return result;
};
ASPx.GetChildNodes = function(parent, predicate) {
 return ASPx.RetrieveByPredicate(parent.childNodes, predicate);
};
ASPx.GetNodes = function(parent, predicate) {
 var c = parent.all || parent.getElementsByTagName('*');
 return ASPx.RetrieveByPredicate(c, predicate);
};
ASPx.GetChildElementNodes = function(parent) {
 if(!parent) return null;
 return ASPx.GetChildNodes(parent, function(e) { return e.nodeType == 1; });
};
ASPx.GetChildElementNodesByPredicate = function(parent, predicate) {
 if(!parent) return null;
 if(!predicate) return ASPx.GetChildElementNodes(parent);
 return ASPx.GetChildNodes(parent, function(e) { return e.nodeType == 1 && predicate(e); });
};
ASPx.GetTextNode = function(element, index) {
 if(element != null){
  var collection = [ ];
  ASPx.GetTextNodes(element, collection);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetTextNodes = function(element, collection) {
 if(element.tagName === "svg")
  return;
 for(var i = 0; i < element.childNodes.length; i ++){
  var childNode = element.childNodes[i];
  if(ASPx.IsExists(childNode.nodeValue))
   collection.push(childNode);
  ASPx.GetTextNodes(childNode, collection);
 }
};
ASPx.GetNormalizedTextNode = function(element, index) {
 var textNode = ASPx.GetTextNode(element, index);
 if(textNode != null)
  ASPx.MergeAdjacentTextNodes(textNode);
 return textNode;
};
ASPx.MergeAdjacentTextNodes = function(firstTextNode) {
 if(!ASPx.IsExists(firstTextNode.nodeValue))
  return;
 var textNode = firstTextNode;
 while(textNode.nextSibling && ASPx.IsExists(textNode.nextSibling.nodeValue)) {
  textNode.nodeValue += textNode.nextSibling.nodeValue;
  textNode.parentNode.removeChild(textNode.nextSibling);
 }
};
ASPx.GetElementDocument = function(element) {
 return element.document || element.ownerDocument;
};
ASPx.RemoveElement = function(element) {
 if(element && element.parentNode)
  element.parentNode.removeChild(element);
};
ASPx.ReplaceTagName = function(element, newTagName, cloneChilds) {
 if(element.nodeType != 1)
  return null;
 if(element.nodeName == newTagName)
  return element;
 cloneChilds = cloneChilds !== undefined ? cloneChilds : true;
 var doc = element.ownerDocument;
 var newElem = doc.createElement(newTagName);
 Attr.CopyAllAttributes(element, newElem);
 if(cloneChilds) {
  for(var i = 0; i < element.childNodes.length; i++)
   newElem.appendChild(element.childNodes[i].cloneNode(true));
 }
 else {
  for(var child; child = element.firstChild; )
   newElem.appendChild(child);
 }
 element.parentNode.replaceChild(newElem, element);
 return newElem;
};
ASPx.RemoveOuterTags = function(element) {
 if(ASPx.Browser.IE) {
  element.insertAdjacentHTML( 'beforeBegin', element.innerHTML ) ;
  ASPx.RemoveElement(element);
 } else {
  var docFragment = element.ownerDocument.createDocumentFragment();
  for(var i = 0; i < element.childNodes.length; i++)
   docFragment.appendChild(element.childNodes[i].cloneNode(true));
  element.parentNode.replaceChild(docFragment, element);
 }
};
ASPx.WrapElementInNewElement = function(element, newElementTagName) { 
 var wrapElement = null;
 if(Browser.IE) {
  var wrapElement = element.ownerDocument.createElement(newElementTagName);
  wrapElement.appendChild(element.cloneNode(true));
  element.parentNode.insertBefore(wrapElement, element);
  element.parentNode.removeChild(element);
 } else {
  var docFragment = element.ownerDocument.createDocumentFragment();
  wrapElement = element.ownerDocument.createElement(newElementTagName);
  docFragment.appendChild(wrapElement);
  wrapElement.appendChild(element.cloneNode(true));
  element.parentNode.replaceChild(docFragment, element);
 }
 return wrapElement;
};
ASPx.InsertElementAfter = function(newElement, targetElement) {
 var parentElem = targetElement.parentNode;
 if(parentElem.childNodes[parentElem.childNodes.length - 1] == targetElement)
  parentElem.appendChild(newElement);
 else if(newElement !== targetElement.nextSibling)
  parentElem.insertBefore(newElement, targetElement.nextSibling);
};
ASPx.SetElementOpacity = function(element, value) {
  var useOpacityStyle = !Browser.IE || Browser.Version > 8;
  if(useOpacityStyle){
   element.style.opacity = value;
  } else {
   if(typeof(element.filters) === "object" && element.filters["DXImageTransform.Microsoft.Alpha"])
    element.filters.item("DXImageTransform.Microsoft.Alpha").Opacity = value*100;
   else
   element.style.filter = "alpha(opacity=" + (value * 100) + ")";
  }
};
ASPx.GetElementOpacity = function(element) {
 var useOpacityStyle = !Browser.IE || Browser.Version > 8;
 if(useOpacityStyle)
  return parseFloat(ASPx.GetCurrentStyle(element).opacity);
 else {
  if(typeof(element.filters) === "object" && element.filters["DXImageTransform.Microsoft.Alpha"]){
   return element.filters.item("DXImageTransform.Microsoft.Alpha").Opacity / 100;
  } else {
   var alphaValue = ASPx.GetCurrentStyle(element).filter;
   var value = alphaValue.replace("alpha(opacity=", "");
   value = value.replace(")", "");
   return parseInt(value) / 100;
  }
  return 100;
 }
};
ASPx.HiddenChangable = "dx-hc";
ASPx.DefaultDisplayNoneSelectors = [ "dxmodalSys" ];
ASPx.DefaultDisplaySelectors = ["show"];
function getIsDefaultDisplayNone(element) {
 for(var i = 0; i < ASPx.DefaultDisplayNoneSelectors.length; i++) {
  if(ASPx.ElementHasCssClass(element, ASPx.DefaultDisplayNoneSelectors[i]))
   return true;
 }
 return false;
}
ASPx.GetElementDisplay = function(element, isCurrentStyle) {
 if(isCurrentStyle)
  return ASPx.GetCurrentStyle(element).display != "none";
 if(getIsDefaultDisplayNone(element))
  return element.style.display != "none" && element.style.display != "" || ASPx.DefaultDisplaySelectors.some(function(s) { return ASPx.ElementHasCssClass(element, s); });
 return element.style.display != "none" && !ASPx.ElementHasCssClass(element, ASPx.HiddenChangable);
};
ASPx.SetElementDisplay = function(element, value) {
 if(!element) return;
 if(ASPx.ElementHasCssClass(element, ASPx.HiddenChangable))
  ASPx.RemoveClassNameFromElement(element, ASPx.HiddenChangable);
 if(typeof(value) === "string")
  element.style.display = value;
 else if(getIsDefaultDisplayNone(element))
  element.style.display = value ? (element.tagName === "TABLE" ? "table" : "block") : "";
 else if(!value)
  element.style.display = "none";
 else
  element.style.display = "";
};
ASPx.GetElementVisibility = function(element, isCurrentStyle) {
 if(isCurrentStyle)
  return ASPx.GetCurrentStyle(element).visibility != "hidden";
 return element.style.visibility != "hidden";
};
ASPx.SetElementVisibility = function(element, value) {
 if(!element) return;
 if(typeof(value) === "string")
  element.style.visibility = value;
 else
  element.style.visibility = value ? "visible" : "hidden";
};
ASPx.IsElementVisible = function(element, isCurrentStyle) {
 while(element && element.tagName != "BODY") {
  if(!ASPx.GetElementDisplay(element, isCurrentStyle) || (!ASPx.GetElementVisibility(element, isCurrentStyle) && !Attr.IsExistsAttribute(element, "errorFrame")))
     return false;
  element = element.parentNode;
 }
 return true;
};
ASPx.IsElementDisplayed = function(element) {
 while(element && element.tagName != "BODY") {
  if(!ASPx.GetElementDisplay(element))
     return false;
  element = element.parentNode;
 }
 return true;
};
ASPx.GetElementInitializedFlag = function(element) {
 return element["dxinit"];
};
ASPx.SetElementInitializedFlag = function(element) {
 element["dxinit"] = true;
};
ASPx.AddStyleSheetLinkToDocument = function(doc, linkUrl) {
 var newLink = createStyleLink(doc, linkUrl);
 var head = ASPx.GetHeadElementOrCreateIfNotExist(doc);
 head.appendChild(newLink);
 return newLink;
};
ASPx.GetHeadElementOrCreateIfNotExist = function(doc) {
 var elements = ASPx.GetNodesByTagName(doc, "head");
 var head = null;
 if(elements.length == 0) {
  head = doc.createElement("head");
  head.visibility = "hidden";
  doc.insertBefore(head, doc.body);
 } else
  head = elements[0];
 return head;
};
function createStyleLink(doc, url) {
 var newLink = doc.createElement("link");
 Attr.SetAttribute(newLink, "href", url);
 Attr.SetAttribute(newLink, "rel", "stylesheet");
 Attr.AppendStyleType(newLink);
 return newLink;
}
ASPx.GetCurrentStyle = function(element) {
 if(document.defaultView && document.defaultView.getComputedStyle) { 
  var result = document.defaultView.getComputedStyle(element, null);
  if(!result && Browser.Firefox && window.frameElement) {
   var changes = [];
   var curElement = window.frameElement;
   while(!(result = document.defaultView.getComputedStyle(element, null))) {
    changes.push([curElement, curElement.style.display]);
    ASPx.SetStylesCore(curElement, "display", "block", true);
    curElement = curElement.tagName == "BODY" ? curElement.ownerDocument.defaultView.frameElement : curElement.parentNode;
   }
   result = ASPx.CloneObject(result);
   for(var ch, i = 0; ch = changes[i]; i++)
    ASPx.SetStylesCore(ch[0], "display", ch[1]);
   var dummy = document.body.offsetWidth; 
  }
  if(Browser.Firefox && Browser.MajorVersion >= 62 && window.frameElement && result.length === 0) { 
   result = ASPx.CloneObject(result);
   result.display = element.style.display;
  }
  return result;
 }
 return window.getComputedStyle(element, null);
};
ASPx.CreateStyleSheetInDocument = function(doc) {
 if(doc.createStyleSheet) {
  try {
   return doc.createStyleSheet();
  }
  catch(e) {
   var message = "The CSS link limit (31) has been exceeded. Please enable CSS merging or reduce the number of CSS files on the page. For details, see http://www.devexpress.com/Support/Center/p/K18487.aspx.";
   throw new Error(message);
  }
 }
 else {
  var styleSheet = doc.createElement("STYLE");
  ASPx.GetNodeByTagName(doc, "HEAD", 0).appendChild(styleSheet);
  return styleSheet.sheet;
 }
};
ASPx.currentStyleSheet = null;
ASPx.GetCurrentStyleSheet = function() {
 if(!ASPx.currentStyleSheet)
  ASPx.currentStyleSheet = ASPx.CreateStyleSheetInDocument(document);
 return ASPx.currentStyleSheet;
};
function getStyleSheetRules(styleSheet){
 try {
  if (styleSheet.href && styleSheet.href.indexOf("file:///") === 0)
   return null;
  return Browser.IE && Browser.Version == 8 ? styleSheet.rules : styleSheet.cssRules;
 }
 catch(e) {
  return null;
 }
}
ASPx.cachedCssRules = { };
ASPx.GetStyleSheetRules = function (className, stylesStorageDocument) {
 if(ASPx.cachedCssRules[className]) {
  if(ASPx.cachedCssRules[className] != ASPx.EmptyObject)
   return ASPx.cachedCssRules[className];
  return null;
 }
 var result = iterateStyleSheetRules(stylesStorageDocument, function(rule) {
  if(rule.selectorText == "." + className){
   ASPx.cachedCssRules[className] = rule;
   return rule;
  }
 });
 if(ASPx.IsExists(result))
  return result;
 ASPx.cachedCssRules[className] = ASPx.EmptyObject;
 return null;
};
function iterateStyleSheetRules(stylesStorageDocument, callback) {
 var doc = stylesStorageDocument || document;
 for(var i = 0; i < doc.styleSheets.length; i ++){
  var styleSheet = doc.styleSheets[i];
  var rules = getStyleSheetRules(styleSheet);
  if(rules != null){
   for(var j = 0; j < rules.length; j ++) {
    var result = callback(rules[j]);
    if(result !== undefined)
     return result;
   }
  }
 }
}
ASPx.ProcessStyleSheetRules = function(prefix, callback) {
 iterateStyleSheetRules(null, function(rule) {
  if(!!rule.selectorText && rule.selectorText.indexOf(prefix) === 0) {
   var name = rule.selectorText.substring(prefix.length);
   var result = callback(name, rule.style, rule);
   if(result !== undefined)
    return result;
  }
 });
};
ASPx.ClearCachedCssRules = function(){
 ASPx.cachedCssRules = { };
};
var styleCount = 0;
var styleNameCache = { };
ASPx.CreateImportantStyleRule = function(styleSheet, cssText, postfix, prefix) {
 styleSheet = styleSheet || ASPx.GetCurrentStyleSheet();
 var cacheKey = (postfix ? postfix + "||" : "") + cssText + (prefix ? "||" + prefix : "");
 if(styleNameCache[cacheKey])
  return styleNameCache[cacheKey];
 prefix = prefix ? prefix + " " : "";
 var className = "dxh" + styleCount + (postfix ? postfix : "");
 ASPx.AddStyleSheetRule(styleSheet, prefix + "." + className, ASPx.CreateImportantCssText(cssText));
 styleCount++;
 styleNameCache[cacheKey] = className;
 return className; 
};
ASPx.CreateImportantCssText = function(cssText) {
 var newText = "";
 var hasEncodedSemicolon = cssText.indexOf(ASPx.StyleValueEncodedSemicolon) > -1;
 var attributes = cssText.split(";");
 for(var i = 0; i < attributes.length; i++) {
  var rule = attributes[i];
  if(rule != "")
   newText += ASPx.CreateImportantCssRule(rule, hasEncodedSemicolon);
 }
 return newText;
};
ASPx.CreateImportantCssRule = function(rule, hasEncodedSemicolon) {
 var result = rule;
 if(hasEncodedSemicolon) {
  var regex = new RegExp(ASPx.StyleValueEncodedSemicolon, "g");
  result = result.replace(regex, ";");
 }
 result = result + " !important;";
 return result;
};
ASPx.AddStyleSheetRule = function(styleSheet, selector, cssText){
 if(!cssText) return;
 var index = styleSheet.cssRules.length;
 styleSheet.insertRule(selector + " { " + cssText + " }", index);
 return styleSheet.cssRules[index];
};
ASPx.GetPointerCursor = function() {
 return "pointer";
};
ASPx.SetPointerCursor = function(element) {
 if(element.style.cursor == "")
  element.style.cursor = ASPx.GetPointerCursor();
};
ASPx.SetElementFloat = function(element, value) {
 if(ASPx.IsExists(element.style.cssFloat))
  element.style.cssFloat = value;
 else if(ASPx.IsExists(element.style.styleFloat))
  element.style.styleFloat = value;
 else
  Attr.SetAttribute(element.style, "float", value);
};
ASPx.GetElementFloat = function(element) {
 var currentStyle = ASPx.GetCurrentStyle(element);
 if(ASPx.IsExists(currentStyle.cssFloat))
  return currentStyle.cssFloat;
 if(ASPx.IsExists(currentStyle.styleFloat))
  return currentStyle.styleFloat;
 return Attr.GetAttribute(currentStyle, "float");
};
function getElementDirection(element) {
 return ASPx.GetCurrentStyle(element).direction;
}
ASPx.IsElementRightToLeft = function(element) {
 return getElementDirection(element) == "rtl";
};
ASPx.AdjustVerticalMarginsInContainer = function(container) {
 var containerBorderAndPaddings = ASPx.GetTopBottomBordersAndPaddingsSummaryValue(container);
 var flowElements = [], floatElements = [], floatTextElements = [];
 var maxHeight = 0, maxFlowHeight = 0;
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  ASPx.ClearVerticalMargins(element);
 }
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  var float = ASPx.GetElementFloat(element);
  var isFloat = (float === "left" || float === "right");
  if(isFloat)
   floatElements.push(element);
  else {
   flowElements.push(element);
   if(element.tagName !== "IMG"){
    if(!ASPx.IsTextWrapped(element))
     element.style.verticalAlign = 'baseline'; 
    floatTextElements.push(element);
   }
   if(element.tagName === "DIV")
    Attr.ChangeStyleAttribute(element, "float", "left"); 
  }
  if(element.offsetHeight > maxHeight) 
   maxHeight = element.offsetHeight;
  if(!isFloat && element.offsetHeight > maxFlowHeight) 
   maxFlowHeight = element.offsetHeight;
 }
 for(var i = 0; i < flowElements.length; i++) 
  Attr.RestoreStyleAttribute(flowElements[i], "float");
 var containerBorderAndPaddings = ASPx.GetTopBottomBordersAndPaddingsSummaryValue(container);
 var containerHeight = container.offsetHeight - containerBorderAndPaddings;
 if(maxHeight == containerHeight) {
  var verticalAlign = ASPx.GetCurrentStyle(container).verticalAlign;
  for(var i = 0; i < floatTextElements.length; i++)
   floatTextElements[i].style.verticalAlign = '';
  containerHeight = container.offsetHeight - containerBorderAndPaddings;
  for(var i = 0; i < floatElements.length; i++)
   adjustVerticalMarginsCore(floatElements[i], containerHeight, verticalAlign, true);
  for(var i = 0; i < flowElements.length; i++) {
   if(maxFlowHeight != maxHeight)
    adjustVerticalMarginsCore(flowElements[i], containerHeight, verticalAlign);
  }
 }
};
ASPx.AdjustVerticalMargins = function(element) {
 ASPx.ClearVerticalMargins(element);
 var parentElement = element.parentNode;
 var parentHeight = parentElement.getBoundingClientRect().height - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(parentElement);
 adjustVerticalMarginsCore(element, parentHeight, ASPx.GetCurrentStyle(parentElement).verticalAlign);
};
function adjustVerticalMarginsCore(element, parentHeight, verticalAlign, toBottom) {
 var marginTop;
 if(verticalAlign == "top")
  marginTop = 0;
 else if(verticalAlign == "bottom")
  marginTop = parentHeight - element.getBoundingClientRect().height;
 else
  marginTop = (parentHeight - element.getBoundingClientRect().height) / 2;
 if(marginTop !== 0){
  element.style.marginTop = marginTop + "px";
 }
}
ASPx.ClearVerticalMargins = function(element) {
 element.style.marginTop = "";
 element.style.marginBottom = "";
};
ASPx.AdjustHeightInContainer = function(container) {
 var height = container.offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(container);
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  ASPx.ClearHeight(element);
 }
 var elements = [];
 var childrenHeight = 0;
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  childrenHeight += element.offsetHeight + ASPx.GetTopBottomMargins(element);
  elements.push(element);
 }
 if(elements.length > 0 && childrenHeight < height) {
  var correctedHeight = 0;
  for(var i = 0; i < elements.length; i++) {
   var elementHeight = 0;
   if(i < elements.length - 1){
    var elementHeight = Math.floor(height / elements.length);
    correctedHeight += elementHeight;
   }
   else{
    var elementHeight = height - correctedHeight;
    if(elementHeight < 0) elementHeight = 0;
   }
   adjustHeightCore(elements[i], elementHeight);
  }
 }
};
ASPx.AdjustHeight = function(element) {
 ASPx.ClearHeight(element);
 var parentElement = element.parentNode;
 var height = parentElement.getBoundingClientRect().height - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(parentElement);
 adjustHeightCore(element, height);
};
function adjustHeightCore(element, height) {
 var height = height - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element);
 if(height < 0) height = 0;
 element.style.height = height + "px";
}
ASPx.ClearHeight = function(element) {
 element.style.height = "";
};
ASPx.ShrinkWrappedTextInContainer = function(container) {
 if(!container) return;
 for(var i = 0; i < container.childNodes.length; i++){
  var child = container.childNodes[i];
  if(child.style && ASPx.IsTextWrapped(child)) {
   Attr.ChangeStyleAttribute(child, "width", "1px");
   child.shrinkedTextContainer = true;
  }
 }
};
ASPx.AdjustWrappedTextInContainer = function(container) {
 if(!container) return;
 var textContainer, leftWidth = 0, rightWidth = 0;
 for(var i = 0; i < container.childNodes.length; i++){
  var child = container.childNodes[i];
  if(child.tagName === "BR")
   return;
  if(!child.tagName)
   continue;
  if(child.tagName !== "IMG"){
   textContainer = child;
   if(ASPx.IsTextWrapped(textContainer)){
    if(!textContainer.shrinkedTextContainer)
     textContainer.style.width = "";
    textContainer.style.marginRight = "";
   }
  }
  else {
   if(ASPx.GetElementOffsetWidth(child)=== 0)
    Evt.AttachEventToElement(child, "load", function(evt) { ASPx.AdjustWrappedTextInContainer(container); });
   else {
    var width = ASPx.GetElementOffsetWidth(child) + ASPx.GetLeftRightMargins(child);
    if(textContainer)
     rightWidth += width;
    else
     leftWidth += width;
   }
  }
 }
 if(textContainer && ASPx.IsTextWrapped(textContainer)) {
  var containerWidth = ASPx.GetElementOffsetWidth(container) - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(container);
  if(textContainer.shrinkedTextContainer) {
   Attr.RestoreStyleAttribute(textContainer, "width");
   Attr.ChangeStyleAttribute(container, "width", containerWidth + "px");
  }
  if(ASPx.GetElementOffsetWidth(textContainer) + leftWidth + rightWidth >= containerWidth) {
    if(rightWidth > 0 && !textContainer.shrinkedTextContainer)
    textContainer.style.width = (containerWidth - rightWidth) + "px";
   else if(leftWidth > 0){
    if(ASPx.IsElementRightToLeft(container))
     textContainer.style.marginLeft = leftWidth + "px";
    else
     textContainer.style.marginRight = leftWidth + "px";
   }
  }
 }
};
ASPx.IsTextWrapped = function(element) {
 return element && ASPx.GetCurrentStyle(element).whiteSpace !== "nowrap";
};
ASPx.IsValidPosition = function(pos){
 return pos != ASPx.InvalidPosition && pos != -ASPx.InvalidPosition;
};
ASPx.getSpriteMainElement = function(element) {
 var cssClassMarker = "dx-acc";
 if(ASPx.ElementContainsCssClass(element, cssClassMarker))
  return element;
 if(element.parentNode && ASPx.ElementContainsCssClass(element.parentNode, cssClassMarker))
  return element.parentNode;
 return element;
};
ASPx.GetAbsoluteX = function(curEl){
 return ASPx.GetAbsolutePositionX(curEl);
};
ASPx.GetAbsoluteY = function(curEl){
 return ASPx.GetAbsolutePositionY(curEl);
};
ASPx.SetAbsoluteX = function(element, x){
 element.style.left = ASPx.PrepareClientPosForElement(x, element, true) + "px";
};
ASPx.SetAbsoluteY = function(element, y){
 element.style.top = ASPx.PrepareClientPosForElement(y, element, false) + "px";
};
ASPx.GetAbsolutePositionX = function(element){
 if(Browser.IE)
  return getAbsolutePositionX_IE(element);
 else if(Browser.Firefox && Browser.Version >= 3)
  return getAbsolutePositionX_FF3(element);
 else if(Browser.Opera)
  return getAbsolutePositionX_Opera(element);
 else if(Browser.NetscapeFamily && (!Browser.Firefox || Browser.Version < 3))
  return getAbsolutePositionX_NS(element);
 else if(Browser.WebKitFamily || Browser.Edge)
  return getAbsolutePositionX_FF3(element);
 else
  return getAbsolutePositionX_Other(element);
};
function getAbsolutePositionX_Opera(curEl){
 var isFirstCycle = true;
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, true);
 while(curEl != null) {
  pos += curEl.offsetLeft;
  if(!isFirstCycle)
   pos -= curEl.scrollLeft;
  curEl = curEl.offsetParent;
  isFirstCycle = false;
 }
 pos += document.body.scrollLeft;
 return pos;
}
function getAbsolutePositionX_IE(element){
 if(element == null || Browser.IE && element.parentNode == null) return 0; 
 return element.getBoundingClientRect().left + ASPx.GetDocumentScrollLeft();
}
function getAbsolutePositionX_FF3(element){
 if(element == null) return 0;
 var x = element.getBoundingClientRect().left + ASPx.GetDocumentScrollLeft();
 return x;
}
function getAbsolutePositionX_NS(curEl){
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, true);
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetLeft;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollLeft;
  if(!isFirstCycle && Browser.Firefox){
   var style = ASPx.GetCurrentStyle(curEl);
   if(curEl.tagName == "DIV" && style.overflow != "visible")
    pos += ASPx.PxToInt(style.borderLeftWidth);
  }
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
function getAbsolutePositionX_Other(curEl){
 var pos = 0;
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetLeft;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollLeft;
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
ASPx.GetAbsolutePositionY = function(element){
 if(Browser.IE)
  return getAbsolutePositionY_IE(element);
 else if(Browser.Firefox && Browser.Version >= 3)
  return getAbsolutePositionY_FF3(element);
 else if(Browser.Opera)
  return getAbsolutePositionY_Opera(element);
 else if(Browser.NetscapeFamily && (!Browser.Firefox || Browser.Version < 3))
  return getAbsolutePositionY_NS(element);
 else if(Browser.WebKitFamily || Browser.Edge)
  return getAbsolutePositionY_FF3(element);
 else
  return getAbsolutePositionY_Other(element);
};
function getAbsolutePositionY_Opera(curEl){
 var isFirstCycle = true;
 if(curEl && curEl.tagName == "TR" && curEl.cells.length > 0)
  curEl = curEl.cells[0];
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, false);
 while(curEl != null) {
  pos += curEl.offsetTop;
  if(!isFirstCycle)
   pos -= curEl.scrollTop;
  curEl = curEl.offsetParent;
  isFirstCycle = false;
 }
 pos += document.body.scrollTop;
 return pos;
}
function getAbsolutePositionY_IE(element){
 if(element == null || Browser.IE && element.parentNode == null) return 0; 
 return element.getBoundingClientRect().top + ASPx.GetDocumentScrollTop();
}
function getAbsolutePositionY_FF3(element){
 if(element == null) return 0;
 var y = element.getBoundingClientRect().top + ASPx.GetDocumentScrollTop();
 return y;
}
function getAbsolutePositionY_NS(curEl){
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, false);
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetTop;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollTop;
  if(!isFirstCycle && Browser.Firefox){
   var style = ASPx.GetCurrentStyle(curEl);
   if(curEl.tagName == "DIV" && style.overflow != "visible")
    pos += ASPx.PxToInt(style.borderTopWidth);
  }
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
function getAbsoluteScrollOffset_OperaFF(curEl, isX) {
 var pos = 0;   
 var isFirstCycle = true;
 while(curEl != null) {
  if(curEl.tagName == "BODY")
   break;
  var style = ASPx.GetCurrentStyle(curEl);
  if(style.position == "absolute")
   break;
  if(!isFirstCycle && curEl.tagName == "DIV" && (style.position == "" || style.position == "static"))
   pos -= isX ? curEl.scrollLeft : curEl.scrollTop;
  curEl = curEl.parentNode;
  isFirstCycle = false;
 }
 return pos; 
}
function getAbsolutePositionY_Other(curEl){
 var pos = 0;
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetTop;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollTop;
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
function createElementMock(element) {
 var div = document.createElement('DIV');
 div.style.top = "0px";
 div.style.left = "0px";
 div.visibility = "hidden";
 div.style.position = ASPx.GetCurrentStyle(element).position;
 return div;
}
ASPx.PrepareClientPosElementForOtherParent = function(pos, element, otherParent, isX) {
 if(element.parentNode == otherParent)
  return ASPx.PrepareClientPosForElement(pos, element, isX);
 var elementMock = createElementMock(element);
 otherParent.appendChild(elementMock); 
 var preparedPos = ASPx.PrepareClientPosForElement(pos, elementMock, isX);
 otherParent.removeChild(elementMock);
 return preparedPos;
};
ASPx.PrepareClientPosForElement = function(pos, element, isX) {
 pos -= ASPx.GetPositionElementOffset(element, isX);
 return pos;
};
function getExperimentalPositionOffset(element, isX) {
 var div = createElementMock(element);
 if(div.style.position == "static")
  div.style.position = "absolute";
 element.parentNode.appendChild(div); 
 var realPos = isX ? ASPx.GetAbsoluteX(div) : ASPx.GetAbsoluteY(div);
 element.parentNode.removeChild(div);
 return realPos;
}
ASPx.GetPositionElementOffset = function(element, isX) {
 return getExperimentalPositionOffset(element, isX);
};
ASPx.GetSizeOfText = function(text, textCss) {
 var testContainer = document.createElement("tester");
 var defaultLineHeight = ASPx.Browser.Firefox ? "1" : "";
 testContainer.style.fontSize = textCss.fontSize;
 testContainer.style.fontFamily = textCss.fontFamily;
 testContainer.style.fontWeight = textCss.fontWeight;
 testContainer.style.letterSpacing = textCss.letterSpacing;
 testContainer.style.lineHeight = textCss.lineHeight || defaultLineHeight;
 testContainer.style.position = "absolute";
 testContainer.style.top = ASPx.InvalidPosition + "px";
 testContainer.style.left = ASPx.InvalidPosition + "px";
 testContainer.style.width = "auto";
 testContainer.style.whiteSpace = "nowrap";
 testContainer.appendChild(document.createTextNode(text));
 var testElement = document.body.appendChild(testContainer);
 var size = {
  "width": testElement.offsetWidth,
  "height": testElement.offsetHeight
 };
 document.body.removeChild(testElement);
 return size;
};
ASPx.PointToPixel = function(points, addPx) {  
 var result = 0;
 try {
  var indexOfPt = points.toLowerCase().indexOf("pt");
  if(indexOfPt > -1)
   result = parseInt(points.substr(0, indexOfPt)) * 96 / 72;
  else
   result = parseInt(points) * 96 / 72;
  if(addPx)
   result = result + "px";
 } catch(e) {}
 return result;
};
ASPx.PixelToPoint = function(pixels, addPt) { 
 var result = 0;
 try {
  var indexOfPx = pixels.toLowerCase().indexOf("px");
  if(indexOfPx > -1)
   result = parseInt(pixels.substr(0, indexOfPx)) * 72 / 96;
  else
   result = parseInt(pixels) * 72 / 96;
  if(addPt)
   result = result + "pt";
 } catch(e) {}
 return result;         
};
ASPx.PxToInt = function(px) {
 return pxToNumber(px, parseInt);
};
ASPx.PxToFloat = function(px) {
 return pxToNumber(px, parseFloat);
};
function pxToNumber(px, parseFunction) {
 var result = 0;
 if(px != null && px != "") {
  try {
   var indexOfPx = px.indexOf("px");
   if(indexOfPx > -1)
    result = parseFunction(px.substr(0, indexOfPx));
  } catch(e) { }
 }
 return result;
}
ASPx.PercentageToFloat = function(perc) {
 var result = 0;
 if(perc != null && perc != "") {
  try {
   var indexOfPerc = perc.indexOf("%");
   if(indexOfPerc > -1)
    result = parseFloat(perc.substr(0, indexOfPerc)) / 100;
  } catch(e) { }
 }
 return result;
};
ASPx.CreateGuid = function() {
 return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) { 
   var r = Math.random()*16|0,v=c=='x'?r:r&0x3|0x8;
  return v.toString(16);
 });
};
ASPx.GetLeftRightBordersAndPaddingsSummaryValue = function(element, currentStyle) {
 return ASPx.GetLeftRightPaddings(element, currentStyle) + ASPx.GetHorizontalBordersWidth(element, currentStyle);
};
ASPx.GetTopBottomBordersAndPaddingsSummaryValue = function(element, currentStyle) {
 return ASPx.GetTopBottomPaddings(element, currentStyle) + ASPx.GetVerticalBordersWidth(element, currentStyle);
};
ASPx.GetVerticalBordersWidth = function(element, style) {
 if(!ASPx.IsExists(style))
  style = (Browser.IE && Browser.MajorVersion != 9 && window.getComputedStyle) ? window.getComputedStyle(element) : ASPx.GetCurrentStyle(element);
 var res = 0;
 if(style.borderTopStyle != "none") {
  res += ASPx.PxToFloat(style.borderTopWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderTopWidth);
 }
 if(style.borderBottomStyle != "none") {
  res += ASPx.PxToFloat(style.borderBottomWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderBottomWidth);
 }
 return res;
};
ASPx.GetHorizontalBordersWidth = function(element, style) {
 if(!ASPx.IsExists(style))
  style = (Browser.IE && window.getComputedStyle) ? window.getComputedStyle(element) : ASPx.GetCurrentStyle(element);
 var res = 0;
 if(style.borderLeftStyle != "none") {
  res += ASPx.PxToFloat(style.borderLeftWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderLeftWidth);
 }
 if(style.borderRightStyle != "none") {
  res += ASPx.PxToFloat(style.borderRightWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderRightWidth);
 }
 return res;
};
function getIe8BorderWidthFromText(textWidth) {
 var availableWidth = { "thin": 1, "medium" : 3, "thick": 5 };
 var width = availableWidth[textWidth];
 return width ? width : 0;
}
ASPx.GetTopBottomPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingTop) + ASPx.PxToInt(currentStyle.paddingBottom);
};
ASPx.GetTopPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingTop);
};
ASPx.GetBottomPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingBottom);
};
ASPx.GetLeftRightPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingLeft) + ASPx.PxToInt(currentStyle.paddingRight);
};
ASPx.GetTopBottomMargins = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.marginTop) + ASPx.PxToInt(currentStyle.marginBottom);
};
ASPx.GetLeftRightMargins = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.marginLeft) + ASPx.PxToInt(currentStyle.marginRight);
};
ASPx.GetClearClientWidth = function(element) {
 return ASPx.GetElementOffsetWidth(element)- ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element);
};
ASPx.GetClearClientHeight = function(element) {
 return ASPx.GetElementOffsetHeight(element) - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element);
};
ASPx.SetOffsetWidth = function(element, widthValue, currentStyle) {
 if(!ASPx.IsExists(currentStyle))
  currentStyle = ASPx.GetCurrentStyle(element);
 var value = widthValue - ASPx.PxToInt(currentStyle.marginLeft) - ASPx.PxToInt(currentStyle.marginRight);
  value -= ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element, currentStyle);
 if(value > -1)
  element.style.width = value + "px";
};
ASPx.SetOffsetHeight = function(element, heightValue, currentStyle) {
 if(!ASPx.IsExists(currentStyle))
  currentStyle = ASPx.GetCurrentStyle(element);
 var value = heightValue - ASPx.PxToInt(currentStyle.marginTop) - ASPx.PxToInt(currentStyle.marginBottom);
  value -= ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element, currentStyle);
 if(value > -1)
  element.style.height = value + "px";
};
ASPx.FindOffsetParent = function(element) {
 var currentElement = element.parentNode;
 while(ASPx.IsExistsElement(currentElement) && currentElement.tagName != "BODY") {
  if(ASPx.GetElementOffsetWidth(currentElement) > 0 && ASPx.GetElementOffsetHeight(currentElement) > 0)
   return currentElement;
  currentElement = currentElement.parentNode;
 }
 return document.body;
};
ASPx.GetDocumentScrollTop = function(){
 var isScrollBodyIE = Browser.IE && ASPx.GetCurrentStyle(document.body).overflow == "hidden" && document.body.scrollTop > 0;
 if(Browser.WebKitFamily || Browser.Edge || isScrollBodyIE) {
  if(Browser.MacOSMobilePlatform) 
   return window.pageYOffset;
  if(Browser.WebKitFamily)
   return document.documentElement.scrollTop || document.body.scrollTop;
  return document.body.scrollTop;
 }
 else
  return document.documentElement.scrollTop;
};
ASPx.SetDocumentScrollTop = function(scrollTop) {
 if(Browser.WebKitFamily && Browser.Version < 60 || Browser.Edge)
  document.body.scrollTop = scrollTop;
 else
  document.documentElement.scrollTop = scrollTop;
};
ASPx.GetDocumentScrollLeft = function(){
 var isScrollBodyIE = Browser.IE && ASPx.GetCurrentStyle(document.body).overflow == "hidden" && document.body.scrollLeft > 0;
 if(Browser.Edge || isScrollBodyIE)
  return document.body ? document.body.scrollLeft : document.documentElement.scrollLeft;
 if(Browser.WebKitFamily)
  return document.documentElement.scrollLeft || document.body.scrollLeft;
 return document.documentElement.scrollLeft;
};
ASPx.SetDocumentScrollLeft = function (scrollLeft) {
 if(Browser.WebKitFamily && Browser.Version < 60 || Browser.Edge)
  document.body.scrollLeft = scrollLeft;
 else
  document.documentElement.scrollLeft = scrollLeft;
};
ASPx.GetDocumentClientWidth = function(){
 if(document.documentElement.clientWidth == 0)
  return document.body.clientWidth;
 else
  return document.documentElement.clientWidth;
};
ASPx.GetDocumentClientHeight = function() {
 if(Browser.Firefox && window.innerHeight - document.documentElement.clientHeight > ASPx.GetVerticalScrollBarWidth()) {
  return window.innerHeight;
 } else if(Browser.Opera && Browser.Version < 9.6 || document.documentElement.clientHeight == 0) {
   return document.body.clientHeight;
 }
 return document.documentElement.clientHeight;
};
ASPx.GetDocumentWidth = function(){
 var bodyWidth = document.body.offsetWidth;
 var docWidth = Browser.IE ? document.documentElement.clientWidth : document.documentElement.offsetWidth;
 var bodyScrollWidth = document.body.scrollWidth;
 var docScrollWidth = document.documentElement.scrollWidth;
 return getMaxDimensionOf(bodyWidth, docWidth, bodyScrollWidth, docScrollWidth);
};
ASPx.GetDocumentHeight = function(){
 var bodyHeight = document.body.offsetHeight;
 var docHeight = Browser.IE ? document.documentElement.clientHeight : document.documentElement.offsetHeight;
 var bodyScrollHeight = document.body.scrollHeight;
 var docScrollHeight = document.documentElement.scrollHeight;
 var maxHeight = getMaxDimensionOf(bodyHeight, docHeight, bodyScrollHeight, docScrollHeight);
 if(Browser.Opera && Browser.Version >= 9.6){
  if(Browser.Version < 10)
   maxHeight = getMaxDimensionOf(bodyHeight, docHeight, bodyScrollHeight);
  var visibleHeightOfDocument = document.documentElement.clientHeight;
  if(maxHeight > visibleHeightOfDocument)
   maxHeight = getMaxDimensionOf(window.outerHeight, maxHeight);
  else
   maxHeight = document.documentElement.clientHeight;
  return maxHeight;
 }
 return maxHeight;
};
ASPx.GetDocumentMaxClientWidth = function(){
 var bodyWidth = document.body.offsetWidth;
 var docWidth = document.documentElement.offsetWidth;
 var docClientWidth = document.documentElement.clientWidth;
 return getMaxDimensionOf(bodyWidth, docWidth, docClientWidth);
};
ASPx.GetDocumentMaxClientHeight = function(){
 var bodyHeight = document.body.offsetHeight;
 var docHeight = document.documentElement.offsetHeight;
 var docClientHeight = document.documentElement.clientHeight;
 return getMaxDimensionOf(bodyHeight, docHeight, docClientHeight);
};
ASPx.verticalScrollIsNotHidden = null;
ASPx.horizontalScrollIsNotHidden = null;
ASPx.GetVerticalScrollIsNotHidden = function() {
 if(!ASPx.IsExists(ASPx.verticalScrollIsNotHidden))
  ASPx.verticalScrollIsNotHidden = ASPx.GetCurrentStyle(document.body).overflowY !== "hidden"
   && ASPx.GetCurrentStyle(document.documentElement).overflowY !== "hidden";
 return ASPx.verticalScrollIsNotHidden;
};
ASPx.GetHorizontalScrollIsNotHidden = function() {
 if(!ASPx.IsExists(ASPx.horizontalScrollIsNotHidden))
  ASPx.horizontalScrollIsNotHidden = ASPx.GetCurrentStyle(document.body).overflowX !== "hidden"
   && ASPx.GetCurrentStyle(document.documentElement).overflowX !== "hidden";
 return ASPx.horizontalScrollIsNotHidden;
};
ASPx.GetCurrentDocumentWidth = function() {
 var result = ASPx.GetDocumentClientWidth();
 if(!ASPx.Browser.Safari && ASPx.GetVerticalScrollIsNotHidden() && ASPx.GetDocumentHeight() > ASPx.GetDocumentClientHeight())
  result += ASPx.GetVerticalScrollBarWidth();
 return result;
};
ASPx.GetCurrentDocumentHeight = function() {
 var result = ASPx.GetDocumentClientHeight();
 if(!ASPx.Browser.Safari && ASPx.GetHorizontalScrollIsNotHidden() && ASPx.GetDocumentWidth() > ASPx.GetDocumentClientWidth())
  result += ASPx.GetVerticalScrollBarWidth();
 return result;
};
function getMaxDimensionOf(){
 var max = ASPx.InvalidDimension;
 for(var i = 0; i < arguments.length; i++){
  if(max < arguments[i])
   max = arguments[i];
 }
 return max;
}
ASPx.GetClientLeft = function(element) {
 return ASPx.IsExists(element.clientLeft) ? element.clientLeft : (ASPx.GetElementOffsetWidth(element)- element.clientWidth) / 2;
};
ASPx.GetClientTop = function(element) {
 return ASPx.IsExists(element.clientTop) ? element.clientTop : (ASPx.GetElementOffsetHeight(element) - element.clientHeight) / 2;
};
var requestAnimationFrameFunc = window.requestAnimationFrame || function(callback) { callback(); };
var cancelAnimationFrameFunc = window.cancelAnimationFrame || function(id) { };
ASPx.CancelAnimationFrame = function(id) { cancelAnimationFrameFunc(id); };
ASPx.RequestAnimationFrame = function (callback) { return requestAnimationFrameFunc(callback); };
ASPx.SetStyles = function(element, styles, makeImportant) {
 if(ASPx.IsExists(styles.cssText))
  element.style.cssText = styles.cssText;
 if(ASPx.IsExists(styles.className)) {
  ASPx.SetClassName(element, styles.className);
 }
 for(var property in styles) {
  if(!styles.hasOwnProperty(property))
   continue;
  var value = styles[property];
  switch (property) {
   case "cssText":
   case "className":
    break;
   case "float":
    ASPx.SetElementFloat(element, value);
    break;
   case "opacity":
    ASPx.SetElementOpacity(element, value);
    break;
   case "zIndex":
    ASPx.SetStylesCore(element, property, value, makeImportant);
    break;
   case "fontWeight":
    if(ASPx.Browser.IE && ASPx.Browser.Version < 9 && typeof(styles[property]) == "number")
     value = styles[property].toString();
   default:
    ASPx.SetStylesCore(element, property, value + (typeof (value) == "number" ? "px" : ""), makeImportant);
  }
 }
};
ASPx.SetStylesCore = function(element, property, value, makeImportant) {
 if(makeImportant) {
  var index = property.search("[A-Z]");
  if(index != -1)
   property = property.replace(property.charAt(index), "-" + property.charAt(index).toLowerCase());
  if(element.style.setProperty)
   element.style.setProperty(property, value, "important");
  else 
   element.style.cssText += ";" + property + ":" + value + "!important";
 }
 else
  element.style[property] = value;
};
ASPx.RemoveBordersAndShadows = function(el) {
 if(!el || !el.style)
  return;
 el.style.borderWidth = 0;
 if(ASPx.IsExists(el.style.boxShadow))
  el.style.boxShadow = "none";
 else if(ASPx.IsExists(el.style.MozBoxShadow))
  el.style.MozBoxShadow = "none";
 else if(ASPx.IsExists(el.style.webkitBoxShadow))
  el.style.webkitBoxShadow = "none";
};
ASPx.GetCellSpacing = function(element) {
 var val = parseInt(element.cellSpacing);
 if(!isNaN(val)) return val;
 val = parseInt(ASPx.GetCurrentStyle(element).borderSpacing);
 if(!isNaN(val)) return val;
 return 0;
};
ASPx.GetInnerScrollPositions = function(element) {
 var scrolls = [];
 getInnerScrollPositionsCore(element, scrolls);
 return scrolls;
};
function getInnerScrollPositionsCore(element, scrolls) {
 for(var child = element.firstChild; child; child = child.nextSibling) {
  var scrollTop = child.scrollTop,
   scrollLeft = child.scrollLeft;
  if(scrollTop > 0 || scrollLeft > 0)
   scrolls.push([child, scrollTop, scrollLeft]);
  getInnerScrollPositionsCore(child, scrolls);
 }
}
ASPx.RestoreInnerScrollPositions = function(scrolls) {
 for(var i = 0, scrollArr; scrollArr = scrolls[i]; i++) {
  if(scrollArr[1] > 0)
   scrollArr[0].scrollTop = scrollArr[1];
  if(scrollArr[2] > 0)
   scrollArr[0].scrollLeft = scrollArr[2];
 }
};
ASPx.GetOuterScrollPosition = function(element) {
 while(element && element.tagName !== "BODY") {
  var scrollTop = element.scrollTop,
   scrollLeft = element.scrollLeft;
  if(scrollTop > 0 || scrollLeft > 0) {
   return {
    scrollTop: scrollTop,
    scrollLeft: scrollLeft,
    element: element
   };
  }
  element = element.parentNode;
 }
 return {
  scrollTop: ASPx.GetDocumentScrollTop(),
  scrollLeft: ASPx.GetDocumentScrollLeft()
 };
};
ASPx.RestoreOuterScrollPosition = function(scrollInfo) {
 if(scrollInfo.element) {
  if(scrollInfo.scrollTop > 0)
   scrollInfo.element.scrollTop = scrollInfo.scrollTop;
  if(scrollInfo.scrollLeft > 0)
   scrollInfo.element.scrollLeft = scrollInfo.scrollLeft;
 }
 else {
  if(scrollInfo.scrollTop > 0)
   ASPx.SetDocumentScrollTop(scrollInfo.scrollTop);
  if(scrollInfo.scrollLeft > 0)
   ASPx.SetDocumentScrollLeft(scrollInfo.scrollLeft);
 }
};
ASPx.ChangeElementContainer = function(element, container, savePreviousContainer) {
 if(element.parentNode != container) {
  var parentNode = element.parentNode;
  parentNode.removeChild(element);
  container.appendChild(element);
  if(savePreviousContainer)
   element.previousContainer = parentNode;
 }
};
ASPx.RestoreElementContainer = function(element) {
 if(element.previousContainer) {
  ASPx.ChangeElementContainer(element, element.previousContainer, false);
  element.previousContainer = null;
 }
};
ASPx.MoveChildrenToElement = function(sourceElement, destinationElement){
 while(sourceElement.childNodes.length > 0)
  destinationElement.appendChild(sourceElement.childNodes[0]);
};
ASPx.GetScriptCode = function(script) {
 var useFirstChildElement = Browser.Chrome && Browser.Version < 11 || Browser.Safari && Browser.Version < 5; 
 var text = useFirstChildElement ? script.firstChild.data : script.text;
 var comment = "<!--";
 var pos = text.indexOf(comment);
 if(pos > -1)
  text = text.substr(pos + comment.length);
 return text;
};
ASPx.AppendScript = function(script) {
 var parent = document.getElementsByTagName("head")[0];
 if(!parent)
  parent = document.body;
 if(parent)
  parent.appendChild(script);
};
function getFrame(frames, name) {
 if(frames[name])
  return frames[name];
 for(var i = 0; i < frames.length; i++) {
  try {
   var frame = frames[i];
   if(frame.name == name) 
    return frame; 
   frame = getFrame(frame.frames, name);
   if(frame != null)   
    return frame; 
  } catch(e) {
  } 
 }
 return null;
}
ASPx.IsValidElement = function(element) {
 if(!element) 
  return false;
 if(!(Browser.Firefox && Browser.Version < 4)) {
  if(element.ownerDocument && element.ownerDocument.body && element.ownerDocument.body.compareDocumentPosition)
   return element.ownerDocument.body.compareDocumentPosition(element) % 2 === 0;
 }
 if(!Browser.Opera && !(Browser.IE && Browser.Version < 9) && element.offsetParent && element.parentNode.tagName)
  return true;
 while(element != null){
  if(element.tagName == "BODY")
   return true;
  element = element.parentNode;
 }
 return false;
};
ASPx.IsValidElements = function(elements) {
 if(!elements)
  return false; 
 for(var i = 0; i < elements.length; i++) {
  if(elements[i] && !ASPx.IsValidElement(elements[i]))
   return false;
 }
 return true;
};
ASPx.IsExistsElement = function(element) {
 return element && ASPx.IsValidElement(element);
};
ASPx.CreateHtmlElementFromString = function(str) {
 var dummy = ASPx.CreateHtmlElement();
 setInnerHtmlInternal(dummy, str);
 return dummy.firstChild;
};
ASPx.CreateHtmlElement = function(tagName, styles) {
 var element = document.createElement(tagName || "DIV");
 if(styles)
  ASPx.SetStyles(element, styles);
 return element;
};
ASPx.RestoreElementOriginalWidth = function(element) {
 if(!ASPx.IsExistsElement(element)) 
  return;
 element.style.width = element.dxOrigWidth = ASPx.GetElementOriginalWidth(element);
};
ASPx.GetElementOriginalWidth = function(element) {
 if(!ASPx.IsExistsElement(element)) 
  return null;
 var width;
 if(!ASPx.IsExists(element.dxOrigWidth)) {
  width = String(element.style.width).length > 0
   ? element.style.width
   : ASPx.GetElementOffsetWidth(element) + "px";
 } else {
  width = element.dxOrigWidth;
 }
 return width;
};
ASPx.DropElementOriginalWidth = function(element) {
 if(ASPx.IsExists(element.dxOrigWidth))
  element.dxOrigWidth = null;
};
ASPx.GetObjectKeys = function(obj) {
 if(!obj) return [ ];
 if(Object.keys)
  return Object.keys(obj);
 var keys = [ ];
 for(var key in obj) {
  if(obj.hasOwnProperty(key))
   keys.push(key);
 }
 return keys;
};
ASPx.ShowErrorAlert = function(message) {
 message = ASPx.Str.DecodeHtmlViaTextArea(message);
 if(ASPx.IsExists(message) && message !== "")
  alert(message);
};
ASPx.ShowKBErrorMessage = function(text, kbid) {
 ASPx.ShowErrorMessage(text + "https://www.devexpress.com/kbid=" + kbid + ".");
};
ASPx.ShowErrorMessage = function(errorMessage) {
 var console = window.console;
 if(!console || !ASPx.IsFunction(console.error))
  return;
 console.error(errorMessage);
};
ASPx.IsInteractiveControl = function(element, extremeParent) { 
 return Data.ArrayIndexOf(["A", "INPUT", "SELECT", "OPTION", "TEXTAREA", "BUTTON", "IFRAME"], element.tagName) > -1;
};
ASPx.IsUrlContainsClientScript = function(url) {
 return url.toLowerCase().indexOf("javascript:") !== -1;
};
ASPx.GetMSAjaxRequestManager = function() {
 if(window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager && Sys.WebForms.PageRequestManager.getInstance)
  return Sys.WebForms.PageRequestManager.getInstance();
 return null;
};
Function.prototype.aspxBind = function(scope) {
 var func = this;
 return function() {
  return func.apply(scope, arguments);
 };
};
var FilteringUtils = { };
FilteringUtils.EventKeyCodeChangesTheInput = function(evt) {
 if(ASPx.IsPasteShortcut(evt))
  return true;
 else if(evt.ctrlKey && !evt.altKey)
  return false;
 if(ASPx.Browser.AndroidMobilePlatform || ASPx.Browser.MacOSMobilePlatform) return true; 
 var keyCode = ASPx.Evt.GetKeyCode(evt);
 var isSystemKey = ASPx.Key.Windows <= keyCode && keyCode <= ASPx.Key.ContextMenu;
 var isFKey = ASPx.Key.F1 <= keyCode && keyCode <= 127; 
 return ASPx.Key.Delete <= keyCode && !isSystemKey && !isFKey || keyCode == ASPx.Key.Backspace || keyCode == ASPx.Key.Space;
};
FilteringUtils.FormatCallbackArg = function(prefix, arg) {
 return (ASPx.IsExists(arg) ? prefix + "|" + arg.length + ';' + arg + ';' : "");
};
ASPx.FilteringUtils = FilteringUtils;
var FormatStringHelper = { };
FormatStringHelper.PlaceHolderTemplateStruct = function(startIndex, length, index, placeHolderString){
 this.startIndex = startIndex;
 this.realStartIndex = 0;
 this.length = length;
 this.realLength = 0;
 this.index = index;
 this.placeHolderString = placeHolderString;
};
FormatStringHelper.GetPlaceHolderTemplates = function(formatString){
 formatString = this.CollapseDoubleBrackets(formatString);
 var templates = this.CreatePlaceHolderTemplates(formatString);
 return templates;
};
FormatStringHelper.CreatePlaceHolderTemplates = function(formatString){
 var templates = [];
 var templateStrings = formatString.match(/{[^}]+}/g);
 if(templateStrings != null){
  var pos = 0;
  for(var i = 0; i < templateStrings.length; i++){
   var tempString = templateStrings[i];
   var startIndex = formatString.indexOf(tempString, pos);
   var length = tempString.length;
   var indexString = tempString.slice(1).match(/^[0-9]+/);
   var index = parseInt(indexString);
   templates.push(new this.PlaceHolderTemplateStruct(startIndex, length, index, tempString));
   pos = startIndex + length;
  }
 }
 return templates;
};
FormatStringHelper.CollapseDoubleBrackets = function(formatString){
 formatString = this.CollapseOpenDoubleBrackets(formatString);
 formatString = this.CollapseCloseDoubleBrackets(formatString);
 return formatString;
};
FormatStringHelper.CollapseOpenDoubleBrackets = function(formatString){
 return formatString.replace(/{{/g, "_");
};
FormatStringHelper.CollapseCloseDoubleBrackets = function(formatString){
 while(true){
  var index = formatString.lastIndexOf("}}");
  if(index == -1) 
   break;
  else
   formatString = formatString.substr(0, index) + "_" + formatString.substr(index + 2);
 }
 return formatString;
};
ASPx.FormatStringHelper = FormatStringHelper;
var StartWithFilteringUtils = { };
StartWithFilteringUtils.HighlightSuggestedText = function(input, suggestedText, control, onChangeInput){
 if(this.NeedToLockAndoidKeyEvents(control))
  control.LockAndroidKeyEvents();
 var selInfo = ASPx.Selection.GetInfo(input);
 var currentTextLenght = ASPx.Str.GetCoincideCharCount(suggestedText, input.value, 
  function(text, filter) { 
   return text.indexOf(filter) == 0;
  });
 var suggestedTextLenght = suggestedText.length;
 var isSelected = selInfo.startPos == 0 && selInfo.endPos == currentTextLenght && 
  selInfo.endPos == suggestedTextLenght && input.value == suggestedText;
 if(!isSelected) { 
  input.value = suggestedText;
  if(onChangeInput)
   onChangeInput();
  if(this.NeedToLockAndoidKeyEvents(control)) {
   window.setTimeout(function() {
    this.SelectText(input, currentTextLenght, suggestedTextLenght);
    control.UnlockAndroidKeyEvents();
   }.aspxBind(this), control.adroidSamsungBugTimeout);
  } else
   this.SelectText(input, currentTextLenght, suggestedTextLenght);
 }
};
StartWithFilteringUtils.SelectText = function(input, startPos, stopPos) {
 if(startPos < stopPos)
  ASPx.Selection.Set(input, startPos, stopPos);
};
StartWithFilteringUtils.RollbackOneSuggestedChar = function(input){
 var currentText = input.value;
 var cutText = currentText.slice(0, -1);
 if(cutText != currentText)
  input.value = cutText;
};
StartWithFilteringUtils.NeedToLockAndoidKeyEvents = function(control) {
 return ASPx.Browser.AndroidMobilePlatform && control && control.LockAndroidKeyEvents;
};
ASPx.StartWithFilteringUtils = StartWithFilteringUtils;
var ContainsFilteringUtils = { };
ContainsFilteringUtils.ColumnSelectionStruct = function(index, startIndex, length){
 this.index = index;
 this.length = length;
 this.startIndex = startIndex;
};
ContainsFilteringUtils.IsFilterCrossPlaseHolder = function(filterStartIndex, filterEndIndex, template) {
 var left = Math.max(filterStartIndex, template.realStartIndex);
 var right = Math.min(filterEndIndex,  template.realStartIndex + template.realLength);
 return left < right;
};
ContainsFilteringUtils.GetColumnSelectionsForItem = function(itemValues, formatString, filterString) {
 if(formatString == "") 
  return this.GetSelectionForSingleColumnItem(itemValues, filterString); 
 var result = [];
 var formatedString = ASPx.Formatter.Format(formatString, itemValues);
 var filterStartIndex = ASPx.Str.PrepareStringForFilter(formatedString).indexOf(ASPx.Str.PrepareStringForFilter(filterString));
 if(filterStartIndex == -1) return result;
 var filterEndIndex = filterStartIndex + filterString.length;
 var templates = FormatStringHelper.GetPlaceHolderTemplates(formatString);
 this.SupplyTemplatesWithRealValues(itemValues, templates);
 for(var i = 0; i < templates.length ; i++) {
  if(this.IsFilterCrossPlaseHolder(filterStartIndex, filterEndIndex, templates[i])) 
   result.push(this.GetColumnSelectionsForItemValue(templates[i], filterStartIndex, filterEndIndex));
 }
 return result;
};
ContainsFilteringUtils.GetColumnSelectionsForItemValue = function(template, filterStartIndex, filterEndIndex) {
 var selectedTextStartIndex = filterStartIndex < template.realStartIndex ? 0 :
  filterStartIndex - template.realStartIndex;
 var selectedTextEndIndex = filterEndIndex >  template.realStartIndex + template.realLength ? template.realLength :
  filterEndIndex - template.realStartIndex;
 var selectedTextLength = selectedTextEndIndex - selectedTextStartIndex;
 return new this.ColumnSelectionStruct(template.index, selectedTextStartIndex, selectedTextLength);
};
ContainsFilteringUtils.GetSelectionForSingleColumnItem = function(itemValues, filterString) {
 var selectedTextStartIndex = ASPx.Str.PrepareStringForFilter(itemValues[0]).indexOf(ASPx.Str.PrepareStringForFilter(filterString));
 var selectedTextLength = filterString.length;
 return [new this.ColumnSelectionStruct(0, selectedTextStartIndex, selectedTextLength)];
};
ContainsFilteringUtils.ResetFormatStringIndex = function(formatString, index) {
 if(index != 0)
  return formatString.replace(index.toString(), "0");
 return formatString;
};
ContainsFilteringUtils.SupplyTemplatesWithRealValues = function(itemValues, templates) {
 var shift = 0;
 for(var i = 0; i < templates.length; i++) {
  var formatString = this.ResetFormatStringIndex(templates[i].placeHolderString, templates[i].index);
  var currentItemValue = itemValues[templates[i].index];
  templates[i].realLength = ASPx.Formatter.Format(formatString, currentItemValue).length;
  templates[i].realStartIndex  += templates[i].startIndex + shift; 
  shift += templates[i].realLength - templates[i].placeHolderString.length; 
 }
};
ContainsFilteringUtils.PrepareElementText = function(itemText) {
 return itemText ? itemText.replace(/\&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;") : '';
};
ContainsFilteringUtils.UnselectContainsTextInElement = function(element, selection, highlightTagName) {
 var currentText =  ASPx.Attr.GetAttribute (element, "DXText");
 if(ASPx.IsExists(currentText)) {
  currentText = ContainsFilteringUtils.PrepareElementText(currentText);
  ASPx.Security.setInnerHtml(element, currentText === "" ? "&nbsp;" : currentText, ASPx.Security.DataType.Trusted);
 }
};
ContainsFilteringUtils.ReselectContainsTextInElement = function(element, selection, highlightTagName) {
 var currentText = ASPx.GetInnerText(element);
 if(!highlightTagName)
  highlightTagName = "em";
 highlightTagName = highlightTagName.toLowerCase();
 if(currentText.indexOf("</" + highlightTagName + ">") != -1)
  ContainsFilteringUtils.UnselectContainsTextInElement(element, selection, highlightTagName);
 return ContainsFilteringUtils.SelectContainsTextInElement(element, selection, highlightTagName);
};
ContainsFilteringUtils.SelectContainsTextInElement = function(element, selection, highlightTagName) {
 if(selection.startIndex == -1)
  return;
 var currentText =  ASPx.Attr.GetAttribute (element, "DXText");
 if(!ASPx.IsExists(currentText)) ASPx.Attr.SetAttribute (element, "DXText", ASPx.GetInnerText(element));
 if(!highlightTagName)
  highlightTagName = "em";
 highlightTagName = highlightTagName.toLowerCase();
 var oldInnerText = ASPx.GetInnerText(element);
 var newInnerText = ContainsFilteringUtils.PrepareElementText(oldInnerText.substr(0, selection.startIndex)) + "<" + highlightTagName + ">" +
      ContainsFilteringUtils.PrepareElementText(oldInnerText.substr(selection.startIndex, selection.length)) + "</" + highlightTagName + ">" +
      ContainsFilteringUtils.PrepareElementText(oldInnerText.substr(selection.startIndex + selection.length));
 ASPx.Security.setInnerHtml(element, newInnerText, ASPx.Security.DataType.Trusted);
};
ASPx.ContainsFilteringUtils = ContainsFilteringUtils;
ASPx.MakeEqualControlsWidth = function(name1, name2){
 var control1 = ASPx.GetControlCollection().Get(name1);
 var control2 = ASPx.GetControlCollection().Get(name2);
 if(control1 && control2){
  var width = Math.max(control1.GetWidth(), control2.GetWidth());
  control1.SetWidth(width);
  control2.SetWidth(width);
 }
};
ASPx.HighContrastForeColorHighlightColorMap = {
 "#ffff00" : "#008000",
 "#00ff00" : "#0000ff",
 "#ffffff" : "#00838f",
 "#000000" : "#a347ff"
};
var BadgeManagerBase = ASPx.CreateClass(null, {
 createBadge: function(text, iconCssClass) {
  var badge = document.createElement("SPAN");
  ASPx.SetClassName(badge, this.getBadgeClassName());
  if(iconCssClass && iconCssClass.length)
   this.setBadgeIconCssClass(badge, iconCssClass);
  if(text && text.length)
   this.setBadgeText(badge, text);
  return badge;
 },
 findBadge: function(element) {
  if(!element)
   return null;
  return element.querySelector("." + this.getBadgeClassName());
 },
 setBadgeIconCssClass: function(badge, iconCssClass) {
  if(!badge || iconCssClass === undefined)
   return;
  var iconElement = this.getBadgeIconElement(badge);
  if(!iconCssClass) {
   if(iconElement)
    badge.removeChild(iconElement);
  }
  else {
   if(!iconElement) {
    iconElement = document.createElement("SPAN");
    badge.insertBefore(iconElement, badge.childNodes[0]);
   }
   ASPx.SetClassName(iconElement, iconCssClass + " " + this.getBadgeIconDefaultClassName());
  }
 },
 getBadgeIconCssClass: function(element) {
  var badge = this.findBadge(element);
  if(badge) {
   var iconElement = this.getBadgeIconElement(badge);
   var regEx = new RegExp("(?:^|\\s)" + this.getBadgeIconDefaultClassName() + "(?!\\S)");
   return iconElement ? ASPx.Str.Trim(ASPx.GetClassName(iconElement).replace(regEx, "")) : "";
  }
  return "";
 },
 setBadgeText: function(badge, text) {
  if(!badge || text === undefined)
   return;
  var textElement = this.getBadgeTextElement(badge);
  if(!text) {
   if(textElement)
    badge.removeChild(textElement);
  }
  else {
   if(!textElement) {
    textElement = document.createElement("SPAN");
    badge.appendChild(textElement);
   }
   ASPx.Security.setInnerHtml(textElement, text, ASPx.Security.DataType.Trusted);
  }
 },
 getBadgeText: function(element) {
  var badge = this.findBadge(element);
  if(badge) {
   var textElement = this.getBadgeTextElement(badge);
   return textElement ? ASPx.GetInnerText(textElement) : "";
  }
  return "";
 },
 getBadgeClassName: function() {
  return "";
 },
 getBadgeIconDefaultClassName: function() {
  return "";
 },
 getBadgeIconElement: function(badge) {
  return badge.childNodes.length ? badge.querySelector("." + this.getBadgeIconDefaultClassName()) : null;
 },
 getBadgeTextElement: function(badge) {
  return badge.childNodes.length ? badge.querySelector("span:not(." + this.getBadgeIconDefaultClassName() + ")") : null;
 }
});
ASPx.BadgeManagerBase = BadgeManagerBase;
var BadgeManager = ASPx.CreateClass(BadgeManagerBase, {
 getBadgeClassName: function() {
  return "dxBadge";
 },
 getBadgeIconDefaultClassName: function() {
  return "dxBadgeImage";
 },
 createBadgeForButton: function(button) {
  var badge = ASPx.BadgeManager.createBadge();
  var buttonImage = button.GetButtonImage();
  var textContainer = button.GetTextContainer();
  var badgeRightSibling = !!buttonImage ? buttonImage : textContainer;
  badgeRightSibling.parentNode.insertBefore(badge, badgeRightSibling);
  if(button.IsLink() && buttonImage)
   ASPx.SetStyles(badge, { verticalAlign: "middle" });
  return badge;
 },
 createBadgeForToolbar: function(toolbarItem) {
  var badge = ASPx.BadgeManager.createBadge();
  var itemImage = toolbarItem.GetImage();
  var badgeRightSibling = itemImage;
  if(!itemImage) {
   var itemContentElement = toolbarItem.menu.GetItemContentElement(toolbarItem.indexPath);
   badgeRightSibling = toolbarItem.menu.GetContentTextElement(itemContentElement);
  }
  badgeRightSibling.parentNode.insertBefore(badge, badgeRightSibling);
  return badge;
 }
});
ASPx.BadgeManager = new BadgeManager();
var AccessibilityUtils = {
 isInitialized: false,
 highContrastCssClassMarker: "dxHighContrast",
 highContrastBackgroundCssClassMarker: "dxHCB",
 highContrastDefaultBackgroundColor: "#a347ff",
 highContrastThemeActive: false,
 accessibleBackgroundCssMarker: ".dx-runtime-background",
 createAccessibleBackgrounds: function(control) {
  if(!this.highContrastThemeActive || control.accessibleBackgroundsCreated || !control.accessibilityCompliant)
   return;
  var className = this.accessibleBackgroundCssMarker;
  var styleSheetRuleNames = [];
  iterateStyleSheetRules(null, function(rule) {
   var selectorTxt = rule.selectorText;
   if(selectorTxt && selectorTxt.indexOf(className) > -1)
    styleSheetRuleNames.push(ASPx.Str.CompleteReplace(selectorTxt, className, "")); 
  });
  for(var i = 0; i < styleSheetRuleNames.length; i++) {
   var name = styleSheetRuleNames[i];
   var rule = ASPx.GetStyleSheetRules(name.substring(1));
   if(rule && rule.style && rule.style.backgroundImage)
    this.createAccessibleBackground(control.GetMainElement(), rule.style, name);
  }
  control.accessibleBackgroundsCreated = true;
 },
 createAccessibleBackground: function(container, style, selector) {
  if(!container)
   return;
  var backgroundUrl = style.backgroundImage.substring(5, style.backgroundImage.length - 2);
  var elements = container.querySelectorAll(selector);
  var accessibleBackgroundClassName = "dx-acc-bi";
  for(var i = 0; i < elements.length; i++) {
   var element = elements[i];
   if(ASPx.ElementHasCssClass(element, accessibleBackgroundClassName))
    continue;
   var image = null;
   if(element.tagName !== "IMG") {
    ASPx.AddClassNameToElement(element, accessibleBackgroundClassName);
    image = element.ownerDocument.createElement("IMG");
    ASPx.SetStyles(image, { width: "100%", height: "100%" });
    if(element.firstChild)
     element.insertBefore(image, element.firstChild);
    else
     element.appendChild(image);
   } else
    image = element;
   image.src = backgroundUrl;
  }
 },
 createHighContrastBackgroundStyle: function() {
  var style = document.createElement('style');
  ASPx.Attr.AppendStyleType(style);
  var styleContent = [
   "." + this.highContrastCssClassMarker + " ." + this.highContrastBackgroundCssClassMarker + ":after {",
   "border-image: url(" + this.getHighContrastBackgroundUrl() + ") 0 1 0 0 round;",
   "}",
  ];
  setInnerHtmlInternal(style, styleContent.join('\n'));
  document.getElementsByTagName('head')[0].appendChild(style);
 },
 getHighContrastBackgroundUrl: function() {
  var canvas = document.createElement("canvas"),
  ctx = canvas.getContext('2d');
  canvas.width = 1;
  canvas.height = 1;
  ctx.fillStyle = this.getHighContrastBackgroundColor();
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  return canvas.toDataURL();
 },
 getHighContrastBackgroundColor: function() {
  var foreColor = ASPx.GetCurrentStyle(document.body).color;
  var hexColor = ASPx.Color.ColorToHexadecimal(foreColor);
  return ASPx.HighContrastForeColorHighlightColorMap[hexColor] || this.highContrastDefaultBackgroundColor;
 },
 initialize: function() {
  if(this.isInitialized)
   return;
  this.isInitialized = true;
  this.detectHighContrastTheme();
  if(this.highContrastThemeActive)
   this.createHighContrastBackgroundStyle();
 },
 detectHighContrastTheme: function() {
  var testElement = document.createElement("DIV");
  ASPx.SetStyles(testElement, {
   backgroundColor: "rgb(255, 255, 255)",
   display: "none"
  }, true);
  var docElement = document.documentElement;
  docElement.appendChild(testElement);
  var actualBackgroundColor = ASPx.GetCurrentStyle(testElement).backgroundColor;
  docElement.removeChild(testElement);
  if(actualBackgroundColor === "rgb(0, 0, 0)") {
   this.highContrastThemeActive = true;
   ASPx.AddClassNameToElement(docElement, this.highContrastCssClassMarker);
  }
 }
};
ASPx.AccessibilityUtils = AccessibilityUtils;
ASPx.AccessibilityUtils.SendMessageToAssistiveTechnology = function(message) {
 var messageParts = ASPx.Ident.IsArray(message) ? message : [message];
 var args = new ASPxClientControlBeforePronounceEventArgs(messageParts, null);
 ASPx.AccessibilityPronouncer.EnsureInitialize();
 ASPx.AccessibilityPronouncer.Pronounce(args, ASPx.AccessibilityPronouncerType.live);
};
ASPx.AccessibilityUtils.SetFocusAccessible = function(focusableElement) {
 if(!focusableElement)
  return;
 var elementId = focusableElement.id;
 if(!elementId) {
  var namedParent = ASPx.GetParent(focusableElement, function(element) {
   return !!element.id;
  });
  if(ASPx.IsExists(namedParent))
   elementId = namedParent.id;
 }
 var focusableControl = ASPx.GetClientControlByElementID(elementId);
 if(focusableControl && focusableControl.OnAssociatedLabelClick)
  focusableControl.OnAssociatedLabelClick(focusableElement);
 else
  window.setTimeout(function() {
   ASPx.AccessibilityUtils.SetFocusAccessibleCore(focusableElement);
  }, 0);
};
ASPx.AccessibilityUtils.SetFocusAccessibleCore = function(focusableElement) {
 if(!ASPx.IsExists(focusableElement))
  return;
 var isTabIndexChanged = ASPx.ControlTabIndexManager.getInstance().isElementWithChangedIndex(focusableElement);
 if(isTabIndexChanged)
  return;
 if(!ASPx.IsValidElement(focusableElement) && focusableElement.id)
  focusableElement = ASPx.GetElementById(focusableElement.id);
 if(!ASPx.IsActionElement(focusableElement))
  focusableElement = ASPx.RestoreFocusHelper.findNeighbourFocusElement(focusableElement, document.body);
 if(ASPx.IsExistsElement(focusableElement))
  focusableElement.focus();
};
var Security = {
 setInnerHtml: function(el, html, dataType) {
  if(!html) {
   while(el.firstChild)
    ASPx.RemoveElement(el.firstChild);
  } else
   Security.setData(html, function(d) { ASPx.SetInnerHtml.call(window, el, d); }, dataType);
 },
 setText: function(control, text, dataType) { Security.setData(text, control.SetText.aspxBind(control), dataType); },
 safeEncodeHtml: function(html) { return ASPx.Str.EncodeHtml(ASPx.Str.DecodeHtml(html)); },
 setData: function(data, dataSetter, dataType) {
  if(dataType === undefined)
   throw new Error("Specify the dataType");
  if(dataType == Security.DataType.Untrusted)
   data = Security.safeEncodeHtml(data);
  dataSetter(data);
 }
};
Security.DataType = {
 Trusted: 0,
 Untrusted: 1
};
ASPx.EnableCssAnimation = true;
var AnimationTransitionBase = ASPx.CreateClass(null, {
 constructor: function(element, options) {
  if(element) {
   AnimationTransitionBase.Cancel(element);
   this.element = element;
   this.element.aspxTransition = this;
  }
  this.duration = options.duration || AnimationConstants.Durations.DEFAULT;
  this.transition = options.transition || AnimationConstants.Transitions.SINE;
  this.property = options.property;
  this.unit = options.unit || "";
  this.onComplete = options.onComplete;
  this.to = null;
  this.from = null;
 },
 Start: function(from, to) {
  if(to != undefined) {
   this.to = to;
   this.from = from;
   this.SetValue(this.from);
  }
  else
   this.to = from;
 },
 Cancel: function() {
  if(!this.element)
   return;
  try {
   delete this.element.aspxTransition;
  } catch(e) {
   this.element.aspxTransition = undefined;
  }
 },
 GetValue: function() {
  return this.getValueInternal(this.element, this.property);
 },
 SetValue: function(value) {
  this.setValueInternal(this.element, this.property, this.unit, value);
 },
 setValueInternal: function(element, property, unit, value) {
  if(property == "opacity")
   AnimationUtils.setOpacity(element, value);
  else
   element.style[property] = value + unit;
 },
 getValueInternal: function(element, property) {
  if(property == "opacity")
   return ASPx.GetElementOpacity(element);
  var value = parseFloat(element.style[property]);
  return isNaN(value) ? 0 : value;
 },
 performOnComplete: function() {
  if(this.onComplete)
   this.onComplete(this.element);
 },
 getTransition: function() {
  return this.transition;
 }
});
AnimationTransitionBase.Cancel = function(element) {
 if(element.aspxTransition)
  element.aspxTransition.Cancel();
};
var AnimationConstants = {};
AnimationConstants.Durations = {
 SHORT: 200,
 DEFAULT: 400,
 LONG: 600
};
AnimationConstants.Transitions = {
 LINER: {
  Css: "cubic-bezier(0.250, 0.250, 0.750, 0.750)",
  Js: function(progress) { return progress; }
 },
 SINE: {
  Css: "cubic-bezier(0.470, 0.000, 0.745, 0.715)",
  Js: function(progress) { return Math.sin(progress * 1.57); }
 },
 POW: {
  Css: "cubic-bezier(0.755, 0.050, 0.855, 0.060)",
  Js: function(progress) { return Math.pow(progress, 4); }
 },
 POW_EASE_OUT: {
  Css: "cubic-bezier(0.165, 0.840, 0.440, 1.000)",
  Js: function(progress) { return 1 - AnimationConstants.Transitions.POW.Js(1 - progress); }
 },
 RIPPLE: {
  Css: "cubic-bezier(0.47, 0.06, 0.23, 0.99)",
  Js: function(progress) {
   return Math.pow((progress), 3) * 0.47 + 3 * progress * Math.pow((1 - progress), 2) * 0.06 + 3 * Math.pow(progress, 2) *
    (1 - progress) * 0.23 + 0.99 * Math.pow(progress, 3);
  }
 }
};
var JsAnimationTransition = ASPx.CreateClass(AnimationTransitionBase, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.onStep = options.onStep;
  this.fps = 60;
  this.startTime = null;
 },
 Start: function(from, to) {
  if(from == to) {
   this.from = this.to = from;
   setTimeout(this.complete.aspxBind(this), 0);
  }
  else {
   AnimationTransitionBase.prototype.Start.call(this, from, to);
   if(to == undefined)
    this.from = this.GetValue();
   this.initTimer();
  }
 },
 Cancel: function() {
  AnimationTransitionBase.prototype.Cancel.call(this);
  if(this.timerId)
   clearInterval(this.timerId);
 },
 initTimer: function() {
  this.startTime = new Date();
  this.timerId = window.setInterval(function() { this.onTick(); }.aspxBind(this), 1000 / this.fps);
 },
 onTick: function() {
  var progress = (new Date() - this.startTime) / this.duration;
  if(progress >= 1)
   this.complete();
  else {
   this.update(progress);
   if(this.onStep)
    this.onStep();
  }
 },
 update: function(progress) {
  this.SetValue(this.gatCalculatedValue(this.from, this.to, progress));
 },
 complete: function() {
  this.Cancel();
  this.update(1);
  this.performOnComplete();
 },
 gatCalculatedValue: function(from, to, progress) {
  if(progress == 1)
   return to;
  return from + (to - from) * this.getTransition()(progress);
 },
 getTransition: function() {
  return this.transition.Js;
 }
});
var SimpleAnimationTransition = ASPx.CreateClass(JsAnimationTransition, {
 constructor: function(options) {
  this.constructor.prototype.constructor.call(this, null, options);
  this.transition = options.transition || AnimationConstants.Transitions.POW_EASE_OUT;
  this.onUpdate = options.onUpdate;
  this.lastValue = 0;
 },
 SetValue: function(value) {
  this.onUpdate(value - this.lastValue);
  this.lastValue = value;
 },
 GetValue: function() {
  return this.lastValue;
 },
 performOnComplete: function() {
  if(this.onComplete)
   this.onComplete();
 }
});
var MultipleJsAnimationTransition = ASPx.CreateClass(JsAnimationTransition, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.properties = {};
 },
 Start: function(properties) {
  this.initProperties(properties);
  this.initTimer();
 },
 initProperties: function(properties) {
  this.properties = properties;
  for(var propName in this.properties)
   if(properties[propName].from == undefined)
    properties[propName].from = this.getValueInternal(this.element, propName);
 },
 update: function(progress) {
  for(var propName in this.properties) {
   if(this.properties.hasOwnProperty(propName)) {
    var property = this.properties[propName];
    if(property.from != property.to)
     this.setValueInternal(this.element, propName, property.unit, this.gatCalculatedValue(property.from, property.to, progress));
   }
  }
 }
});
var CssAnimationTransition = ASPx.CreateClass(AnimationTransitionBase, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.transitionPropertyName = AnimationUtils.CurrentTransition.property;
  this.eventName = AnimationUtils.CurrentTransition.event;
 },
 Start: function(from, to) {
  AnimationTransitionBase.prototype.Start.call(this, from, to);
  this.startTimerId = window.setTimeout(function() {
   if(this.from == this.to)
    this.onTransitionEnd();
   else {
    var isHidden = ASPx.GetElementOffsetHeight(this.element) == 0 && ASPx.GetElementOffsetWidth(this.element) == 0; 
    if(!isHidden)
     this.prepareElementBeforeAnimation();
    this.SetValue(this.to);
    if(isHidden)
     this.onTransitionEnd();
   }
  }.aspxBind(this), 0);
 },
 Cancel: function() {
  window.clearTimeout(this.startTimerId);
  AnimationTransitionBase.prototype.Cancel.call(this);
  ASPx.Evt.DetachEventFromElement(this.element, this.eventName, CssAnimationTransition.transitionEnd);
  this.setValueInternal(this.element, this.transitionPropertyName, "", "");
  this.stopAnimation();
 },
 prepareElementBeforeAnimation: function() {
  ASPx.Evt.AttachEventToElement(this.element, this.eventName, CssAnimationTransition.transitionEnd);
  var dummy = this.element.offsetHeight;
  this.element.style[this.transitionPropertyName] = this.getTransitionCssString();
  if(ASPx.Browser.Safari && ASPx.Browser.MacOSMobilePlatform && ASPx.Browser.MajorVersion >= 8) 
   setTimeout(function() {
    if(this.element && this.element.aspxTransition) {
     this.element.style[this.transitionPropertyName] = "";
     this.element.aspxTransition.onTransitionEnd();
    }
   }.aspxBind(this), this.duration + 100);
 },
 stopAnimation: function() {
  this.SetValue(ASPx.GetCurrentStyle(this.element)[this.property]);
 },
 onTransitionEnd: function() {
  this.Cancel();
  this.performOnComplete();
 },
 getTransition: function() {
  return this.transition.Css;
 },
 getTransitionCssString: function() {
  return this.getTransitionCssStringInternal(this.getCssName(this.property));
 },
 getTransitionCssStringInternal: function(cssProperty) {
  return cssProperty + " " + this.duration + "ms " + this.getTransition();
 },
 getCssName: function(property) {
  switch(property) {
   case "marginLeft":
    return "margin-left";
   case "marginTop":
    return "margin-top";
  }
  return property;
 }
});
var MultipleCssAnimationTransition = ASPx.CreateClass(CssAnimationTransition, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.properties = null;
 },
 Start: function(properties) {
  this.properties = properties;
  this.forEachProperties(function(property, propName) {
   if(property.from !== undefined)
    this.setValueInternal(this.element, propName, property.unit, property.from);
  }.aspxBind(this));
  this.prepareElementBeforeAnimation();
  window.setTimeout(function() {
   this.forEachProperties(function(property, propName) {
    this.setValueInternal(this.element, propName, property.unit, property.to);
   }.aspxBind(this));
  }.aspxBind(this), 0);
 },
 stopAnimation: function() {
  var style = ASPx.GetCurrentStyle(this.element);
  this.forEachProperties(function(property, propName) {
   this.setValueInternal(this.element, propName, "", style[propName]);
  }.aspxBind(this));
 },
 getTransitionCssString: function() {
  var str = "";
  this.forEachProperties(function(property, propName) {
   str += this.getTransitionCssStringInternal(this.getCssName(propName)) + ",";
  }.aspxBind(this));
  str = str.substring(0, str.length - 1);
  return str;
 },
 forEachProperties: function(func) {
  for(var propName in this.properties) {
   if(this.properties.hasOwnProperty(propName)) {
    var property = this.properties[propName];
    if(property.from == undefined)
     property.from = this.getValueInternal(this.element, propName);
    if(property.from != property.to)
     func(property, propName);
   }
  }
 }
});
CssAnimationTransition.transitionEnd = function(evt) {
 var element = evt.target;
 if(element && element.aspxTransition)
  element.aspxTransition.onTransitionEnd();
};
var AnimationUtils = {
 CanUseCssTransition: function() { return ASPx.EnableCssAnimation && this.CurrentTransition; },
 CanUseCssTransform: function() { return this.CanUseCssTransition() && this.CurrentTransform; },
 CurrentTransition: (function() {
  if(ASPx.Browser.IE) 
   return null;
  var transitions = [
   { property: "webkitTransition", event: "webkitTransitionEnd" },
   { property: "MozTransition", event: "transitionend" },
   { property: "OTransition", event: "oTransitionEnd" },
   { property: "transition", event: "transitionend" }
  ];
  var fakeElement = document.createElement("DIV");
  for(var i = 0; i < transitions.length; i++)
   if(transitions[i].property in fakeElement.style)
    return transitions[i];
 })(),
 CurrentTransform: (function() {
  var transforms = ["transform", "MozTransform", "-webkit-transform", "msTransform", "OTransform"];
  var fakeElement = document.createElement("DIV");
  for(var i = 0; i < transforms.length; i++)
   if(transforms[i] in fakeElement.style)
    return transforms[i];
 })(),
 SetTransformValue: function(element, position, isTop) {
  if(this.CanUseCssTransform())
   element.style[this.CurrentTransform] = this.GetTransformCssText(position, isTop);
  else
   element.style[!isTop ? "left" : "top"] = position + "px";
 },
 GetTransformValue: function(element, isTop) {
  if(this.CanUseCssTransform()) {
   var cssValue = element.style[this.CurrentTransform];
   return cssValue && cssValue != "none" ? Number(cssValue.replace('matrix(1, 0, 0, 1,', '').replace(')', '').split(',')[!isTop ? 0 : 1]) : 0;
  }
  else
   return !isTop ? element.offsetLeft : element.offsetTop;
 },
 GetTransformCssText: function(position, isTop) {
  if(!position)
   return "none";
  return "matrix(1, 0, 0, 1," + (!isTop ? position : 0) + ", " + (!isTop ? 0 : position) + ")";
 },
 createMultipleAnimationTransition: function (element, options) {
  return this.CanUseCssTransition() && !options.onStep ? new MultipleCssAnimationTransition(element, options) : new MultipleJsAnimationTransition(element, options);
 },
 createSimpleAnimationTransition: function(options) {
  return new SimpleAnimationTransition(options);
 },
 createJsAnimationTransition: function(element, options) {
  return new JsAnimationTransition(element, options);
 },
 createCssAnimationTransition: function(element, options) {
  return new CssAnimationTransition(element, options);
 },
 setOpacity: function(element, value) {
  ASPx.SetElementOpacity(element, value);
 }
};
var AsyncTracker = function() {
 var currentToken,
  lockedTokens,
  onDoneDelegates,
  lockedDelegates;
 function clearState() {
  currentToken = 1;
  lockedTokens = [];
  onDoneDelegates = [];
  lockedDelegates = {};
 }
 clearState();
 var log = function(msg) { };
 function setLog(delegate){
  log = delegate;
 }
 function getLockToken() {
  if(onDoneDelegates.length === 0)
   return -1;
  var token = currentToken++;
  lockedTokens.push(token);
  lockedDelegates[token] = [];
  for (var i = 0; i < onDoneDelegates.length; i++) {
   lockedDelegates[token].push(onDoneDelegates[i]);
  }
  log("module locks token " + token);
  return token;
 }
 function releaseToken(token) {
  if(token < 0) return;
  log("module releasing token " + token);
  ASPx.Data.ArrayRemove(lockedTokens, token);
  delete lockedDelegates[token];
  invokeUnlockedDelegates();
  if(lockedTokens.length === 0)
   clearState();
  log("module released token " + token);
 }
 function invokeUnlockedDelegates() {
  var onDoneDelegate;
  for (var i = onDoneDelegates.length - 1; i >= 0; i--) {
   if(onDoneDelegates[i] && !isDelegateLocked(onDoneDelegates[i])) {
    onDoneDelegate = onDoneDelegates[i];
    delete onDoneDelegates[i];
    onDoneDelegate();
   }
  }
 }
 function isDelegateLocked(delegate) {
  for (var i = lockedTokens.length - 1; i >= 0; i--) {
   var token = lockedTokens[i];
   var delegates = lockedDelegates[token];
   if(delegates) {
    for (var j = delegates.length - 1; j >= 0; j--) {
     if(delegates[j] && delegates[j] === delegate)
      return true;
    }
   }
  }
  return false;
 }
 function track(doDelegate, onDoneDelegate) {
  if(onDoneDelegate)
   onDoneDelegates.push(onDoneDelegate);
  doDelegate();
  if(onDoneDelegate)
   invokeUnlockedDelegates();
 }
 return {
  getLockToken: getLockToken,
  releaseToken: releaseToken,
  track: track,
  setLog:setLog,
 };
};
var GetEditorValuesInContainer = function(containerOrId, processInvisibleEditors, needSerialize) {
 var container = typeof(containerOrId) === "string" ? ASPx.GetElementById(containerOrId) : containerOrId;
 var result = {};
 if(!ASPx.ProcessEditorsInContainer) 
  return result;
 ASPx.ProcessEditorsInContainer(container, function(editor){
  result[editor.name] = GetCorrectedByTypeValue(ASPx.GetEditorValueByControl(editor), needSerialize);
 }, null, null, processInvisibleEditors, false);
 return result;
};
var SetEditorValues = function(values) {
 for(var controlName in values) {
  if(values.hasOwnProperty(controlName)) {
   var trackedControl = ASPxClientControl.GetControlCollection().Get(controlName);
   if(!trackedControl)
    continue;
   var setValueMethod = trackedControl.SetTokenCollection || trackedControl.SelectValues || trackedControl.SetValue;
   if(setValueMethod === trackedControl.SelectValues)
    trackedControl.UnselectAll();
   setValueMethod.call(trackedControl, values[controlName]);
  }
 }
};
var GetCorrectedByTypeValue = function(value, needSerialize){
 if(ASPx.Ident.IsArray(value))
  for(var i = 0; i < value.length; i++)
   value[i] = GetCorrectedByTypeValue(value[i]);
 if(needSerialize && ASPx.Ident.IsDate(value))
  return ASPx.DateUtils.GetInvariantDateTimeString(value);
 return value;
};
var ListBoxTemporaryCache = ASPx.CreateClass(null, {
 constructor: function() { 
  this.cache = { };
  this.invalidateTimerID = -1;
 },
 Get: function(key, getObjectFunc, context, args) {
  if(this.invalidateTimerID < 0) {
   this.invalidateTimerID = window.setTimeout(function() {
    this.Invalidate();
   }.aspxBind(this), 0);
  }
  if(!ASPx.IsExists(this.cache[key])) {
   if(!ASPx.IsExists(args))
    args = [ ];
   this.cache[key] = getObjectFunc.apply(context, args);
  }
  return this.cache[key];
 },
 Invalidate: function() {
  this.cache = { };
  this.invalidateTimerID = ASPx.Timer.ClearTimer(this.invalidateTimerID);
 }
});
ASPx.GetEditorValueByControl = function(control, needSerialize) {
 var result;
 if(ASPx.IsMultipleValueOwner(control))
  result = control.GetSelectedValues();
 if(ASPx.IsTokenBox(control)) {
  if(needSerialize)
   result = control.GetTokenValuesCollection();
  else
   result = control.GetTokenCollection();
 }
 if(ASPx.IsDropDownEdit(control))
  result = control.GetKeyValue();
 return result || control.GetValue();
};
ASPx.IsMultipleValueOwner = function(control) {
 return ASPx.IsListBox(control) || ASPx.IsCheckBoxList(control);
};
ASPx.IsCheckBoxList = function(control) {
 return control && typeof(ASPxClientCheckBoxList) != "undefined" && control instanceof ASPxClientCheckBoxList;
};
ASPx.IsListBox = function(control) {
 return control && typeof(ASPxClientListBox) != "undefined" && control instanceof ASPxClientListBox;
};
ASPx.IsComboBox = function(control) {
 return control && typeof(ASPxClientComboBox) != "undefined" && control instanceof ASPxClientComboBox;
};
ASPx.IsTokenBox = function(control) {
 return control && typeof(ASPxClientTokenBox) != "undefined" && control instanceof ASPxClientTokenBox;
};
ASPx.IsDropDownEdit = function(control) {
 return control && typeof (ASPxClientDropDownEdit) != "undefined" && control instanceof ASPxClientDropDownEdit;
};
ASPx.IsGridLookup = function(control) {
 return control && typeof(MVCxClientGridLookup) != "undefined" && control instanceof MVCxClientGridLookup;
};
ASPx.IsSpinEdit = function(control) {
 return control && typeof(ASPxClientSpinEdit) != "undefined" && control instanceof ASPxClientSpinEdit;
};
ASPx.DatePickerType = {
 Days: 0,
 Months: 1,
 Years: 2,
 Decades: 3
};
ASPx.FullScreenUtils = {
 subscribeChange: function(handler) {
  Evt.AttachEventToElement(document, "fullscreenchange", handler);
  Evt.AttachEventToElement(document, "msfullscreenchange", handler); 
  Evt.AttachEventToElement(document, "MSFullscreenChange", handler); 
  Evt.AttachEventToElement(document, "webkitfullscreenchange", handler);
  Evt.AttachEventToElement(document, "mozfullscreenchange", handler);
 },
 unsubscribeChange: function(handler) {
  Evt.DetachEventFromElement(document, "fullscreenchange", handler);
  Evt.DetachEventFromElement(document, "msfullscreenchange", handler);
  Evt.DetachEventFromElement(document, "MSFullscreenChange", handler);
  Evt.DetachEventFromElement(document, "webkitfullscreenchange", handler);
  Evt.DetachEventFromElement(document, "mozfullscreenchange", handler);
 },
 setFullscreen: function(on) {
  var element = window.self.document.body;
  if(on) {
   if(element.requestFullscreen) {
    element.requestFullscreen();
   } else if(element.mozRequestFullScreen) {
    element.mozRequestFullScreen();
   } else if(element.webkitRequestFullscreen) {
    element.webkitRequestFullscreen();
   } else if(element.msRequestFullscreen) {
    element.msRequestFullscreen();
   }
  } else {
   if(document.exitFullscreen) {
    document.exitFullscreen();
   } else if(document.mozCancelFullScreen) {
    document.mozCancelFullScreen();
   } else if(document.webkitCancelFullScreen) {
    document.webkitCancelFullScreen();
   } else if(document.msExitFullscreen) {
    document.msExitFullscreen();
   }
  }
 },
 inFullscreen: function() {
  var fullscreenElement = document.fullscreenElement || document.msFullscreenElement || document.webkitFullscreenElement;
  var isInFullscreen = fullscreenElement === document.body || document.webkitIsFullScreen;
  return !!isInFullscreen;
 }
 };
ASPx.InitializeSVGSprite = function () {
 if (ASPx.SVGSprites && ASPx.SVGSprites.length > 0) {
  var svgContainer = document.getElementById('svgContainer');
  var hasSvgContainer = !!svgContainer;
  if (!hasSvgContainer) {
   svgContainer = document.createElement('div');
   svgContainer.id = 'svgContainer';
   svgContainer.style.display = "none";
   document.body.appendChild(svgContainer);
  }
  for (var i = 0; i < ASPx.SVGSprites.length; i++) {
   svgContainer.innerHTML += ASPx.SVGSprites[i];
  }
  ASPx.SVGSprites = null;
 }
};
var GridDynamicStyleSheetHelper = ASPx.CreateClass(null, {
 constructor: function() {
  this.styleSheet = {};
  this.rules = {};
  this.updateLock = 0;
 },
 Update: function(control, styleName, rules) {
  var key = control.name + "_" + styleName;
  this.BeginUpdate(key);
  this.ChangeRules(key, rules);
  this.EndUpdate(key);
 },
 ChangeRules: function(key, rules) {
  if(key && rules)
   this.rules[key] = rules;
 },
 BeginUpdate: function(key) {
  this.updateLock++;
  this.RemoveStyleSheetElement(key);
 },
 EndUpdate: function(key) {
  this.updateLock--;
  if(this.updateLock !== 0)
   return;
  var styleArgs = [];
  var controlRules = this.rules[key];
  for(var i = 0; i < controlRules.length; i++) {
   var rule = controlRules[i];
   styleArgs.push(rule.selector + " { " + rule.cssText + " } ");
  }
  this.styleSheet[key] = this.CreateStyleSheet(key, styleArgs.join(""));
 },
 CreateStyleSheet: function(key, cssText) {
  var container = document.createElement("DIV");
  ASPx.Security.setInnerHtml(container, "<style type='text/css' id='" + key + "'>" + cssText + "</style>", ASPx.Security.DataType.Trusted);
  styleSheet = ASPx.GetNodeByTagName(container, "style", 0);
  if(styleSheet)
   ASPx.GetNodeByTagName(document, "HEAD", 0).appendChild(styleSheet);
  return styleSheet;
 },
 ClearStyleSheet: function(control, styleName) {
  var key = control.name + "_" + styleName;
  this.RemoveStyleSheetElement(key);
 },
 RemoveStyleSheetElement: function(key) {
  if(this.styleSheet[key]) {
   ASPx.RemoveElement(this.styleSheet[key]);
   delete this.styleSheet[key];
  }
 }
});
GridDynamicStyleSheetHelper.Instance = new GridDynamicStyleSheetHelper();
ASPx.GridDynamicStyleSheetHelper = GridDynamicStyleSheetHelper;
ASPxClientUtils = {};
ASPxClientUtils.agent = Browser.UserAgent;
ASPxClientUtils.opera = Browser.Opera;
ASPxClientUtils.opera9 = Browser.Opera && Browser.MajorVersion == 9;
ASPxClientUtils.safari = Browser.Safari;
ASPxClientUtils.safari3 = Browser.Safari && Browser.MajorVersion == 3;
ASPxClientUtils.safariMacOS = Browser.Safari && Browser.MacOSPlatform;
ASPxClientUtils.chrome = Browser.Chrome;
ASPxClientUtils.ie = Browser.IE;
ASPxClientUtils.ie7 = Browser.IE && Browser.MajorVersion == 7;
ASPxClientUtils.firefox = Browser.Firefox;
ASPxClientUtils.firefox3 = Browser.Firefox && Browser.MajorVersion == 3;
ASPxClientUtils.mozilla = Browser.Mozilla;
ASPxClientUtils.netscape = Browser.Netscape;
ASPxClientUtils.browserVersion = Browser.Version;
ASPxClientUtils.browserMajorVersion = Browser.MajorVersion;
ASPxClientUtils.macOSPlatform = Browser.MacOSPlatform;
ASPxClientUtils.windowsPlatform = Browser.WindowsPlatform;
ASPxClientUtils.webKitFamily = Browser.WebKitFamily;
ASPxClientUtils.netscapeFamily = Browser.NetscapeFamily;
ASPxClientUtils.touchUI = Browser.TouchUI;
ASPxClientUtils.webKitTouchUI = Browser.WebKitTouchUI;
ASPxClientUtils.msTouchUI = Browser.MSTouchUI;
ASPxClientUtils.iOSPlatform = Browser.MacOSMobilePlatform;
ASPxClientUtils.androidPlatform = Browser.AndroidMobilePlatform;
ASPxClientUtils.ArrayInsert = Data.ArrayInsert;
ASPxClientUtils.ArrayRemove = Data.ArrayRemove;
ASPxClientUtils.ArrayRemoveAt = Data.ArrayRemoveAt;
ASPxClientUtils.ArrayClear = Data.ArrayClear;
ASPxClientUtils.ArrayIndexOf = Data.ArrayIndexOf;
ASPxClientUtils.AttachEventToElement = Evt.AttachEventToElement;
ASPxClientUtils.DetachEventFromElement = Evt.DetachEventFromElement;
ASPxClientUtils.GetEventSource = Evt.GetEventSource;
ASPxClientUtils.GetEventX = Evt.GetEventX;
ASPxClientUtils.GetEventY = Evt.GetEventY;
ASPxClientUtils.GetKeyCode = Evt.GetKeyCode;
ASPxClientUtils.PreventEvent = Evt.PreventEvent;
ASPxClientUtils.PreventEventAndBubble = Evt.PreventEventAndBubble;
ASPxClientUtils.PreventDragStart = Evt.PreventDragStart;
ASPxClientUtils.ClearSelection = Selection.Clear;
ASPxClientUtils.IsExists = ASPx.IsExists;
ASPxClientUtils.IsFunction = ASPx.IsFunction;
ASPxClientUtils.GetAbsoluteX = ASPx.GetAbsoluteX;
ASPxClientUtils.GetAbsoluteY = ASPx.GetAbsoluteY;
ASPxClientUtils.SetAbsoluteX = ASPx.SetAbsoluteX;
ASPxClientUtils.SetAbsoluteY = ASPx.SetAbsoluteY;
ASPxClientUtils.GetDocumentScrollTop = ASPx.GetDocumentScrollTop;
ASPxClientUtils.GetDocumentScrollLeft = ASPx.GetDocumentScrollLeft;
ASPxClientUtils.GetDocumentClientWidth = ASPx.GetDocumentClientWidth;
ASPxClientUtils.GetDocumentClientHeight = ASPx.GetDocumentClientHeight;
ASPxClientUtils.AddClassNameToElement = ASPx.AddClassNameToElement;
ASPxClientUtils.RemoveClassNameFromElement = ASPx.RemoveClassNameFromElement;
ASPxClientUtils.ToggleClassName = ASPx.ToggleClassNameToElement;
ASPxClientUtils.GetIsParent = ASPx.GetIsParent;
ASPxClientUtils.GetParentById = ASPx.GetParentById;
ASPxClientUtils.GetParentByTagName = ASPx.GetParentByTagName;
ASPxClientUtils.GetParentByClassName = ASPx.GetParentByPartialClassName;
ASPxClientUtils.GetChildById = ASPx.GetChildById;
ASPxClientUtils.GetChildByTagName = ASPx.GetChildByTagName;
ASPxClientUtils.SetCookie = Cookie.SetCookie;
ASPxClientUtils.GetCookie = Cookie.GetCookie;
ASPxClientUtils.DeleteCookie = Cookie.DelCookie;
ASPxClientUtils.GetShortcutCode = ASPx.GetShortcutCode; 
ASPxClientUtils.GetShortcutCodeByEvent = ASPx.GetShortcutCodeByEvent;
ASPxClientUtils.StringToShortcutCode = ASPx.ParseShortcutString;
ASPxClientUtils.Trim = Str.Trim; 
ASPxClientUtils.TrimStart = Str.TrimStart;
ASPxClientUtils.TrimEnd = Str.TrimEnd;
ASPxClientUtils.GetEditorValuesInContainer = GetEditorValuesInContainer;
ASPxClientUtils.SetEditorValues = SetEditorValues;
ASPxClientUtils.SendMessageToAssistiveTechnology = ASPx.AccessibilityUtils.SendMessageToAssistiveTechnology;
window.ASPxClientUtils = ASPxClientUtils;
window.ListBoxTemporaryCache = ListBoxTemporaryCache;
ASPx.AnimationUtils = AnimationUtils;
ASPx.AnimationTransitionBase = AnimationTransitionBase;
ASPx.AnimationConstants = AnimationConstants;
ASPx.AsyncTracker = AsyncTracker;
ASPx.Security = Security;
})(ASPx, dx);

(function () {
 function IntersectionObserversManager() {
  this.rootElementToObserverMap = new Map();
  this.elementToHandlerMap = new Map();
  this.clearInvalidElementsInterval = null;
  this.clearInvalidElementsPeriod = 5000;
  this.AddTargetElement = function (element, rootElement, visibilityChangedHandler) {
   this.addTargetElementCore(element, rootElement, visibilityChangedHandler);
  };
  this.SubscribeElemensVisibilityChangeInBrowserWindow = function (element, visibilityChangedHandler) {
   this.addTargetElementCore(element, null, visibilityChangedHandler);
  };
  this.initializeObserver = function (rootElement) {
   if(!this.rootElementToObserverMap.get(rootElement)) {
    var options = {
     root: rootElement,
     rootMargin: '-1px',
     threshold: 0.0 
    };
    var observer = new IntersectionObserver(this.visibilityChanged.bind(this), options);
    this.rootElementToObserverMap.set(rootElement, observer);
   }
  };
  this.addTargetElementCore = function (element, rootElement, visibilityChangedHandler) {
   this.initializeObserver(rootElement);
   if(!this.isAlreadyObserved(element)) {
    var observer = this.rootElementToObserverMap.get(rootElement);
    if(observer) {
     observer.observe(element);
     this.setObservedMarker(element);
     this.setElementVisibilityChangedHandler(element, visibilityChangedHandler, observer);
     if(this.clearInvalidElementsInterval === null) {
      this.clearInvalidElementsInterval = setInterval(this.removeDeletedElements.bind(this), this.clearInvalidElementsPeriod);
     }
    }
   }
  };
  this.visibilityChanged = function (entries, observer) {
   entries.forEach(function (entry) {
    if(ASPx.IsExistsElement(entry.target)){
     var handler = this.elementToHandlerMap.get(observer).get(entry.target);
     if(handler) {
      handler(entry.isIntersecting);
     }
    }
   }.bind(this));
  };
  this.removeDeletedElements = function () {
   this.elementToHandlerMap.forEach(function(elements, observer) {
    elements.forEach(function(handler, element) {
     if(!ASPx.IsExistsElement(element)) {
      elements.delete(element);
     }
    }.bind(this));
    if(elements.size === 0) {
     this.elementToHandlerMap.delete(observer);
    }
   }.bind(this));
   if(this.elementToHandlerMap.size === 0) {
    clearInterval(this.clearInvalidElementsInterval);
    this.clearInvalidElementsInterval = null;
   }
  };
  this.setElementVisibilityChangedHandler = function (element, visibilityChangedHandler, observer) {
   if(!this.elementToHandlerMap.get(observer)) {
    this.elementToHandlerMap.set(observer, new Map());
   }
   this.elementToHandlerMap.get(observer).set(element, visibilityChangedHandler);
  };
  this.isAlreadyObserved = function (element) {
   return !!element.dataset.observed;
  };
  this.setObservedMarker = function (element) {
   element.dataset.observed = true;
  };
  this.reset = function () {
   this.rootElementToObserverMap.forEach(function(observer, rootElement) {
    observer.disconnect();
   }.bind(this));
   this.rootElementToObserverMap = new Map();
   this.elementToHandlerMap = new Map();
   this.clearInvalidElementsInterval = null;
   this.clearInvalidElementsPeriod = 5000;
  };
 }
 function IntersectionObserversManagerForOldBrowsers() {
  this.SubscribeElemensVisibilityChangeInBrowserWindow = function (element, visibilityChangedHandler) {
  };
 }
 ASPx.IntersectionObserversManager = ASPx.IntersectionObserversManager || ((typeof(IntersectionObserver) !== "undefined") ? new IntersectionObserversManager() : new IntersectionObserversManagerForOldBrowsers());
}
)(ASPx);
(function module(ASPx, options) {
ASPx.modules.Classes = module;
ASPx.classesScriptParsed = false;
ASPx.documentLoaded = false; 
ASPx.CallbackType = {
 Data: "d",
 Common: "c"
};
ASPx.callbackState = {
 aborted: "aborted",
 inTurn: "inTurn",
 sent: "sent"
};
var ASPxClientEvent = ASPx.CreateClass(null, {
 constructor: function() {
  this.handlerInfoList = [];
  this.firingIndex = -1;
 },
 AddHandler: function(handler, executionContext) {
  if(typeof(executionContext) == "undefined")
   executionContext = null;
  this.RemoveHandler(handler, executionContext);
  var handlerInfo = ASPxClientEvent.CreateHandlerInfo(handler, executionContext);
  this.handlerInfoList.push(handlerInfo);
 },
 RemoveHandler: function(handler, executionContext) {
  this.removeHandlerByCondition(function(handlerInfo) {
   return handlerInfo.handler == handler && 
    (!executionContext || handlerInfo.executionContext == executionContext);
  });
 },
 removeHandlerByCondition: function(predicate) {
   for(var i = this.handlerInfoList.length - 1; i >= 0; i--) {
   var handlerInfo = this.handlerInfoList[i];
   if(predicate(handlerInfo)) {
    ASPx.Data.ArrayRemoveAt(this.handlerInfoList, i);
    if(i <= this.firingIndex)
     this.firingIndex--;
   }
  }
 },
 removeHandlerByControlName: function(controlName) {
  this.removeHandlerByCondition(function(handlerInfo) {
   return handlerInfo.executionContext &&  
    handlerInfo.executionContext.name === controlName;
  });
 },
 ClearHandlers: function() {
  this.handlerInfoList.length = 0;
 },
 FireEvent: function(obj, args) {
  for(this.firingIndex = 0; this.firingIndex < this.handlerInfoList.length; this.firingIndex++) {
   var handlerInfo = this.handlerInfoList[this.firingIndex];
   handlerInfo.handler.call(handlerInfo.executionContext, obj, args);
  }
 },
 InsertFirstHandler: function(handler, executionContext){
  if(typeof(executionContext) == "undefined")
   executionContext = null;
  var handlerInfo = ASPxClientEvent.CreateHandlerInfo(handler, executionContext);
  ASPx.Data.ArrayInsert(this.handlerInfoList, handlerInfo, 0);
 },
 IsEmpty: function() {
  return this.handlerInfoList.length == 0;
 }
});
ASPxClientEvent.CreateHandlerInfo = function(handler, executionContext) {
 return {
  handler: handler,
  executionContext: executionContext
 };
};
var ASPxClientEventArgs = ASPx.CreateClass(null, {
 constructor: function() {
 }
});
ASPxClientEventArgs.Empty = new ASPxClientEventArgs();
var ASPxClientCancelEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
  this.cancel = false;
 }
});
var ASPxClientProcessingModeEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(processOnServer){
  this.constructor.prototype.constructor.call(this);
  this.processOnServer = !!processOnServer;
 }
});
var ASPxClientProcessingModeCancelEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.cancel = false;
 }
});
var OrderedMap = ASPx.CreateClass(null, {
 constructor: function(){
  this.entries = {};
  this.firstEntry = null;
  this.lastEntry = null;
 },
 add: function(key, element) {
  var entry = this.addEntry(key, element);
  this.entries[key] = entry;
 },
 remove: function(key) {
  var entry = this.entries[key];
  if(entry === undefined)
   return;
  this.removeEntry(entry);
  delete this.entries[key];
 },
 clear: function() {
  this.markAllEntriesAsRemoved();
  this.entries = {};
  this.firstEntry = null;
  this.lastEntry = null;
 },
 get: function(key) {
  var entry = this.entries[key];
  return entry ? entry.value : undefined;
 },
 forEachEntry: function(processFunc, context) {
  context = context || this;
  for(var entry = this.firstEntry; entry; entry = entry.next) {
   if(entry.removed)
    continue;
   if(processFunc.call(context, entry.key, entry.value))
    return;
  }
 },
 addEntry: function(key, element) {
  var entry = { key: key, value: element, next: null, prev: null };
  if(!this.firstEntry)
   this.firstEntry = entry;
  else {
   entry.prev = this.lastEntry;
   this.lastEntry.next = entry;
  }
  this.lastEntry = entry;
  return entry;
 },
 removeEntry: function(entry) {
  if(this.firstEntry == entry)
   this.firstEntry = entry.next;
  if(this.lastEntry == entry)
   this.lastEntry = entry.prev;
  if(entry.prev)
   entry.prev.next = entry.next;
  if(entry.next)
   entry.next.prev = entry.prev;
  entry.removed = true;
 },
 markAllEntriesAsRemoved: function() {
  for(var entry = this.firstEntry; entry; entry = entry.next)
   entry.removed = true;
 }
});
var CollectionBase = ASPx.CreateClass(null, {
 constructor: function(){
  this.elementsMap = new OrderedMap();
  this.isASPxClientCollection = true;
 },
 Add: function(key, element) {
  this.elementsMap.add(key, element);
 },
 Remove: function(key) {
  this.elementsMap.remove(key);
 },
 Clear: function(){
  this.elementsMap.clear();
 },
 Get: function(key){
  return this.elementsMap.get(key);
 }
});
(function garbageCollector(ASPx, options) {
 ASPx.modules.garbageCollector = garbageCollector;
 var interval = options.GCCheckInterval;
 window.setInterval(collectObjects, interval);
 function canCollectObjects() {
  if (!ASPx.GetControlCollection) return false;
  var collection = ASPx.GetControlCollection();
  return collection && !collection.InCallback();
 }
 function collectObjects() {
  if (!canCollectObjects()) return;
  ASPx.GetControlCollectionCollection().RemoveDisposedControls();
  if(typeof(ASPx.GetStateController) != "undefined")
   ASPx.GetStateController().RemoveDisposedItems();
  if(ASPx.TableScrollHelperCollection)
   ASPx.TableScrollHelperCollection.RemoveDisposedObjects();
  if(ASPx.Ident.scripts.ASPxClientRatingControl)
   ASPxClientRatingControl.RemoveDisposedElementUnderCursor();
  var postHandler = ASPx.GetPostHandler();
  if(postHandler)
   postHandler.RemoveDisposedFormsFromCache();
 }
})(ASPx, options);
var ControlTree = ASPx.CreateClass(null, {
 constructor: function(controlCollection, container, controlFilter) {
  this.container = container;
  this.domMap = { };
  this.rootNode = this.createNode(null, null);
  this.createControlTree(controlCollection, container, controlFilter);
 },
 createControlTree: function(controlCollection, container, controlFilter) {
  controlCollection.ProcessControlsInContainer(container, function(control) {
   control.RegisterInControlTree(this);
  }.aspxBind(this), controlFilter);
  var fixedNodes = [];
  var fixedNodesChildren = [];
  for(var domElementID in this.domMap) {
   if(!this.domMap.hasOwnProperty(domElementID)) continue;
   var node = this.domMap[domElementID];
   var controlOwner = node.control ? node.control.controlOwner : null;
   if(controlOwner && this.domMap[controlOwner.name])
    continue;
   if(this.isFixedNode(node))
    fixedNodes.push(node);
   else {
    var parentNode = this.findParentNode(domElementID);
    parentNode = parentNode || this.rootNode;
    if(this.isFixedNode(parentNode))
     fixedNodesChildren.push(node);
    else {
     var childNode = node.mainNode || node;
     this.addChildNode(parentNode, childNode);
    }
   }
  }
  for(var i = fixedNodes.length - 1; i >= 0; i--)
   this.insertChildNode(this.rootNode, fixedNodes[i], 0);
  for(var i = fixedNodesChildren.length - 1; i >= 0; i--)
   this.insertChildNode(this.rootNode, fixedNodesChildren[i], 0);
 },
 findParentNode: function(id) {
  var element = document.getElementById(id).parentNode;
  while(element && element.tagName !== "BODY") {
   if(element.id) {
    var parentNode = this.domMap[element.id];
    if(parentNode)
     return parentNode;
   }
   element = element.parentNode;
  }
  return null;
 },
 addChildNode: function(node, childNode) {
  if(!childNode.parentNode) {
   node.children.push(childNode);
   childNode.parentNode = node;
  }
 },
 insertChildNode: function(node, childNode, index) {
  if(!childNode.parentNode) {
   ASPx.Data.ArrayInsert(node.children, childNode, index);
   childNode.parentNode = node;
  }
 },
 addRelatedNode: function(node, relatedNode) {
  this.addChildNode(node, relatedNode);
  relatedNode.mainNode = node;
 },
 isFixedNode: function(node) {
  var control = node.mainNode ? node.mainNode.control : node.control;
  return control && control.HasFixedPosition();
 },
 createNode: function(domElementID, control) {
  var node = {
   control: control,
   children: [],
   parentNode: null,
   mainNode: null
  };
  if(domElementID)
   this.domMap[domElementID] = node;
  return node;
 }
});
var ControlAdjuster = ASPx.CreateClass(null, {
 constructor: function() {
 },
 adjustControlsInHierarchy: function(controlCollection, adjustFunc, container, collapseControls, controlFilter) {
  var controlTree = new ASPx.ControlTree(controlCollection, container, controlFilter);
  this.adjustControlsInTree(controlTree.rootNode, adjustFunc, container, collapseControls);
 },
 adjustControlsInTree: function(treeNode, adjustFunc, container, collapseControls) {
  var observer = _aspxGetDomObserver();
  observer.pause(container, true);
  var documentScrollInfo;
  if(collapseControls) {
   documentScrollInfo = ASPx.GetOuterScrollPosition(document.body);
   this.collapseControls(treeNode);
  }
  var adjustNodes = [], 
   autoHeightNodes = [];
  var requireReAdjust = this.forEachControlCore(treeNode, collapseControls, adjustFunc, adjustNodes, autoHeightNodes);
  if(requireReAdjust)
   this.forEachControlsBackward(adjustNodes, collapseControls, adjustFunc);
  else {
   for(var i = 0, node; node = autoHeightNodes[i]; i++)
    node.control.AdjustAutoHeight();
  }
  if(collapseControls)
   ASPx.RestoreOuterScrollPosition(documentScrollInfo);
  observer.resume(container, true);
 },
 forEachControlCore: function(node, collapseControls, processFunc, adjustNodes, autoHeightNodes) {
  var requireReAdjust = false,
   size, newSize;
  if(node.control) {
   var checkReadjustment = collapseControls && node.control.IsControlCollapsed() && node.control.CanCauseReadjustment();
   if(checkReadjustment)
    size = node.control.GetControlPercentMarkerSize(false, true);
   if(node.control.IsControlCollapsed() && !node.control.IsExpandableByAdjustment())
    node.control.ExpandControl();
   node.control.isInsideHierarchyAdjustment = true;
   processFunc(node.control);
   node.control.isInsideHierarchyAdjustment = false;
   if(checkReadjustment) {
    newSize = node.control.GetControlPercentMarkerSize(false, true);
    requireReAdjust = size.width !== newSize.width;
   }
   if(node.control.sizingConfig.supportAutoHeight)
    autoHeightNodes.push(node);
   node.control.ResetControlPercentMarkerSize();
  }
  for(var childNode, i = 0; childNode = node.children[i]; i++)
   requireReAdjust = this.forEachControlCore(childNode, collapseControls, processFunc, adjustNodes, autoHeightNodes) || requireReAdjust;
  adjustNodes.push(node);
  return requireReAdjust;
 },
 forEachControlsBackward: function(adjustNodes, collapseControls, processFunc) {
  for(var i = 0, node; node = adjustNodes[i]; i++)
   this.forEachControlsBackwardCore(node, collapseControls, processFunc);
 },
 forEachControlsBackwardCore: function(node, collapseControls, processFunc) {
  if(node.control)
   processFunc(node.control);
  if(node.children.length > 1) {
   for(var i = 0, childNode; childNode = node.children[i]; i++) {
    if(childNode.control)
     processFunc(childNode.control);
   }
  }
 },
 collapseControls: function(node) {
  for(var childNode, i = 0; childNode = node.children[i]; i++)
   this.collapseControls(childNode);
  if(node.control && node.control.NeedCollapseControl())
   node.control.CollapseControl();
 }
});
var controlAdjuster = null;
function GetControlAdjuster() {
 if(!controlAdjuster)
  controlAdjuster = new ControlAdjuster();
 return controlAdjuster;
}
function _aspxFunctionIsInCallstack(currentCallee, targetFunction, depthLimit) {
 var candidate = currentCallee;
 var depth = 0;
 while(candidate && depth <= depthLimit) {
  candidate = candidate.caller;
  if(candidate == targetFunction)
   return true;
  depth++;
 }
 return false;
}
ASPx.attachToReady(aspxClassesWindowOnLoad);
function aspxClassesWindowOnLoad(){
 ASPx.documentLoaded = true;
 _aspxMoveLinkElements();
 _aspxSweepDuplicatedLinks();
 ResourceManager.SynchronizeResources();
 var externalScriptProcessor = GetExternalScriptProcessor();
 if(externalScriptProcessor)
  externalScriptProcessor.ShowErrorMessages();
 ASPx.AccessibilityUtils.initialize();
 ASPx.GetControlCollection().Initialize();
 _aspxInitializeScripts();
 _aspxInitializeLinks();
 _aspxInitializeFocus();
 ASPx.GetControlCollection().FinalizeInitialization();
}
Ident = { };
Ident.IsDate = function(obj) {
 return obj && obj.constructor == Date;
};
Ident.IsRegExp = function(obj) {
 return obj && obj.constructor === RegExp;
};
Ident.IsArray = function(obj) {
 return obj && obj.constructor == Array;
};
Ident.IsASPxClientCollection = function(obj) {
 return obj && obj.isASPxClientCollection;
};
Ident.IsASPxClientControl = function(obj) {
 return obj && obj instanceof ASPxClientControlBase;
};
Ident.IsASPxClientEdit = function(obj) {
 return obj && obj.isASPxClientEdit;
};
Ident.IsFocusableElementRegardlessTabIndex = function (element) {
 var tagName = element.tagName;
 return tagName == "TEXTAREA" || tagName == "INPUT" || tagName == "A" ||
  tagName == "SELECT" || tagName == "IFRAME" || tagName == "OBJECT" || tagName == "BUTTON";
};
Ident.isDialogInvisibleControl = function(control) {
 return !!ASPx.Dialog && ASPx.Dialog.isDialogInvisibleControl(control);
};
Ident.isBatchEditUnusedEditor = function(control) {
 return !!ASPx.BatchEditHelper && ASPx.BatchEditHelper.isBatchEditUnusedEditor(control);
};
Ident.scripts = {};
if(ASPx.IsFunction(window.WebForm_InitCallbackAddField)) {
 (function() {
  var original = window.WebForm_InitCallbackAddField;
  window.WebForm_InitCallbackAddField = function(name, value) {
   if(typeof(name) == "string" && name)
    original.apply(null, arguments);
  };
 })();
}
ASPx.FireDefaultButton = function(evt, buttonID) {
 if(_aspxIsDefaultButtonEvent(evt, buttonID)) {
  var defaultButton = ASPx.GetElementById(buttonID);
  if(defaultButton && defaultButton.click) {
   if(ASPx.IsFocusable(defaultButton))
    defaultButton.focus();
   ASPx.Evt.DoElementClick(defaultButton);
   ASPx.Evt.PreventEventAndBubble(evt);
   return false;
  }
 }
 return true;
};
function _aspxIsDefaultButtonEvent(evt, defaultButtonID) {
 if(evt.keyCode != ASPx.Key.Enter)
  return false;
 var srcElement = ASPx.Evt.GetEventSource(evt);
 if(!srcElement || srcElement.id === defaultButtonID)
  return true;
 var tagName = srcElement.tagName;
 var type = srcElement.type;
 return tagName != "TEXTAREA" && tagName != "BUTTON" && tagName != "A" &&
  (tagName != "INPUT" || type != "checkbox" && type != "radio" && type != "button" && type != "submit" && type != "reset");
}
var PostHandler = ASPx.CreateClass(null, {
 constructor: function() {
  this.Post = new ASPxClientEvent();
  this.PostFinalization = new ASPxClientEvent();
  this.observableForms = [];
  this.dxCallbackTriggers = {};
  this.lastSubmitElementName = null;
  this.beforeOnSubmit = function() { };
  this.ReplaceGlobalPostFunctions();
  this.HandleDxCallbackBeginning();
  this.HandleMSAjaxRequestBeginning();
 },
 Update: function() {
  this.ReplaceFormsSubmit(true);
 },
 ProcessPostRequest: function(ownerID, isCallback, isMSAjaxRequest, isDXCallback) {
  this.cancelPostProcessing = false;
  this.isMSAjaxRequest = isMSAjaxRequest;
  if(this.SkipRaiseOnPost(ownerID, isCallback, isDXCallback))
   return;
  var args = new PostHandlerOnPostEventArgs(ownerID, isCallback, isMSAjaxRequest, isDXCallback);
  this.Post.FireEvent(this, args);
  this.cancelPostProcessing = args.cancel;
  if(!args.cancel)
   this.PostFinalization.FireEvent(this, args);
 },
 SkipRaiseOnPost: function(ownerID, isCallback, isDXCallback) { 
  if(!isCallback)
   return false;
  var dxOwner = isDXCallback && ASPx.GetControlCollection().GetByName(ownerID);
  if(dxOwner) {
   this.dxCallbackTriggers[dxOwner.uniqueID] = true;
   return false;
  }
  if(this.dxCallbackTriggers[ownerID]) {
   this.dxCallbackTriggers[ownerID] = false;
   return true;
  }
  return false;
 },
 ReplaceGlobalPostFunctions: function() {
  if(ASPx.IsFunction(window.__doPostBack))
   this.ReplaceDoPostBack();
  if(ASPx.IsFunction(window.WebForm_DoCallback))
   this.ReplaceDoCallback();
  if(ASPx.IsFunction(window.WebForm_ExecuteCallback))
   this.ReplaceExecuteCallback();
  this.ReplaceFormsSubmit();
 },
 HandleDxCallbackBeginning: function() {
  ASPx.GetControlCollection().BeforeInitCallback.AddHandler(function(s, e) {
   aspxRaisePostHandlerOnPost(e.callbackOwnerID, true, false, true); 
  });
 },
 HandleMSAjaxRequestBeginning: function() {
  var pageRequestManager = ASPx.GetMSAjaxRequestManager();
  if(pageRequestManager != null && Ident.IsArray(pageRequestManager._onSubmitStatements)) {
   pageRequestManager._onSubmitStatements.unshift(function() {
    var postbackSettings = Sys.WebForms.PageRequestManager.getInstance()._postBackSettings;
    var postHandler = aspxGetPostHandler();
    aspxRaisePostHandlerOnPost(postbackSettings.asyncTarget, true, true);
    return !postHandler.cancelPostProcessing;
   });
  }
 },
 ReplaceDoPostBack: function() {
  var original = __doPostBack;
  __doPostBack = function(eventTarget, eventArgument) {
   var postHandler = aspxGetPostHandler();
   aspxRaisePostHandlerOnPost(eventTarget);
   if(postHandler.cancelPostProcessing)
    return;
   ASPxClientControl.postHandlingLocked = true;
   original(eventTarget, eventArgument);
   delete ASPxClientControl.postHandlingLocked;
  };
 },
 ReplaceDoCallback: function() {
  var original = WebForm_DoCallback;
  WebForm_DoCallback = function(eventTarget, eventArgument, eventCallback, context, errorCallback, useAsync) {
   var postHandler = aspxGetPostHandler();
   aspxRaisePostHandlerOnPost(eventTarget, true);
   if(postHandler.cancelPostProcessing)
    return;
   return original(eventTarget, eventArgument, eventCallback, context, errorCallback, useAsync);
  };
 },
 ReplaceExecuteCallback: function() {
  var original = WebForm_ExecuteCallback;
  var handler = this;
  WebForm_ExecuteCallback = function(callbackObject) {
   var isDxCallback = callbackObject && callbackObject.context && ASPx.GetControlCollection().Get(callbackObject.context) !== null;
   ASPx.callbackProcessed = false;
   original(callbackObject);
   if(isDxCallback && !ASPx.callbackProcessed) {
    var request = callbackObject.xmlRequest;
    if(handler.HasAppErrorOnCallback(request) && ASPxClientUtils.IsExists(callbackObject.eventCallback))
     callbackObject.eventCallback(handler.GetServerErrorText(), callbackObject.context);
   }
  };
 },
 HasAppErrorOnCallback: function(request) {
  if(!request) return false;
  var isServerError = request.status && request.status == 500;
  var pattern = /<html[^>]*>([\w|\W]*)<\/html>/im;
  var text = request.responseText;
  return isServerError && !!text && pattern.test(text);
 },
 GetServerErrorText: function() {
  return "Internal Server Error";
 }, 
 ReplaceFormsSubmit: function(checkObservableCollection) {
  for(var i = 0; i < document.forms.length; i++) { 
   var form = document.forms[i];
   if(checkObservableCollection && ASPx.Data.ArrayIndexOf(this.observableForms, form) >= 0)
    continue;
   if(form.submit)
    this.ReplaceFormSubmit(form);
   this.ReplaceFormOnSumbit(form);
   this.observableForms.push(form);
  }
 },
 ReplaceFormSubmit: function(form) {
  var originalSubmit = form.submit;
  form.submit = function() {
   var postHandler = aspxGetPostHandler();
   aspxRaisePostHandlerOnPost();
   if(postHandler.cancelPostProcessing)
    return false;
   var callee = arguments.callee;
   this.submit = originalSubmit;
   var submitResult = this.submit();
   this.submit = callee;
   return submitResult;
  };
  form = null;
 },
 ReplaceFormOnSumbit: function(form) {
  var originalSubmit = form.onsubmit;
  form.onsubmit = function() {
   var postHandler = aspxGetPostHandler();
   postHandler.beforeOnSubmit();
   if(postHandler.isMSAjaxRequest)
    postHandler.isMsAjaxRequest = false;
   else
    aspxRaisePostHandlerOnPost(postHandler.GetLastSubmitElementName());
   if(postHandler.cancelPostProcessing)
    return false;
   return ASPx.IsFunction(originalSubmit)
    ? originalSubmit.apply(this, arguments)
    : true;
  };
  form = null;
 },
 SetBeforeOnSubmit: function(action) {
  this.beforeOnSubmit = action;
 },
 SetLastSubmitElementName: function(elementName) {
  this.lastSubmitElementName = elementName;
 },
 GetLastSubmitElementName: function() {
  return this.lastSubmitElementName;
 },
 RemoveDisposedFormsFromCache: function(){
  for(var i = 0; this.observableForms && i < this.observableForms.length; i++){
   var form = this.observableForms[i];
   if(!ASPx.IsExistsElement(form)){
    ASPx.Data.ArrayRemove(this.observableForms, form);
    i--;
   }
  }
 }
});
function aspxRaisePostHandlerOnPost(ownerID, isCallback, isMSAjaxRequest, isDXCallback) {
 if(ASPxClientControl.postHandlingLocked) return;
 var postHandler = aspxGetPostHandler();
 if(postHandler)
  postHandler.ProcessPostRequest(ownerID, isCallback, isMSAjaxRequest, isDXCallback);
}
var aspxPostHandler;
function aspxGetPostHandler() {
 if(!aspxPostHandler)
  aspxPostHandler = new PostHandler();
 return aspxPostHandler;
}
var PostHandlerOnPostEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(ownerID, isCallback, isMSAjaxCallback, isDXCallback){
  this.constructor.prototype.constructor.call(this);
  this.ownerID = ownerID;
  this.isCallback = !!isCallback;
  this.isDXCallback = !!isDXCallback;
  this.isMSAjaxCallback = !!isMSAjaxCallback;
 }
});
var ResourceManager = {
 HandlerStr: "DXR.axd?r=",
 ResourceHashes: {},
 SynchronizeResources: function(method){
  if(!method){
   method = function(name, resource) { 
    this.UpdateInputElements(name, resource); 
   }.aspxBind(this);
  }
  var resources = this.GetResourcesData();
  for(var name in resources)
   if(resources.hasOwnProperty(name))
    method(name, resources[name]);
 },
 GetResourcesData: function(){
  return {
   DXScript: this.GetResourcesElementsString(_aspxGetIncludeScripts(), "src", "DXScript"),
   DXCss: this.GetResourcesElementsString(_aspxGetLinks(), "href", "DXCss")
  };
 },
 ParseBundleSrc: function(elements, urlAttr){
  var timeStamp = "";
  var resourceUrlArray = [];
  for(var i = 0; i < elements.length; i++) {
   var resourceUrl = ASPx.Attr.GetAttribute(elements[i], urlAttr);
   if(resourceUrl) {
    var pos = resourceUrl.indexOf(this.HandlerStr);
    if(pos > -1){
     var list = resourceUrl.substr(pos + this.HandlerStr.length);
     var ampPos = list.lastIndexOf("-");
     if(ampPos > -1) {
      timeStamp = list.substr(ampPos);
      list = list.substr(0, ampPos);
     }
     var indexes = list.split(",");
     for(var j = 0; j < indexes.length; j++) {
      resourceUrlArray.push(indexes[j]);
     }
    }
    else
     resourceUrlArray.push(resourceUrl);
   }
  }
  return {
   'resourceUrlArray': resourceUrlArray,
   'timeStamp': timeStamp
  };
 },
 GetResourceHashes: function (id) {
  if (!this.ResourceHashes[id])
   this.ResourceHashes[id] = {};
  return this.ResourceHashes[id];
 },
 GetResourcesElementsString: function (elements, urlAttr, id) {
  var hash = this.GetResourceHashes(id);
  var resourceUrlArray = this.ParseBundleSrc(elements, urlAttr).resourceUrlArray;
  for(var i = 0; i < resourceUrlArray.length; i++) {
   hash[resourceUrlArray[i]] = resourceUrlArray[i];
  }
  var array = [];
  for(var key in hash)
   if(hash.hasOwnProperty(key))
    array.push(key);
  return array.join(",");
 },
 GetNewResourcesElementString: function (element, urlAttr, id) {
  var originalUrl = ASPx.Attr.GetAttribute(element, urlAttr);
  var handlerStrIndex = originalUrl.indexOf(this.HandlerStr);
  var dxResources = handlerStrIndex > -1;
  if(!dxResources) return element[urlAttr];
  var hash = this.GetResourceHashes(id);
  var srcInfo = this.ParseBundleSrc([element], urlAttr);
  var resourceUrlArray = srcInfo.resourceUrlArray;
  var timeStamp = srcInfo.timeStamp;
  var newResourceArray = [];
  for(var i = 0; i < resourceUrlArray.length; i++) {
    if(!hash[resourceUrlArray[i]])
    newResourceArray.push(resourceUrlArray[i]);
  }
  var newResources = "";
  if(newResourceArray.length > 0) {
   var baseUrl = originalUrl.substr(0, handlerStrIndex);
   newResources = baseUrl + this.HandlerStr + newResourceArray.join(",") + timeStamp;
  }
  return newResources;
 },
 UpdateInputElements: function(typeName, list){
  for(var i = 0; i < document.forms.length; i++){
   var inputElement = document.forms[i][typeName];
   if(!inputElement)
    inputElement = this.CreateInputElement(document.forms[i], typeName);
   inputElement.value = list;
  }
 },
 CreateInputElement: function(form, typeName){
  var inputElement = ASPx.CreateHiddenField(typeName);
  form.appendChild(inputElement);
  return inputElement;
 }
};
ASPx.includeScriptPrefix = "dxis_";
ASPx.startupScriptPrefix = "dxss_";
var includeScriptsCache = {};
var createdIncludeScripts = [];
var appendedScriptsCount = 0;
var callbackOwnerNames = [];
var scriptsRestartHandlers = { };
function _aspxIsKnownIncludeScript(script) {
 return !!includeScriptsCache[script.src];
}
function _aspxCacheIncludeScript(script) {
 includeScriptsCache[script.src] = 1;
}
function _aspxProcessScriptsAndLinks(ownerName, isCallback) {
 if(!ASPx.documentLoaded) return; 
 _aspxProcessScripts(ownerName, isCallback);
 getLinkProcessor().process();
 ASPx.ClearCachedCssRules();
}
function _aspxGetStartupScripts(container) {
 return _aspxGetScriptsCore(ASPx.startupScriptPrefix, container);
}
function _aspxGetIncludeScripts() {
 return _aspxGetScriptsCore(ASPx.includeScriptPrefix);
}
function _aspxGetScriptsCore(prefix, container) {
 var result = [];
 var scripts;
 if(ASPx.IsExists(container))
  scripts = ASPx.GetNodesByTagName(container, "SCRIPT");
 else
  scripts = document.getElementsByTagName("SCRIPT");
 for(var i = 0; i < scripts.length; i++) {
  if(scripts[i].id.indexOf(prefix) == 0)
   result.push(scripts[i]);
 }
 return result;
}
function _aspxIsResourceLink(link) {
 if(typeof link !== "string")
  link = link.href;
 return link.toLowerCase().indexOf(ResourceManager.HandlerStr.toLowerCase()) >= 0;
}
function _aspxGetLinks(allLinks) {
 var result = [];
 var links = document.getElementsByTagName("LINK");
 for(var i = 0; i < links.length; i++) {
  if(allLinks || _aspxIsResourceLink(links[i]))
   result.push(links[i]);
 }
 return result;
}
function _aspxIsLinksLoaded() {
 var links = _aspxGetLinks(true);
 for(var i = 0, link; link = links[i]; i++)
  if(link.readyState && link.readyState.toLowerCase() == "loading")
    return false;
 return true;
}
function _aspxInitializeLinks() {
 var links = _aspxGetLinks(true);
 for(var i = 0; i < links.length; i++)
  links[i].loaded = true; 
}
var scriptExecutedAttrName = "data-executed";
var scriptDelayedExecutionAttrName = "data-dx-delayedeval";
ASPx.MarkInnerScriptBlocksAsDelayedExecution = function(scriptsContainer) {
 var scripts = scriptsContainer.querySelectorAll("script[id^=" + ASPx.startupScriptPrefix + "]");
 for(var i = 0; i < scripts.length; i++)
  ASPx.Attr.SetAttribute(scripts[i], scriptDelayedExecutionAttrName, true);
};
function isScriptExecuted(script) {
 return ASPx.Attr.GetAttribute(script, scriptExecutedAttrName);
}
function markScriptAsExecuted(script) {
 if(ASPx.Attr.GetAttribute(script, scriptDelayedExecutionAttrName))
  ASPx.Attr.RemoveAttribute(script, scriptDelayedExecutionAttrName);
 else
  ASPx.Attr.SetAttribute(script, scriptExecutedAttrName, true);
}
function _aspxInitializeScripts() {
 var scripts = _aspxGetIncludeScripts();
 for(var i = 0; i < scripts.length; i++)
  _aspxCacheIncludeScript(scripts[i]);   
 var startupScripts = _aspxGetStartupScripts();
 for(var i = 0; i < startupScripts.length; i++)
  markScriptAsExecuted(startupScripts[i]);
}
function _aspxSweepDuplicatedLinks() {
 var hash = { };
 var links = _aspxGetLinks();
 for(var i = 0; i < links.length; i++) {
  var href = links[i].href;
  if(!href)
   continue;
  if(hash[href]){
   if((ASPx.Browser.IE || !hash[href].loaded) && links[i].loaded) {
    ASPx.RemoveElement(hash[href]);
    hash[href] = links[i];
   }
   else
    ASPx.RemoveElement(links[i]);
  }
  else
   hash[href] = links[i];
 }
}
function _aspxSweepDuplicatedScripts() {
 var hash = { };
 var scripts = _aspxGetIncludeScripts();
 for(var i = 0; i < scripts.length; i++) {
  var src = scripts[i].src;
  if(!src) continue;
  if(hash[src])
   ASPx.RemoveElement(scripts[i]);
  else
   hash[src] = scripts[i];
 }
}
function _aspxAreScriptsEqual(script1, script2) {
 return script1.src == script2.src;
}
function _aspxProcessScripts(ownerName, isCallback) {
 var scripts = _aspxGetIncludeScripts();
 var previousCreatedScript = null;
 var firstCreatedScript = null;
 for(var i = 0; i < scripts.length; i++) {
  var script = scripts[i];
  if(script.src == "") continue; 
  if(_aspxIsKnownIncludeScript(script))
   continue;
  var getOnlyNewResources = true;
  var onlyNewScripts = ResourceManager.GetNewResourcesElementString(script, "src", "DXScript", getOnlyNewResources);
  if (onlyNewScripts == "")
   continue;
  var createdScript = document.createElement("script");
  ASPx.Attr.AppendScriptType(createdScript);
  createdScript.src = onlyNewScripts;
  createdScript.id = script.id;
  if(ASPx.Data.ArrayIndexOf(createdIncludeScripts, createdScript, _aspxAreScriptsEqual) >= 0)
   continue;
  createdIncludeScripts.push(createdScript);
  ASPx.RemoveElement(script);
  if(ASPx.Browser.IE && ASPx.Browser.Version < 9) {
   createdScript.onreadystatechange = new Function("ASPx.OnScriptReadyStateChangedCallback(this, " + isCallback + ");");
  } else if(ASPx.Browser.Edge || ASPx.Browser.WebKitFamily || (ASPx.Browser.Firefox && ASPx.Browser.Version >= 4) || ASPx.Browser.IE && ASPx.Browser.Version >= 9) {
   createdScript.onload = new Function("ASPx.OnScriptLoadCallback(this, " + isCallback + ");");
   if(firstCreatedScript == null)
    firstCreatedScript = createdScript;
   createdScript.nextCreatedScript = null;
   if(previousCreatedScript != null)
    previousCreatedScript.nextCreatedScript = createdScript;
   previousCreatedScript = createdScript;
  } else {
   createdScript.onload = new Function("ASPx.OnScriptLoadCallback(this);");
   ASPx.AppendScript(createdScript);
   _aspxCacheIncludeScript(createdScript);
  }
 }
 if(firstCreatedScript != null) {
  ASPx.AppendScript(firstCreatedScript);
  _aspxCacheIncludeScript(firstCreatedScript);
 }
 if(isCallback)
  callbackOwnerNames.push(ownerName);
 if(createdIncludeScripts.length == 0) {
  var newLinks = ASPx.GetNodesByTagName(document.body, "link");
  var needProcessLinks = isCallback && newLinks.length > 0;
  if(needProcessLinks)
   needProcessLinks = getLinkProcessor().addLinks(newLinks);
  if(!needProcessLinks)
   ASPx.FinalizeScriptProcessing(isCallback);
 }
}
ASPx.FinalizeScriptProcessing = function(isCallback) {
 createdIncludeScripts = [];
 appendedScriptsCount = 0;
 var linkProcessor = getLinkProcessor();
 if(linkProcessor.hasLinks())
  _aspxSweepDuplicatedLinks();
 linkProcessor.reset();
 _aspxSweepDuplicatedScripts();
 ResourceManager.SynchronizeResources();
 _aspxRunStartupScripts(isCallback);
};
var startupScriptsRunning = false;
function _aspxRunStartupScripts(isCallback, container) {
 startupScriptsRunning = true;
 try {
  _aspxRunStartupScriptsCore(container);
 }
 finally {
  startupScriptsRunning = false;
 }
 if(ASPx.documentLoaded) {
  ASPx.GetControlCollection().ProcessActionByPredicate(
   function(collection) { collection.InitializeElements(isCallback); },
   function(control) { return !ASPx.IsExists(container) || ASPx.GetIsParent(container, control.GetMainElement()); }
  );
  for(var key in scriptsRestartHandlers)
   if(scriptsRestartHandlers.hasOwnProperty(key))
    scriptsRestartHandlers[key]();
  _aspxRunEndCallbackScript();
 }
}
function _aspxIsStartupScriptsRunning(isCallback) {
 return startupScriptsRunning;
}
function _aspxRunStartupScriptsCore(container) {
 var scripts = _aspxGetStartupScripts(container);
 var code;
 for(var i = 0; i < scripts.length; i++){
  var script = scripts[i];
  if(!isScriptExecuted(script)) {
   _aspxEnsureStartupScriptIsUnique(script.id); 
   code = ASPx.GetScriptCode(script);
   eval(code);
   markScriptAsExecuted(script);
  }
 }
}
function _aspxEnsureStartupScriptIsUnique(scriptId) {
 if(!scriptId)
  return;
 var scriptExecutedSelector = "script[" + scriptExecutedAttrName + "='true']#" + scriptId;
 ASPx.RemoveElement(document.querySelector(scriptExecutedSelector));
}
function _aspxRunEndCallbackScript() {
 while(callbackOwnerNames.length > 0) {
  var callbackOwnerName = callbackOwnerNames.pop();
  var callbackOwner = ASPx.GetControlCollection().Get(callbackOwnerName);
  if(callbackOwner)
   callbackOwner.DoEndCallback();
 }
}
ASPx.OnScriptReadyStateChangedCallback = function(scriptElement, isCallback) {
 if(scriptElement.readyState == "loaded") {
  _aspxCacheIncludeScript(scriptElement);
  for(var i = 0; i < createdIncludeScripts.length; i++) {
   var script = createdIncludeScripts[i];
   if(_aspxIsKnownIncludeScript(script)) {
    if(!isScriptExecuted(script)) {
     markScriptAsExecuted(script);
     ASPx.AppendScript(script);
     appendedScriptsCount++;
    }
   } else
    break;
  }
  if(createdIncludeScripts.length == appendedScriptsCount)
   ASPx.FinalizeScriptProcessing(isCallback);
 }
};
ASPx.OnScriptLoadCallback = function(scriptElement, isCallback) {
 appendedScriptsCount++;
 if(scriptElement.nextCreatedScript) {
  ASPx.AppendScript(scriptElement.nextCreatedScript);
  _aspxCacheIncludeScript(scriptElement.nextCreatedScript);
 }
 if(createdIncludeScripts.length == appendedScriptsCount)
  ASPx.FinalizeScriptProcessing(isCallback);
};
function _aspxAddScriptsRestartHandler(objectName, handler) {
 scriptsRestartHandlers[objectName] = handler;
}
function _aspxMoveLinkElements() {
 var head = ASPx.GetNodesByTagName(document, "head")[0];
 var bodyLinks = ASPx.GetNodesByTagName(document.body, "link");
 if(head && bodyLinks.length > 0){
  var headLinks = ASPx.GetNodesByTagName(head, "link");
  var dxLinkAnchor = head.firstChild;
  for(var i = 0; i < headLinks.length; i++){
   if(_aspxIsResourceLink(headLinks[i]))
    dxLinkAnchor = headLinks[i].nextSibling;
  }
  while(bodyLinks.length > 0) 
   head.insertBefore(bodyLinks[0], dxLinkAnchor);
 }
}
var LinkProcessor = ASPx.CreateClass(null, {
 constructor: function() {
  this.loadedLinkCount = 0;
  this.linkInfos = [];
  this.loadingObservationTimerID = -1;
 },
 process: function() {
  if(this.hasLinks()) {
   if(this.isLinkLoadEventSupported())
    this.processViaLoadEvent();
   else
    this.processViaTimer();
  }
  else
   _aspxSweepDuplicatedLinks();
  _aspxMoveLinkElements();
 },
 addLinks: function(links) {
  var prevLinkCount = this.linkInfos.length;
  for(var i = 0; i < links.length; i++) {
   var link = links[i];
   if(link.loaded || link.rel != "stylesheet" || !_aspxIsResourceLink(link))
    continue;
   var linkInfo = {
    link: link,
    href: link.href
   };
   this.linkInfos.push(linkInfo);
  }
  return prevLinkCount != this.linkInfos.length;
 },
 hasLinks: function() {
  return this.linkInfos.length > 0;
 },
 reset: function() {
  this.linkInfos = [];
  this.loadedLinkCount = 0;
 },
 processViaLoadEvent: function() {
  var that = this;
  for(var i = 0, linkInfo; linkInfo = this.linkInfos[i]; i++) {
   if(ASPx.Browser.IE && ASPx.Browser.Version < 9)
    linkInfo.link.onreadystatechange = function() { that.onLinkReadyStateChanged(this); };
   else
    linkInfo.link.onload = this.onLinkLoad.aspxBind(this);
  }
 },
 isLinkLoadEventSupported: function() {
  return !(ASPx.Browser.Chrome && ASPx.Browser.MajorVersion < 19 || ASPx.Browser.Firefox && ASPx.Browser.MajorVersion < 9 ||
   ASPx.Browser.Safari && ASPx.Browser.MajorVersion < 6 || ASPx.Browser.AndroidDefaultBrowser && ASPx.Browser.MajorVersion < 4.4);
 },
 processViaTimer: function() {
  if(this.loadingObservationTimerID == -1)
   this.onLinksLoadingObserve();
 },
 onLinksLoadingObserve: function() {
  if(this.getIsAllLinksLoaded()) {
   this.loadingObservationTimerID = -1;
   this.onAllLinksLoad();
  }
  else
   this.loadingObservationTimerID = window.setTimeout(this.onLinksLoadingObserve.aspxBind(this), 100);
 },
 getIsAllLinksLoaded: function() {
  var styleSheets = document.styleSheets;
  var loadedLinkHrefs = { };
  for(var i = 0; i < styleSheets.length; i++) {
   var styleSheet = styleSheets[i];
   try {
    if(styleSheet.cssRules)
     loadedLinkHrefs[styleSheet.href] = 1;
   }
   catch(ex) { }
  }
  var loadedLinksCount = 0;
  for(var i = 0, linkInfo; linkInfo = this.linkInfos[i]; i++) {
   if(loadedLinkHrefs[linkInfo.href])
    loadedLinksCount++;
  }
  return loadedLinksCount == this.linkInfos.length;
 },
 onAllLinksLoad: function() {
  this.reset();
  _aspxSweepDuplicatedLinks();
  if(createdIncludeScripts.length == 0)
   ASPx.FinalizeScriptProcessing(true);
 },
 onLinkReadyStateChanged: function(linkElement) {
  if(linkElement.readyState == "complete")
   this.onLinkLoadCore(linkElement);
 },
 onLinkLoad: function(evt) {
  var linkElement = ASPx.Evt.GetEventSource(evt);
  this.onLinkLoadCore(linkElement);
 },
 onLinkLoadCore: function(linkElement) {
  if(!this.hasLinkElement(linkElement)) return;
  this.loadedLinkCount++;
  if(!ASPx.Browser.Firefox && this.loadedLinkCount == this.linkInfos.length || 
   ASPx.Browser.Firefox && this.loadedLinkCount == 2 * this.linkInfos.length) {
   this.onAllLinksLoad();
  }
 },
 hasLinkElement: function(linkElement) {
  for(var i = 0, linkInfo; linkInfo = this.linkInfos[i]; i++) {
   if(linkInfo.link == linkElement)
    return true;
  }
  return false;
 }
});
var linkProcessor = null;
function getLinkProcessor() {
 if(linkProcessor == null)
  linkProcessor = new LinkProcessor();
 return linkProcessor;
}
ASPx.LinkProcessor = LinkProcessor;
var IFrameHelper = ASPx.CreateClass(null, {
 constructor: function(params) {
  this.params = params || {};
  this.params.src = this.params.src || "";
  this.CreateElements();
 },
 CreateElements: function() {
  var elements = IFrameHelper.Create(this.params);
  this.containerElement = elements.container;
  this.iframeElement = elements.iframe;
  this.AttachOnLoadHandler(this, this.iframeElement);
  this.SetLoading(true);
  if(this.params.onCreate)
   this.params.onCreate(this.containerElement, this.iframeElement);
 },
 AttachOnLoadHandler: function(instance, element) {
  ASPx.Evt.AttachEventToElement(element, "load", function() {
   instance.OnLoad(element);
  });
 },
 OnLoad: function(element) {
  this.SetLoading(false, element);
  if(!element.preventCustomOnLoad && this.params.onLoad)
   this.params.onLoad();
 },
 IsLoading: function(element) {
  element = element || this.iframeElement;
  if(element)
   return element.loading;
  return false;
 },
 SetLoading: function(value, element) {
  element = element || this.iframeElement;
  if(element)
   element.loading = value;
 },
 GetContentUrl: function() {
  return this.params.src;
 },
 SetContentUrl: function(url, preventBrowserCaching) {
  if(url) {
   this.params.src = url;
   if(preventBrowserCaching)
    url = IFrameHelper.AddRandomParamToUrl(url);
   this.SetLoading(true);
   this.iframeElement.src = url;
  }
 },
 RefreshContentUrl: function() {
  if(this.IsLoading())
   return;
  this.SetLoading(true);
  var oldContainerElement = this.containerElement;
  var oldIframeElement = this.iframeElement;
  var postfix = "_del" + Math.floor(Math.random()*100000).toString();
  if(this.params.id)
   oldIframeElement.id = this.params.id + postfix;
  if(this.params.name)
   oldIframeElement.name = this.params.name + postfix;
  ASPx.SetStyles(oldContainerElement, { height: 0 });
  this.CreateElements();
  oldIframeElement.preventCustomOnLoad = true;
  oldIframeElement.src = ASPx.BlankUrl;
  window.setTimeout(function() {
   oldContainerElement.parentNode.removeChild(oldContainerElement);
  }, 10000); 
 }
});
IFrameHelper.Create = function(params) {
 var iframeHtmlStringParts = [ "<iframe frameborder='0'" ];
 if(params) {
  if(params.id)
   iframeHtmlStringParts.push(" id='", params.id, "'");
  if(params.name)
   iframeHtmlStringParts.push(" name='", params.name, "'");
  if(params.title)
   iframeHtmlStringParts.push(" title='", params.title, "'");
  if(params.scrolling)
   iframeHtmlStringParts.push(" scrolling='", params.scrolling, "'");
  if(params.src)
   iframeHtmlStringParts.push(" src='", params.src, "'");
 }
 iframeHtmlStringParts.push("></iframe>");
 var containerElement = ASPx.CreateHtmlElementFromString("<div style='border-width: 0px; padding: 0px; margin: 0px'></div>");
 var iframeElement = ASPx.CreateHtmlElementFromString(iframeHtmlStringParts.join(""));
 containerElement.appendChild(iframeElement);
 return {
  container: containerElement,
  iframe: iframeElement
 };
};
IFrameHelper.AddRandomParamToUrl = function(url) {
 var prefix = url.indexOf("?") > -1
  ? "&"
  : "?";
 var param = prefix + Math.floor(Math.random()*100000).toString();
 var anchorIndex = url.indexOf("#");
 return anchorIndex == -1
  ? url + param
  : url.substr(0, anchorIndex) + param + url.substr(anchorIndex);
};
IFrameHelper.GetWindow = function(name) {
 if(ASPx.Browser.IE)
  return window.frames[name].window;
 else{
  var frameElement = document.getElementById(name);
  return (frameElement != null) ? frameElement.contentWindow : null;
 }
};
IFrameHelper.GetDocument = function(name) {
 var frameElement;
 if(ASPx.Browser.IE) {
  frameElement = window.frames[name];
  return (frameElement != null) ? frameElement.document : null;
 }
 else {
  frameElement = document.getElementById(name);
  return (frameElement != null) ? frameElement.contentDocument : null;
 }
};
IFrameHelper.GetDocumentBody = function(name) {
 var doc = IFrameHelper.GetDocument(name);
 return (doc != null) ? doc.body : null;
};
IFrameHelper.GetDocumentHead = function (name) {
 var doc = IFrameHelper.GetDocument(name);
 return (doc != null) ? doc.head || doc.getElementsByTagName('head')[0] : null;
};
IFrameHelper.GetElement = function(name) {
 if(ASPx.Browser.IE)
  return window.frames[name].window.frameElement;
 else
  return document.getElementById(name);
};
var KbdHelper = ASPx.CreateClass(null, {
 constructor: function(control) {
  this.control = control;
 },
 Init: function() {
  KbdHelper.GlobalInit();
  var elements = this.getFocusableElements();
  for(var i = 0; i < elements.length; i++) {
   var element = elements[i];
   element.tabIndex = Math.max(element.tabIndex, 0);
   ASPx.Evt.AttachEventToElement(element, "click", function(e) { this.HandleClick(e); }.aspxBind(this));
   ASPx.Evt.AttachEventToElement(element, "focus", function(e) {    
    return this.onElementFocus(e);
   }.aspxBind(this));
   ASPx.Evt.AttachEventToElement(element, "blur", function () { this.onBlur(); }.aspxBind(this)); 
  }   
 },
 onElementFocus: function(e) {
  if(!this.CanFocus(e))
   return true;
  KbdHelper.active = this;
 },
 getFocusableElements: function() {
  return [this.GetFocusableElement()]; 
 },
 GetFocusableElement: function() { return this.control.GetMainElement(); },
 canHandleNoFocusAction: function() { 
  var focusableElements = this.getFocusableElements();
  for(var i = 0; i < focusableElements.length; i++) {
   if(focusableElements[i] === _aspxGetFocusedElement())
    return false;
  }
  return true;
 },
 RequirePreventScrollOnFocus: function() { return false; },
 CanFocus: function(e) {
  var tag = ASPx.Evt.GetEventSource(e).tagName;
  return !(tag === "A" || tag === "TEXTAREA" || tag === "INPUT" || tag === "SELECT" || tag === "IFRAME" || tag === "OBJECT");
 },
 HandleClick: function(e) {
  if(!this.CanFocus(e))
   return;
  this.Focus();
 },
 Focus: function() {
  var preventScroll = this.RequirePreventScrollOnFocus() && !ASPx.Browser.IE; 
  var savedDocumentScrollTop = preventScroll ? ASPx.GetDocumentScrollTop() : -1;
  try {
   this.GetFocusableElement().focus({ preventScroll: preventScroll });
  } catch(e) { }
  if(preventScroll && !this.IsNativePreventScrollOnFocusSupported() && savedDocumentScrollTop !== ASPx.GetDocumentScrollTop())
   ASPx.SetDocumentScrollTop(savedDocumentScrollTop);
 },
 IsNativePreventScrollOnFocusSupported: function() {
  if(this.isNativePreventScrollOnFocusSupported === undefined)
   this.isNativePreventScrollOnFocusSupported = this.CalcIsNativePreventScrollOnFocusSupported();
  return this.isNativePreventScrollOnFocusSupported;
 },
 CalcIsNativePreventScrollOnFocusSupported: function() {
  var result = false;
  try {
   ASPx.GetActiveElement().focus(Object.defineProperty({}, "preventScroll", { get: function() { result = true; } }));
  } catch(e) { result = false; }
  return result;
 },
 onBlur: function(){
  delete KbdHelper.active;
 },
 HandleKeyDown: function(e) { }, 
 HandleKeyPress: function(e) { }, 
 HandleKeyUp: function (e) { },
 HandleNoFocusAction: function(e) { },
 FocusByAccessKey: function () { }
});
KbdHelper.GlobalInit = function() {
 if(KbdHelper.ready)
  return;
 ASPx.Evt.AttachEventToDocument("keydown", KbdHelper.OnKeyDown);
 ASPx.Evt.AttachEventToDocument("keypress", KbdHelper.OnKeyPress);
 ASPx.Evt.AttachEventToDocument("keyup", KbdHelper.OnKeyUp);
 KbdHelper.ready = true; 
};
KbdHelper.swallowKey = false;
KbdHelper.accessKeys = { };
KbdHelper.ProcessKey = function(e, actionName) {
 if(!KbdHelper.active) 
  return;
 if (KbdHelper.active.canHandleNoFocusAction()) {
  KbdHelper.active["HandleNoFocusAction"](e, actionName);
  return;
 }
 var ctl = KbdHelper.active.control;
 if(ctl !== ASPx.GetControlCollection().Get(ctl.name)) {
  delete KbdHelper.active;
  return;
 }
 if(!KbdHelper.swallowKey) 
  KbdHelper.swallowKey = KbdHelper.active[actionName](e);
 if(KbdHelper.swallowKey)
  ASPx.Evt.PreventEvent(e);
};
KbdHelper.OnKeyDown = function(e) {
 KbdHelper.swallowKey = false;
 if(KbdHelper.TryAccessKey(KbdHelper.getKeyName(e)))
  ASPx.Evt.PreventEvent(e);
 else 
  KbdHelper.ProcessKey(e, "HandleKeyDown"); 
};
KbdHelper.OnKeyPress = function(e) { KbdHelper.ProcessKey(e, "HandleKeyPress"); };
KbdHelper.OnKeyUp = function(e) { KbdHelper.ProcessKey(e, "HandleKeyUp"); };
KbdHelper.RegisterAccessKey = function(obj) {
 var key;
 if(obj.accessKey)
  key = "CtrlShift" + obj.accessKey;
 else if(obj.keyTipModeShortcut)
  key = obj.keyTipModeShortcut;
 if(!key) return;
 KbdHelper.accessKeys[key.toLowerCase()] = obj.name;
};
KbdHelper.TryAccessKey = function(code) {
 var key = code.toLowerCase ? code.toLowerCase() : String.fromCharCode(code).toLowerCase();
 var name = KbdHelper.accessKeys[key];
 if(!name) return false;
 var obj = ASPx.GetControlCollection().Get(name);
 return KbdHelper.ClickAccessKey(obj);
};
KbdHelper.ClickAccessKey = function (control) {
 if (!control) return false;
 var el = control.GetMainElement();
 if (!el) return false;
 el.focus();
 setTimeout(function () {
  if (KbdHelper.active && KbdHelper.active.FocusByAccessKey)
   KbdHelper.active.FocusByAccessKey();
 }.aspxBind(this), ASPx.FOCUS_TIMEOUT);
 return true;
};
KbdHelper.getKeyName = function(e) {
 var name = "";
 if(e.altKey)
  name += "Alt";
 if(e.ctrlKey)
  name += "Ctrl";
 if(e.shiftKey)
  name += "Shift";
 var keyCode = e.key || e.code || String.fromCharCode(ASPx.Evt.GetKeyCode(e));
 if(keyCode.match(/key/i))
  name += keyCode.replace(/key/i, "");
 else if(keyCode.match(/digit/i))
  name += keyCode.replace(/digit/i, "");
 else if(keyCode.match(/arrow/i))
  name += keyCode.replace(/arrow/i, "");
 else if(keyCode.match(/ins/i))
  name += "Ins";
 else if(keyCode.match(/del/i))
  name += "Del";
 else if(keyCode.match(/back/i))
  name += "Back";
 else if(!keyCode.match(/alt/i) && !keyCode.match(/control/i) && !keyCode.match(/shift/i))
  name += keyCode;
 return name.replace(/^a-zA-Z0-9/, "");
};
AccessKeysHelper = ASPx.CreateClass(KbdHelper, {
 constructor: function (control) {
  this.constructor.prototype.constructor.call(this, control);
  this.accessKeysVisible = false;
  this.activeKey = null;
  this.accessKey = control.createAccessKey ? control.createAccessKey(control.accessKey) : new AccessKey(control.accessKey);
  this.accessKeys = this.accessKey.accessKeys;
  this.charIndex = 0;
  this.onFocusByAccessKey = null;
  this.onClose = null;
  this.manualStopProcessing = false;
  this.isActive = false;
  this.areAccessKeysShown = false;
 },
 Init: function (control) {
  KbdHelper.prototype.Init.call(this);
  KbdHelper.RegisterAccessKey(control);   
 },
 Add: function (accessKey) {
  this.accessKey.Add(accessKey);
 },
 HandleKeyDown: function (e) {
  var keyCode = ASPx.Evt.GetKeyCode(e);
  var stopProcessing = this.processKeyDown(keyCode);
  if (stopProcessing.value) {
   this.stopProcessing();
   if(this.onClosedOnEscape && (keyCode == ASPx.Key.Esc || stopProcessing.fireEvent))
    this.onClosedOnEscape();
  }
  return stopProcessing;
 },
 HandleNoFocusAction: function (e, actionName) {
  var keyCode = ASPx.Evt.GetKeyCode(e);
  if (this.onClosedOnEscape && keyCode == ASPx.Key.Esc && actionName == "HandleKeyDown")
   this.onClosedOnEscape();
 },
 Activate: function () {
  KbdHelper.ClickAccessKey(this.control);
  this.areAccessKeysShown = true;
 },
 Stop: function() {
  this.stopProcessing();
 },
 stopProcessing: function () {
  this.HideAccessKeys();
  if (KbdHelper.active && this.isActive) {
   this.isActive = false;
   KbdHelper.active.control.GetMainElement().blur();
   delete KbdHelper.active;
  }
 },
 onBlur: function() {
  if (this.manualStopProcessing) {
   this.manualStopProcessing = false;
   return;
  }
  this.HideAccessKeys();
  KbdHelper.prototype.onBlur.call(this);
 },
 processKeyDown: function (keyCode) {
  switch (keyCode) {
   case ASPx.Key.Left:
    this.TryMoveFocusLeft();
    return { value: false };
   case ASPx.Key.Right:
    this.TryMoveFocusRight();
    return { value: false };
   case ASPx.Key.Esc:
    if(this.control.hideAllPopups)
     this.control.hideAllPopups(true, true);
    if(this.activeKey)
     this.activeKey = this.activeKey.Return();
    this.charIndex = 0;
    if (!this.activeKey)
     return { value: true };
    break;
   case ASPx.Key.Enter:
    return { value: true };
   default:
    if (!ASPx.IsPrintableKey(keyCode))
     return { value: false };
    var char = String.fromCharCode(keyCode).toUpperCase();
    var needToContinue = { value: false };
    var keyResult;
    if(this.activeKey)
     keyResult = this.activeKey.TryAccessKey(char, this.charIndex, needToContinue);
    if (needToContinue.value) {
     this.charIndex++;
     return { value: false };
    }
    this.charIndex = 0;
    if(keyResult !== undefined)
     this.activeKey = keyResult;
    else
     return { value: true, fireEvent: true };
    if (!this.activeKey || !this.activeKey.accessKeys || this.activeKey.accessKeys.length == 0) {
     if (this.activeKey && this.activeKey.manualStopProcessing) {
      this.manualStopProcessing = true;
      break;
     }
     return { value: true, fireEvent: true };
    }
  }
  return { value: false };
 },
 TryMoveFocusLeft: function (modifier) {},
 TryMoveFocusRight: function (modifier) {},
 TryMoveFocusUp: function (modifier) {},
 TryMoveFocusDown: function (modifier) {},
 FocusByAccessKey: function() {
  if (this.onFocusByAccessKey)
   this.onFocusByAccessKey();
  this.HideAccessKeys();
  KbdHelper.prototype.FocusByAccessKey.call(this);
  this.activeKey = this.accessKey;
  this.activeKey.execute();
  this.isActive = true;
  this.areAccessKeysShown = true;
 },
 HideAccessKeys: function() {
  this.areAccessKeysShown = false;
  this.hideAccessKeys(this.accessKey);
 },
 Update: function() {
  this.throttleMethod(this.refresh, 100);
 },
 refresh: function() {
  if(this.activeKey && this.areAccessKeysShown) {
   this.activeKey.execute();
  }
 },
 throttleMethod: function(method, delay) {
  clearTimeout(method.timerId);
  method.timerId = setTimeout(function() {
   method.call(this);
  }.aspxBind(this), delay);
 },
 AreAccessKeysShown: function() {
  return this.areAccessKeysShown;
 },
 hideAccessKeys: function (accessKey) {
  for (var i = 0, ak; ak = accessKey.accessKeys[i]; i++) {
   this.hideAccessKeys(ak);
  }
  if (accessKey)
   accessKey.hide();
 },
 HandleClick: function(e) {
  KbdHelper.prototype.HandleClick.call(this, e);
  this.stopProcessing();
 }
});
AccessKey = ASPx.CreateClass(null, {
 constructor: function (popupItem, getPopupElement, keyTipElement, key, onlyClick, manualStopProcessing) {
  this.key = key ? key : keyTipElement ? ASPxClientUtils.Trim(ASPx.GetInnerText(keyTipElement)) : null;
  this.popupItem = popupItem;
  this.getPopupElement = getPopupElement;
  this.keyTipElement = keyTipElement;
  this.accessKeys = [];
  this.needShowChilds = true;
  this.parent = null;
  this.onlyClick = onlyClick;
  this.manualStopProcessing = manualStopProcessing;
 },
 Add: function (accessKey) {
  this.accessKeys.push(accessKey);
  accessKey.parent = this;
 },
 TryAccessKey: function (char, index, needToContinue) {
  if (!this.accessKeys || this.accessKeys.length == 0)
   return;
  for (var i = 0, accessKey; accessKey = this.accessKeys[i]; i++) {
   if (accessKey.key[index] == char && accessKey.isVisible()) {
    if (accessKey.key[index + 1]) {
     needToContinue.value = true;
    }
    else {
     accessKey.execute();
     return accessKey;
    }
   } else {
    accessKey.hide();
   }
  }
  for (var i = 0, accessKey; accessKey = this.accessKeys[i]; i++) {
   var key = accessKey.TryAccessKey(char, index, needToContinue);
   if (key)
    return key;
  }
  return;
 },
 isVisible: function(){
  return ASPx.GetElementVisibility(this.keyTipElement);
 },
 Return: function () {
  this.hideChildAccessKeys();
  if (this.parent) {
   this.parent.showAccessKeys(true);
  }  
  return this.parent;
 },
 execute: function () {
  this.hideAll();
  if (this.popupItem && this.popupItem.accessKeyClick && !this.onlyClick)
   this.popupItem.accessKeyClick();
  if (this.getPopupElement && this.onlyClick)
   ASPx.Evt.EmulateMouseClick(this.getPopupElement(this.popupItem));
  if (this.accessKeys)
   setTimeout(function () {
    this.showAccessKeys(true);
   }.aspxBind(this), 100);
 },
 showAccessKeys: function(directShow) {
  if (!directShow && !this.needShowChilds)
   return;
  for (var i = 0; i < this.accessKeys.length; i++) {
   var accessKey = this.accessKeys[i];
   if (accessKey) {
    var popupElement = accessKey.getPopupElement ? accessKey.getPopupElement(accessKey.popupItem) : null;
    if (popupElement && this.isElementVisible(popupElement)) {
     this.show(accessKey);
    }
    accessKey.showAccessKeys();
   }
  }
 },
 isElementVisible: function (el) { return ASPx.IsElementVisible(el, true); },
 show: function(accessKey) {
  var keyTipElement = accessKey.keyTipElement;
  var popupElement = accessKey.getPopupElement(accessKey.popupItem);
  this.showKeyTipElement(keyTipElement, this.calculateCoordinates(accessKey, keyTipElement, popupElement));
 },
 showKeyTipElement: function (keyTipElement, coordinates) {
  ASPx.SetAbsoluteY(keyTipElement, coordinates.top);
  ASPx.SetAbsoluteX(keyTipElement, coordinates.left);
  ASPx.SetElementVisibility(keyTipElement, true); 
 },
 calculateCoordinates: function (accessKey, keyTipElement, popupElement) {
  var top = ASPx.GetAbsolutePositionY(popupElement);
  var left = ASPx.GetAbsolutePositionX(popupElement);
  if (accessKey.popupItem.getAccessKeyPosition)
   switch (accessKey.popupItem.getAccessKeyPosition()) {
    case "AboveRight":
     left = left + popupElement.offsetWidth - keyTipElement.offsetWidth / 3;
     top = top - keyTipElement.offsetHeight / 2;
     break;
    case "Right":
     left = left + popupElement.offsetWidth - keyTipElement.offsetWidth / 3;
     top = top + popupElement.offsetHeight / 2 - keyTipElement.offsetHeight / 2;
     break;
    case "BelowRight":
     left = left + popupElement.offsetWidth - keyTipElement.offsetWidth / 3;
     top = top + keyTipElement.offsetHeight / 2;
     break;
    default:
     top = top + popupElement.offsetHeight;
     left = left + popupElement.offsetWidth / 2 - keyTipElement.offsetWidth / 2;
     break;
   }
  else {
   top = top + popupElement.offsetHeight;
   left = left + popupElement.offsetWidth / 2 - keyTipElement.offsetWidth / 2;
  }
  return { top: top, left: left };
 },
 hide: function() {
  if (this.keyTipElement)
   ASPx.SetElementVisibility(this.keyTipElement, false);
 },
 hideChildAccessKeys: function () {
  this.hideAccessKeys(this.accessKeys);
 },
 hideAccessKeys: function (accessKeys) {
  if (accessKeys) {
   for (var i = 0, accessKey; accessKey = accessKeys[i]; i++) {
    if (accessKey.keyTipElement)
     accessKey.hide();
    accessKey.hideChildAccessKeys();
   }
  }
 },
 hideAll: function () {
  this.getRoot(this).hideChildAccessKeys();
 },
 getRoot: function (accessKey) {
  if (!accessKey.parent)
   return accessKey;
  return this.getRoot(accessKey.parent);
 }
});
var focusedElement = null;
function aspxOnElementFocused(evt) {
 evt = ASPx.Evt.GetEvent(evt);
 if(evt && evt.target)
  focusedElement = evt.target;
}
function _aspxInitializeFocus() {
 if(!ASPx.GetActiveElement())
  ASPx.Evt.AttachEventToDocument("focus", aspxOnElementFocused);
}
function _aspxGetFocusedElement() {
 var activeElement = ASPx.GetActiveElement();
 return activeElement ? activeElement : focusedElement;
}
CheckBoxCheckState = {
 Checked : "Checked",
 Unchecked : "Unchecked",
 Indeterminate : "Indeterminate"
};
CheckBoxInputKey = { 
 Checked : "C",
 Unchecked : "U",
 Indeterminate : "I"
};
var CheckableElementStateController = ASPx.CreateClass(null, {
 constructor: function(imageProperties) {
  this.checkBoxStates = [];
  this.imageProperties = imageProperties;
  this.customImageMarkerClassName = "dxcbCI";
 },
 GetValueByInputKey: function(inputKey) {
  return this.GetFirstValueBySecondValue("Value", "StateInputKey", inputKey);
 },
 GetInputKeyByValue: function(value) {
  return this.GetFirstValueBySecondValue("StateInputKey", "Value", value);
 },
 GetImagePropertiesNumByInputKey: function(value) {
  return this.GetFirstValueBySecondValue("ImagePropertiesNumber", "StateInputKey", value);
 },
 GetNextCheckBoxValue: function(currentValue, allowGrayed) {
  var currentInputKey = this.GetInputKeyByValue(currentValue);
  var nextInputKey = '';
  switch(currentInputKey) {
   case CheckBoxInputKey.Checked:
    nextInputKey = CheckBoxInputKey.Unchecked; break;
   case CheckBoxInputKey.Unchecked:
    nextInputKey = allowGrayed ? CheckBoxInputKey.Indeterminate : CheckBoxInputKey.Checked; break;
   case CheckBoxInputKey.Indeterminate:
    nextInputKey = CheckBoxInputKey.Checked; break;
  }
  return this.GetValueByInputKey(nextInputKey);
 },
 GetCheckStateByInputKey: function(inputKey) {
  switch(inputKey) {
   case CheckBoxInputKey.Checked: 
    return CheckBoxCheckState.Checked;
   case CheckBoxInputKey.Unchecked: 
    return CheckBoxCheckState.Unchecked;
   case CheckBoxInputKey.Indeterminate: 
    return CheckBoxCheckState.Indeterminate;
  }
 },
 GetValueByCheckState: function(checkState) {
  switch(checkState) {
   case CheckBoxCheckState.Checked: 
    return this.GetValueByInputKey(CheckBoxInputKey.Checked);
   case CheckBoxCheckState.Unchecked: 
    return this.GetValueByInputKey(CheckBoxInputKey.Unchecked);
   case CheckBoxCheckState.Indeterminate: 
    return this.GetValueByInputKey(CheckBoxInputKey.Indeterminate);
  }
 },
 GetFirstValueBySecondValue: function(firstValueName, secondValueName, secondValue) {
  return this.GetValueByFunc(firstValueName, 
   function(checkBoxState) { return checkBoxState[secondValueName] === secondValue; });
 },
 GetValueByFunc: function(valueName, func) {
  for(var i = 0; i < this.checkBoxStates.length; i++) {
   if(func(this.checkBoxStates[i]))
    return this.checkBoxStates[i][valueName];
  }  
 },
 AssignElementClassName: function(element, cssClassPropertyKey, disabledCssClassPropertyKey, assignedClassName) {
  var classNames = [ ];
  for(var i = 0; i < this.imageProperties[cssClassPropertyKey].length; i++) {
   classNames.push(this.imageProperties[disabledCssClassPropertyKey][i]);
   classNames.push(this.imageProperties[cssClassPropertyKey][i]);
  }
  var elementClassName = element.className;
  for(var i = 0; i < classNames.length; i++) {
   var className = classNames[i];
   var index = elementClassName.indexOf(className);
   if(index > -1)
    elementClassName = elementClassName.replace((index == 0 ? '' : ' ') + className, "");
  }
  elementClassName += " " + assignedClassName;
  element.className = elementClassName;
 },
 UpdateInternalCheckBoxDecoration: function(mainElement, inputKey, enabled) {
  var imagePropertiesNumber = this.GetImagePropertiesNumByInputKey(inputKey);
  for(var imagePropertyKey in this.imageProperties) {
   if(this.imageProperties.hasOwnProperty(imagePropertyKey)) {
    var propertyValue = this.imageProperties[imagePropertyKey][imagePropertiesNumber];
    propertyValue = propertyValue || !isNaN(propertyValue) ? propertyValue : "";
    switch(imagePropertyKey) {
     case "0" : mainElement.title = propertyValue; break;
     case "1" : mainElement.style.width = propertyValue + (propertyValue != "" ? "px" : ""); break;
     case "2" : mainElement.style.height = propertyValue + (propertyValue != "" ? "px" : ""); break;
    }
    if(enabled) {
     switch(imagePropertyKey) {
      case "3" : this.SetImageSrc(mainElement, propertyValue); break;
      case "4" : 
       this.AssignElementClassName(mainElement, "4", "8", propertyValue);
       break;
      case "5" : this.SetBackgroundPosition(mainElement, propertyValue, true); break;
      case "6" : this.SetBackgroundPosition(mainElement, propertyValue, false); break;
     }
    } else {
     switch(imagePropertyKey) {
      case "7" : this.SetImageSrc(mainElement, propertyValue); break;
      case "8" : 
       this.AssignElementClassName(mainElement, "4", "8", propertyValue);
       break;
      case "9" : this.SetBackgroundPosition(mainElement, propertyValue, true); break;
      case "10" : this.SetBackgroundPosition(mainElement, propertyValue, false); break;
     }
    }
   }
  }
 },
 SetImageSrc: function(mainElement, src) {
  if(src === ""){
   mainElement.style.backgroundImage = "";
   mainElement.style.backgroundPosition = "";
   ASPx.RemoveClassNameFromElement(mainElement, this.customImageMarkerClassName);
  }
  else{
   mainElement.style.backgroundImage = "url('" + src + "')";
   this.SetBackgroundPosition(mainElement, 0, true);
   this.SetBackgroundPosition(mainElement, 0, false);
   ASPx.AddClassNameToElement(mainElement, this.customImageMarkerClassName);
  }
 },
 SetBackgroundPosition: function(element, value, isX) {
  if(value === "") {
   element.style.backgroundPosition = value;
   return;
  }
  if(element.style.backgroundPosition === "")
   element.style.backgroundPosition = isX ? "-" + value.toString() + "px 0px" : "0px -" + value.toString() + "px";
  else {
   var position = element.style.backgroundPosition.split(' ');
   element.style.backgroundPosition = isX ? '-' + value.toString() + "px " + position[1] :  position[0] + " -" + value.toString() + "px";
  }
 },
 AddState: function(value, stateInputKey, imagePropertiesNumber) {
  this.checkBoxStates.push({
   "Value" : value, 
   "StateInputKey" : stateInputKey, 
   "ImagePropertiesNumber" : imagePropertiesNumber
  });
 },
 GetAriaCheckedValue: function(state) {
  switch(state) {
   case ASPx.CheckBoxCheckState.Checked: return "true";
   case ASPx.CheckBoxCheckState.Unchecked: return "false";
   case ASPx.CheckBoxCheckState.Indeterminate: return "mixed";
   default: return "";
  }
 },
 GetAriaSelectedValue: function(state) {
  switch(state) {
   case ASPx.CheckBoxCheckState.Checked: return "true";
   case ASPx.CheckBoxCheckState.Unchecked: return "false";
   case ASPx.CheckBoxCheckState.Indeterminate: return "undefined";
   default: return "";
  }
 },
 SetAriaCheckedSelectedAttributes: function(mainElement, state) {
  if(mainElement.attributes["aria-checked"] !== undefined) {
   var ariaCheckedValue = this.GetAriaCheckedValue(state);
   mainElement.setAttribute("aria-checked", ariaCheckedValue);
  }
  if(mainElement.attributes["aria-selected"] !== undefined) {
   var ariaSelectedValue = this.GetAriaSelectedValue(state);
   mainElement.setAttribute("aria-selected", ariaSelectedValue);
  }
 }
});
CheckableElementStateController.Create = function(imageProperties, valueChecked, valueUnchecked, valueGrayed, allowGrayed) {
 var stateController = new CheckableElementStateController(imageProperties);
 stateController.AddState(valueChecked, CheckBoxInputKey.Checked, 0);
 stateController.AddState(valueUnchecked, CheckBoxInputKey.Unchecked, 1);
 if(typeof(valueGrayed) != "undefined")
  stateController.AddState(valueGrayed, CheckBoxInputKey.Indeterminate, allowGrayed ? 2 : 1);
 stateController.allowGrayed = allowGrayed;
 return stateController;
};
var CheckableElementHelper = ASPx.CreateClass(null, {
 InternalCheckBoxInitialize: function(internalCheckBox) {
  this.AttachToMainElement(internalCheckBox);
  this.AttachToInputElement(internalCheckBox);
 },
 AttachToMainElement: function(internalCheckBox) {
  var instance = this;
  if(internalCheckBox.mainElement) {
    var toggleEvent = internalCheckBox.displaySwitch ? ASPx.TouchUIHelper.touchMouseDownEventName : "click";
    ASPx.Evt.AttachEventToElement(internalCheckBox.mainElement, toggleEvent,
    function (evt) {
     if(ASPx.Evt.IsRightButtonPressed(evt))
      return;
     instance.InvokeClick(internalCheckBox, evt);
     if(!internalCheckBox.disableCancelBubble)
      return ASPx.Evt.PreventEventAndBubble(evt);
    }
   );
   ASPx.Evt.AttachEventToElement(internalCheckBox.mainElement, "mousedown",
    function (evt) {
     internalCheckBox.Refocus();
    }
   );
   ASPx.Evt.PreventElementDragAndSelect(internalCheckBox.mainElement, true);
  }
 },
 AttachToInputElement: function(internalCheckBox) {
  var instance = this;
  if(internalCheckBox.inputElement && internalCheckBox.mainElement) {
   var checkableElement = internalCheckBox.accessibilityCompliant ? internalCheckBox.mainElement : internalCheckBox.inputElement;
   ASPx.Evt.AttachEventToElement(checkableElement, "focus",
    function (evt) { 
     if(!internalCheckBox.enabled)
      checkableElement.blur();
     else
      internalCheckBox.OnFocus();
    }
   );
   ASPx.Evt.AttachEventToElement(checkableElement, "blur", 
    function (evt) { 
     internalCheckBox.OnLostFocus();
    }
   );
   ASPx.Evt.AttachEventToElement(checkableElement, "keyup",
    function (evt) { 
     if(ASPx.Evt.GetKeyCode(evt) == ASPx.Key.Space)
      instance.InvokeClick(internalCheckBox, evt);
    }
   );
   ASPx.Evt.AttachEventToElement(checkableElement, "keydown",
    function (evt) { 
     if(ASPx.Evt.GetKeyCode(evt) == ASPx.Key.Space)
      return ASPx.Evt.PreventEvent(evt);
    }
   );
  }
 },
 IsKBSInputWrapperExist: function() {
  return ASPx.Browser.Opera || ASPx.Browser.WebKitFamily;
 },
 GetICBMainElementByInput: function(icbInputElement) {
  return this.IsKBSInputWrapperExist() ? icbInputElement.parentNode.parentNode : icbInputElement.parentNode;
 },
 RequirePreventFocus: function() { return false; },
 InvokeClick: function(internalCheckBox, evt) {
  if(internalCheckBox.enabled && !internalCheckBox.GetReadOnly()) {
   var inputElementValue = internalCheckBox.inputElement.value;
   var focusableElement = internalCheckBox.accessibilityCompliant ? internalCheckBox.mainElement : internalCheckBox.inputElement; 
   if(!this.RequirePreventFocus())
    focusableElement.focus();
   if(!ASPx.Browser.IE) 
    internalCheckBox.inputElement.value = inputElementValue;
   this.InvokeClickCore(internalCheckBox, evt);
   }
 },
 InvokeClickCore: function(internalCheckBox, evt) {
  internalCheckBox.OnClick(evt);
 }
});
CheckableElementHelper.Instance = new CheckableElementHelper();
var CheckBoxInternal = ASPx.CreateClass(null, {
 constructor: function(inputElement, stateController, allowGrayed, allowGrayedByClick, helper, container, storeValueInInput, key, disableCancelBubble,
  accessibilityCompliant, displaySwitch) {
  this.inputElement = inputElement;
  this.mainElement = helper.GetICBMainElementByInput(this.inputElement);
  this.name = (key ? key : this.inputElement.id) + CheckBoxInternal.GetICBMainElementPostfix();
  this.mainElement.id = this.name;
  this.stateController = stateController;
  this.container = container;
  this.allowGrayed = allowGrayed;
  this.allowGrayedByClick = allowGrayedByClick;
  this.autoSwitchEnabled = true;
  this.displaySwitch = displaySwitch;
  this.storeValueInInput = !!storeValueInInput;
  this.storedInputKey = !this.storeValueInInput ? this.inputElement.value : null;
  this.disableCancelBubble = !!disableCancelBubble;
  this.accessibilityCompliant = accessibilityCompliant;
  this.focusDecoration = null;
  this.focused = false;
  this.focusLocked = false;
  this.enabled = !this.mainElement.className.match(/dxWeb_\w+Disabled(\b|_)/);
  this.readOnly = false;
  this.preventFocus = helper.RequirePreventFocus();
  this.CheckedChanged = new ASPxClientEvent();
  this.Focus = new ASPxClientEvent();
  this.LostFocus = new ASPxClientEvent();
  helper.InternalCheckBoxInitialize(this);
 },
 GetReadOnly: function() {
  return this.readOnly;
 },
 ChangeInputElementTabIndex: function() {  
  var changeMethod = this.enabled ? ASPx.Attr.RestoreTabIndexAttribute : ASPx.Attr.SaveTabIndexAttributeAndReset;
  changeMethod(this.inputElement);
 },
 CreateFocusDecoration: function(focusedStyle) {
   this.focusDecoration = new FocusedStyleDecoration(this);
   this.focusDecoration.AddStyle('F', focusedStyle[0], focusedStyle[1]);
   this.focusDecoration.AddPostfix("");
 },
 UpdateFocusDecoration: function() {
  this.focusDecoration.Update();
 },  
 StoreInputKey: function(inputKey) {
  if(this.storeValueInInput)
   this.inputElement.value = inputKey;
  else
   this.storedInputKey = inputKey;
 },
 GetStoredInputKey: function() {
  if(this.storeValueInInput)
   return this.inputElement.value;
  else
   return this.storedInputKey;
 },
 OnClick: function(e) {
  if(this.autoSwitchEnabled) {
   var currentValue = this.GetValue();
   var value = this.stateController.GetNextCheckBoxValue(currentValue, this.allowGrayedByClick && this.allowGrayed);
   this.SetValue(value);
  }
  this.CheckedChanged.FireEvent(this, e);
 },
 OnFocus: function() {
  if(!this.IsFocusLocked()) {
   this.focused = true;
   this.UpdateFocusDecoration();
   this.Focus.FireEvent(this, null);
  } else
   this.UnlockFocus();
 },
 OnLostFocus: function() {
  if(!this.IsFocusLocked()) {
   this.focused = false;
   this.UpdateFocusDecoration();
   this.LostFocus.FireEvent(this, null);
  }
 },
 Refocus: function() {
  if(this.preventFocus) return;
  if(this.focused) {
   this.LockFocus();
   this.inputElement.blur();
   if(ASPx.Browser.MacOSMobilePlatform) {
    window.setTimeout(function() {
     ASPx.SetFocus(this.inputElement);
    }, ASPx.FOCUS_TIMEOUT);
   } else {
    ASPx.SetFocus(this.inputElement);
   }
  }
 },
 LockFocus: function() {
  this.focusLocked = true;
 },
 UnlockFocus: function() {
  this.focusLocked = false;
 },
 IsFocusLocked: function() {
  if(!!ASPx.Attr.GetAttribute(this.mainElement, ASPx.Attr.GetTabIndexAttributeName()))
   return false;
  return this.focusLocked;
 },
 SetValue: function(value, force) {
  var currentValue = this.GetValue();
  if(currentValue !== value || force) {
   var newInputKey = this.stateController.GetInputKeyByValue(value);
   if(newInputKey) {
    this.StoreInputKey(newInputKey);   
    this.stateController.UpdateInternalCheckBoxDecoration(this.mainElement, newInputKey, this.enabled);
   }
  }
  if(this.accessibilityCompliant) {
   var state = this.GetCurrentCheckState();
   this.stateController.SetAriaCheckedSelectedAttributes(this.mainElement, state);
  }
 },
 GetValue: function() {
  return this.stateController.GetValueByInputKey(this.GetCurrentInputKey());
 },
 GetCurrentCheckState: function() {
  return this.stateController.GetCheckStateByInputKey(this.GetCurrentInputKey());
 },
 GetCurrentInputKey: function() {
  return this.GetStoredInputKey();
 },
 GetChecked: function() {
  return this.GetCurrentInputKey() === CheckBoxInputKey.Checked;
 },
 SetChecked: function(checked) {
  var newValue = this.stateController.GetValueByCheckState(checked ? CheckBoxCheckState.Checked : CheckBoxCheckState.Unchecked);
  this.SetValue(newValue);
 },
 SetEnabled: function(enabled) {
  if(this.enabled != enabled) {
   this.enabled = enabled;
   this.stateController.UpdateInternalCheckBoxDecoration(this.mainElement, this.GetCurrentInputKey(), this.enabled);
   this.ChangeInputElementTabIndex();
  }
 },
 GetEnabled: function() {
  return this.enabled;
 }
});
CheckBoxInternal.GetICBMainElementPostfix = function() {
 return "_D";
};
var CheckBoxInternalCollection = ASPx.CreateClass(CollectionBase, {
 constructor: function(imageProperties, allowGrayed, storeValueInInput, helper, disableCancelBubble, accessibilityCompliant) {
  this.constructor.prototype.constructor.call(this);
  this.stateController = allowGrayed 
   ? CheckableElementStateController.Create(imageProperties, CheckBoxInputKey.Checked, CheckBoxInputKey.Unchecked, CheckBoxInputKey.Indeterminate, true)
   : CheckableElementStateController.Create(imageProperties, CheckBoxInputKey.Checked, CheckBoxInputKey.Unchecked);
  this.helper = helper || CheckableElementHelper.Instance;
  this.storeValueInInput = !!storeValueInInput;
  this.disableCancelBubble = !!disableCancelBubble;
  this.accessibilityCompliant = accessibilityCompliant;
 },
 Add: function(key, inputElement, container) {
  this.Remove(key);
  var checkBox = this.CreateInternalCheckBox(key, inputElement, container);
  CollectionBase.prototype.Add.call(this, key, checkBox);
  return checkBox;
 },
 SetImageProperties: function(imageProperties) {
  this.stateController.imageProperties = imageProperties;
 },
 CreateInternalCheckBox: function(key, inputElement, container) {
  return new CheckBoxInternal(inputElement, this.stateController, this.stateController.allowGrayed, false, this.helper, container, 
   this.storeValueInInput, key, this.disableCancelBubble, this.accessibilityCompliant);
 }
});
var FocusedStyleDecoration = ASPx.CreateClass(null, {
 constructor: function(editor) {
  this.editor = editor;
  this.postfixList = [];
  this.styles = {};
  this.innerStyles = {};
 },
 AddPostfix: function(value) {
  this.postfixList.push(value);
 },
 AddStyle: function(key, className, cssText) {
  this.styles[key] = this.CreateRule(className, cssText);
  this.innerStyles[key] = this.CreateRule("", this.FilterInnerCss(cssText));
 },
 CreateRule: function(className, cssText) {
  return ASPx.Str.Trim(className + " " + ASPx.CreateImportantStyleRule(this.GetStyleSheet(), cssText));
 },
 GetStyleSheet: function() {
  return ASPx.GetCurrentStyleSheet();
 },
 FilterInnerCss: function(css) {
  return css.replace(/(border|background-image)[^:]*:[^;]+/gi, "");
 },
 Update: function() {
  for(var i = 0; i < this.postfixList.length; i++) {
   var postfix = this.postfixList[i];
   var inner = postfix.length > 0;
   var element = this.GetElementByPostfix(postfix);
   if(element)
    this.ApplyStyles(element, inner);
  }
 },
 GetElementByPostfix: function(postfix) {
  return ASPx.GetElementById(this.editor.name + postfix);
 },
 ApplyStyles: function(element, inner) {
  this.ApplyFocusedStyle(element, inner);
 },
 ApplyFocusedStyle: function(element, inner) {
  if(this.HasDecoration("F"))
   this.ApplyDecoration("F", element, inner, this.editor.focused);
 },
 HasDecoration: function(key) {
  return !!this.styles[key];
 },
 ApplyDecoration: function(key, element, inner, active) {
  var value = inner ? this.innerStyles[key] : this.styles[key];
  this.RemoveDecoration(element, value);
  if(active) {
   ASPx.AddClassNameToElement(element, value);
   if(ASPx.Browser.IE && ASPx.Browser.Version > 10 && element.border != null) 
    this.EnsureElementBorder(element);
  }
 },
 RemoveDecoration: function(element, value) {
  ASPx.RemoveClassNameFromElement(element, value);
  if(ASPx.Browser.IE && ASPx.Browser.MajorVersion >= 11)
   var dummy = element.offsetWidth; 
 },
 ApplyDecorationCore: function() {
 },
 EnsureElementBorder: function(element) {
  var border = parseInt(element.border) || 0;
  element.border = 1;
  element.border = border;
 }
});
var EditorStyleDecoration = ASPx.CreateClass(FocusedStyleDecoration, {
 constructor: function(editor) {
  this.constructor.prototype.constructor.call(this, editor);
  this.lockUpdate = false;
 },
 LockUpdate: function() {
  this.lockUpdate = true;
 },
 UnlockUpdate: function() {
  this.lockUpdate = false;
 },
 IsUpdateLocked: function() {
  return this.lockUpdate;
 },
 Update: function () {
  if(this.IsUpdateLocked())
   return;
  ASPx.FocusedStyleDecoration.prototype.Update.call(this);
 },
 ApplyStyles: function (element, inner) {
  this.ApplyInvalidStyle(element, inner);
  ASPx.FocusedStyleDecoration.prototype.ApplyStyles.call(this, element, inner);
 },
 ApplyInvalidStyle: function (element, inner) {
  if(this.HasDecoration("I")) {
   var isValid = this.editor.GetIsValid();
   this.ApplyDecoration("I", element, inner, !isValid);
  }
 }
});
var TextEditorStyleDecoration = ASPx.CreateClass(EditorStyleDecoration, {
 constructor: function(editor) {
  this.constructor.prototype.constructor.call(this, editor);
  this.nullTextClassName = "";
 },
 ApplyStyles: function(element, inner) {
  ASPx.EditorStyleDecoration.prototype.ApplyStyles.call(this, element, inner);
  this.ApplyNullTextStyle(element, inner);
 },
 ApplyNullTextStyle: function(element, inner) {
  if(!this.HasDecoration("N"))
   return;
  var apply = !this.editor.focused && this.editor.CanApplyNullTextDecoration();
  this.EnsureSpellcheckAttribute(element, apply);
  this.ApplyDecoration("N", element, inner, apply);
 },
 EnsureSpellcheckAttribute: function(element, apply) {
  if(apply)
   ASPx.Attr.ChangeAttribute(element, "spellcheck", "false");
  else
   ASPx.Attr.RestoreAttribute(element, "spellcheck");
 },
 ApplyNullTextClassName: function(active) {
  var nullTextClassName = this.GetNullTextClassName();
  var editorMainElement = this.editor.GetMainElement();
  if(active)
   ASPx.AddClassNameToElement(editorMainElement, nullTextClassName);
  else
   ASPx.RemoveClassNameFromElement(editorMainElement, nullTextClassName);
 },
 GetNullTextClassName: function() {
  if (!this.nullTextClassName)
   this.InitializeNullTextClassName();
  return this.nullTextClassName;
 },
 InitializeNullTextClassName: function() {
  var nullTextStyle = this.styles["N"];
  if (nullTextStyle) {
   var nullTextStyleClassNames = nullTextStyle.split(" ");
   for (var i = 0; i < nullTextStyleClassNames.length; i++)
    if (nullTextStyleClassNames[i].match("dxeNullText"))
     this.nullTextClassName = nullTextStyleClassNames[i];
  }
 }
});
var TouchUIHelper = {
 isGesture: false,
 isMouseEventFromScrolling: false,
 isNativeScrollingAllowed: true,
 clickSensetivity: 10,
 documentTouchHandlers: {},
 documentEventAttachingAllowed: true,
 msTouchDraggableClassName: "dxMSTouchDraggable",
 touchMouseDownEventName: ASPx.Browser.WebKitTouchUI ? "touchstart" : (ASPx.Browser.Edge && ASPx.Browser.MSTouchUI && window.PointerEvent ? "pointerdown" : "mousedown"),
 touchMouseUpEventName:   ASPx.Browser.WebKitTouchUI ? "touchend"   : (ASPx.Browser.Edge && ASPx.Browser.MSTouchUI && window.PointerEvent ? "pointerup" : "mouseup"),
 touchMouseMoveEventName: ASPx.Browser.WebKitTouchUI ? "touchmove"  : (ASPx.Browser.Edge && ASPx.Browser.MSTouchUI && window.PointerEvent ? "pointermove" : "mousemove"),
 isTouchEvent: function(evt) {
  if(!evt) return false;
  return ASPx.Browser.WebKitTouchUI && ASPx.IsExists(evt.changedTouches); 
 },
 isTouchEventName: function(eventName) {
  return ASPx.Browser.WebKitTouchUI && (eventName.indexOf("touch") > -1 || eventName.indexOf("gesture") > -1);
 },
 getEventX: function(evt) {
  if(ASPx.Browser.IE)
   return evt.pageX;
  var touchPoint = null;
  if(evt.changedTouches.length > 0)
   touchPoint = evt.changedTouches;
  else if(evt.targetTouches.length > 0)
   touchPoint = evt.targetTouches;
  return touchPoint ? touchPoint[0].pageX : 0;
 },
 getEventY: function(evt) { 
  if(ASPx.Browser.IE)
   return evt.pageY;
  var touchPoint = null;
  if(evt.changedTouches.length > 0)
   touchPoint = evt.changedTouches;
  else if(evt.targetTouches.length > 0)
   touchPoint = evt.targetTouches;
  return touchPoint ? touchPoint[0].pageY : 0;
 },
 getWebkitMajorVersion: function(){
  if(!this.webkitMajorVersion){
   var regExp = new RegExp("applewebkit/(\\d+)", "i");
   var matches = regExp.exec(ASPx.Browser.UserAgent);
   if(matches && matches.index >= 1)
    this.webkitMajorVersion = matches[1];
  }
  return this.webkitMajorVersion;
 },
 getIsLandscapeOrientation: function(){
  if(ASPx.Browser.MacOSMobilePlatform || ASPx.Browser.AndroidMobilePlatform)
   return Math.abs(window.orientation) == 90;
  return ASPx.GetDocumentClientWidth() > ASPx.GetDocumentClientHeight();
 },
 nativeScrollingSupported: function() {
  var allowedSafariVersion = ASPx.Browser.Version >= 5.1 && ASPx.Browser.Version < 8; 
  var webkitMajorVersion = this.getWebkitMajorVersion();
  var allowedWebKitVersion = webkitMajorVersion > 533 && webkitMajorVersion < 600;
  return (ASPx.Browser.MacOSMobilePlatform && (allowedSafariVersion || allowedWebKitVersion))
   || (ASPx.Browser.AndroidMobilePlatform && ASPx.Browser.PlaformMajorVersion >= 3) || (ASPx.Browser.MSTouchUI && (!ASPx.Browser.WindowsPhonePlatform || !ASPx.Browser.IE));
 },
 makeScrollableIfRequired: function(element, options) {
  if(ASPx.Browser.WebKitTouchUI && element) {
   var overflow = ASPx.GetCurrentStyle(element).overflow;
   if(element.tagName == "DIV" &&  overflow != "hidden" && overflow != "visible" ){
    return this.MakeScrollable(element);
   }
  }
 },
 preventScrollOnEvent: function(evt){
 },
 handleFastTapIfRequired: function(evt, action, preventCommonClickEvents) {
  if(ASPx.Browser.WebKitTouchUI && evt.type == 'touchstart' && action) {
   this.FastTapHelper.HandleFastTap(evt, action, preventCommonClickEvents);
   return true;
  }
  return false;
 },
 ensureDocumentSizesCorrect: function (){
  return (document.documentElement.clientWidth - document.documentElement.clientHeight) / (screen.width - screen.height) > 0;
 },
 ensureOrientationChanged: function(onOrientationChangedFunction){
  if(ASPxClientUtils.iOSPlatform || this.ensureDocumentSizesCorrect())
   onOrientationChangedFunction();
  else {
   window.setTimeout(function(){
    this.ensureOrientationChanged(onOrientationChangedFunction);
   }.aspxBind(this), 100);
  }
 },
 onEventAttachingToDocument: function(eventName, func){
  if(ASPx.Browser.MacOSMobilePlatform && this.isTouchEventName(eventName)) {
   if(!this.documentTouchHandlers[eventName])
    this.documentTouchHandlers[eventName] = [];
   this.documentTouchHandlers[eventName].push(func);
   return this.documentEventAttachingAllowed;
  }
  return true;
 },
 onEventDettachedFromDocument: function(eventName, func){
  if(ASPx.Browser.MacOSMobilePlatform && this.isTouchEventName(eventName)) {
   var handlers = this.documentTouchHandlers[eventName];
   if(handlers)
    ASPx.Data.ArrayRemove(handlers, func);
  }
 },
 processDocumentTouchEventHandlers: function(proc) {
  var touchEventNames = ["touchstart", "touchend", "touchmove", "gesturestart", "gestureend"];
  for(var i = 0; i < touchEventNames.length; i++) {
   var eventName = touchEventNames[i];
   var handlers = this.documentTouchHandlers[eventName];
   if(handlers) {
    for(var j = 0; j < handlers.length; j++) {
     proc(eventName,handlers[j]);
    }
   }
  }
 },
 removeDocumentTouchEventHandlers: function() {
  if(ASPx.Browser.MacOSMobilePlatform) {
   this.documentEventAttachingAllowed = false;
   this.processDocumentTouchEventHandlers(ASPx.Evt.DetachEventFromDocumentCore);
  }
 },
 restoreDocumentTouchEventHandlers: function () {
  if(ASPx.Browser.MacOSMobilePlatform) {
   this.documentEventAttachingAllowed = true;
   this.processDocumentTouchEventHandlers(ASPx.Evt.AttachEventToDocumentCore);
  }
 },
 IsNativeScrolling: function() {
  return TouchUIHelper.nativeScrollingSupported() && TouchUIHelper.isNativeScrollingAllowed;
 },
 pointerEnabled: !!(window.PointerEvent || window.MSPointerEvent),
 pointerDownEventName: window.PointerEvent ? "pointerdown" : "MSPointerDown",
 pointerUpEventName: window.PointerEvent ? "pointerup" : "MSPointerUp",
 pointerCancelEventName: window.PointerEvent ? "pointercancel" : "MSPointerCancel",
 pointerMoveEventName: window.PointerEvent ? "pointermove" : "MSPointerMove",
 pointerOverEventName: window.PointerEvent ? "pointerover" : "MSPointerOver",
 pointerOutEventName: window.PointerEvent ? "pointerout" : "MSPointerOut",
 pointerType: {
  Touch: (ASPx.Browser.IE && ASPx.Browser.Version == 10) ? 2 : "touch",
  Pen: (ASPx.Browser.IE && ASPx.Browser.Version == 10) ? 3 : "pen",
  Mouse: (ASPx.Browser.IE && ASPx.Browser.Version == 10) ? 4 : "mouse"
 },
 msGestureEnabled: !!(window.PointerEvent || window.MSPointerEvent) && typeof(MSGesture) != "undefined",
 msTouchCreateGesturesWrapper: function(element, onTap){
  if(!TouchUIHelper.msGestureEnabled) 
   return;
  var gesture = new MSGesture();
  gesture.target = element;
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.pointerDownEventName, function(evt){
   gesture.addPointer(evt.pointerId);
  });
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.pointerUpEventName, function(evt){
   gesture.stop();
  });
  if(onTap)
   ASPx.Evt.AttachEventToElement(element, "MSGestureTap", onTap);
  return gesture;
 },
 useLongTapHelper: function () {
  return ASPx.Browser.Safari && ASPx.Browser.TouchUI;
 },
 attachLongTapHandler: function(element, handler, onlyBubbling) {
  var timerID = -1;
  var timeout = 1000;
  var event = null;
  var preventClickEvent = false;
  var startX = -1;
  var startY = -1;
  var pixelLimit = 5;
  function onTouchMouseDown(evt) {
   abortWating();
   event = evt;
   startX = evt.pageX;
   startY = evt.pageY;
   preventClickEvent = false;
   timerID = window.setTimeout(onTimeout, timeout);
  }
  function onTouchMouseMove(evt) {
   if (!isUnderTouch())
    return;
   var shiftX = Math.abs(startX - evt.pageX),
    shiftY = Math.abs(startY - evt.pageY),
    maxShift = Math.max(shiftX, shiftY);
   if (maxShift > pixelLimit)
    abortWating();
  }
  function onTouchMouseUp(evt) {
   abortWating();
   if (preventClickEvent) {
    ASPx.Evt.PreventEventAndBubble(evt);
    preventClickEvent = false;
   }
  }
  function onTimeout() {
   handler(event);
   preventClickEvent = true;
   abortWatingInternal();
  }
  function isUnderTouch() {
   return timerID !== -1;
  }
  function abortWating() {
   if (isUnderTouch()) {
    window.clearTimeout(timerID);
    abortWatingInternal();
   }
  }
  function abortWatingInternal() {
   timerID = -1;
   event = null;
  }
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.touchMouseDownEventName, onTouchMouseDown, onlyBubbling);
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.touchMouseMoveEventName, onTouchMouseMove, onlyBubbling);
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.touchMouseUpEventName, onTouchMouseUp, onlyBubbling);
  element.style["-webkit-user-select"] = "none";
  return function () {
   ASPx.Evt.DetachEventFromElement(element, TouchUIHelper.touchMouseDownEventName, onTouchMouseDown);
   ASPx.Evt.DetachEventFromElement(element, TouchUIHelper.touchMouseMoveEventName, onTouchMouseMove);
   ASPx.Evt.DetachEventFromElement(element, TouchUIHelper.touchMouseUpEventName, onTouchMouseUp);
   element.style["-webkit-user-select"] = "";
  };
 }
};
var CacheHelper = {};
CacheHelper.GetCachedValueCore = function(obj, key, func, cacheObj, fillValueMethod) {
 if(!cacheObj)
  cacheObj = obj;
 if(!cacheObj.cache)
  cacheObj.cache = {};
 if(!key) 
  key = "default";
 fillValueMethod(obj, key, func, cacheObj);
 return cacheObj.cache[key];
};
CacheHelper.GetCachedValue = function(obj, key, func, cacheObj) {
 return CacheHelper.GetCachedValueCore(obj, key, func, cacheObj, 
  function(obj, key, func, cacheObj) {
   if(!ASPx.IsExists(cacheObj.cache[key]))
    cacheObj.cache[key] = func.apply(obj, []);
  });
};
CacheHelper.GetCachedElement = function(obj, key, func, cacheObj) {
 return CacheHelper.GetCachedValueCore(obj, key, func, cacheObj, 
  function(obj, key, func, cacheObj) {
   if(!ASPx.IsValidElement(cacheObj.cache[key]))
    cacheObj.cache[key] = func.apply(obj, []);
  });
};
CacheHelper.GetCachedElements = function(obj, key, func, cacheObj) {
 return CacheHelper.GetCachedValueCore(obj, key, func, cacheObj, 
  function(obj, key, func, cacheObj) {
   if(!ASPx.IsValidElements(cacheObj.cache[key])){
    var elements = func.apply(obj, []);
    if(!Ident.IsArray(elements))
     elements = [elements];
    cacheObj.cache[key] = elements;
   }
  });
};
CacheHelper.GetCachedElementById = function(obj, id, cacheObj) {
 return CacheHelper.GetCachedElement(obj, id, function() { return ASPx.GetElementById(id); }, cacheObj);
};
CacheHelper.GetCachedChildById = function(obj, parent, id, cacheObj) {
 return CacheHelper.GetCachedElement(obj, id, function() { return ASPx.GetChildById(parent, id); }, cacheObj);
};
CacheHelper.DropCachedValue = function(cacheObj, key) {
 cacheObj.cache[key] = null;
};  
CacheHelper.DropCache = function(cacheObj) {
 cacheObj.cache = null;
};  
var DomObserver = ASPx.CreateClass(null, {
 constructor: function() {
  this.items = { };
 },
 subscribe: function(elementID, callbackFunc) {
  var item = this.items[elementID];
  if(item)
   this.unsubscribe(elementID);
  item = {
   elementID: elementID,
   callbackFunc: callbackFunc,
   pauseCount: 0
  };
  this.prepareItem(item);
  this.items[elementID] = item;
 },
 prepareItem: function(item) {
 },
 unsubscribe: function(elementID) {
  this.items[elementID] = null;
 },
 getItemElement: function(item) {
  var element = this.getElementById(item.elementID);
  if(element)
   return element;
  this.unsubscribe(item.elementID);
  return null;
 },
 getElementById: function(elementID) {
  var element = document.getElementById(elementID);
  return element && ASPx.IsValidElement(element) ? element : null;
 },
 pause: function(element, includeSubtree) {
  this.changeItemsState(element, includeSubtree, true);
 },
 resume: function(element, includeSubtree) {
  this.changeItemsState(element, includeSubtree, false);
 },
 forEachItem: function(processFunc, context) {
  context = context || this;
  for(var itemName in this.items) {
   if(!this.items.hasOwnProperty(itemName))
    continue;
   var item = this.items[itemName];
   if(item) {
    var needBreak = processFunc.call(context, item);
    if(needBreak)
     return;
   }
  }
 },
 changeItemsState: function(element, includeSubtree, pause) {
  this.forEachItem(function(item) {
   if(!element)
    this.changeItemState(item, pause);
   else {
    var itemElement = this.getItemElement(item);
    if(itemElement && (element == itemElement || (includeSubtree && ASPx.GetIsParent(element, itemElement)))) {
     this.changeItemState(item, pause);
     if(!includeSubtree)
      return true;
    }
   }
  }.aspxBind(this));
 },
 changeItemState: function(item, pause) {
  if(pause)
   this.pauseItem(item);
  else
   this.resumeItem(item);
 },
 pauseItem: function(item) {
  item.paused = true;
  item.pauseCount++;
 },
 resumeItem: function(item) {
  if(item.pauseCount > 0) {
   if(item.pauseCount == 1)
    item.paused = false;
   item.pauseCount--;
  }
 }
});
DomObserver.IsMutationObserverAvailable = function() {
 return !!window.MutationObserver;
};
var TimerObserver = ASPx.CreateClass(DomObserver, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.timerID = -1;
  this.observationTimeout = 300;
 },
 subscribe: function(elementID, callbackFunc) {
  DomObserver.prototype.subscribe.call(this, elementID, callbackFunc);
  if(!this.isActivated())
   this.startObserving();
 },
 isActivated: function() {
  return this.timerID !== -1;
 },
 startObserving: function() {
  if(this.isActivated())
   window.clearTimeout(this.timerID);
  this.timerID = window.setTimeout(this.onTimeout, this.observationTimeout);
 },
 onTimeout: function() {
  var observer = _aspxGetDomObserver();
  observer.doObserve();
  observer.startObserving();
 },
 doObserve: function() {
  if(!ASPx.documentLoaded) return;
  this.forEachItem(function(item) {
   if(!item.paused)
    this.doObserveForItem(item);
  }.aspxBind(this));
 },
 doObserveForItem: function(item) {
  var element = this.getItemElement(item);
  if(element)
   item.callbackFunc.call(this, element);
 }
});
var MutationObserver = ASPx.CreateClass(DomObserver, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.callbackTimeout = 10;
 },
 prepareItem: function(item) {
  item.callbackTimerID = -1;
  var target = this.getElementById(item.elementID);
  if(!target)
   return;
  var observerCallbackFunc = function() {
   if(item.callbackTimerID === -1) {
    var timeoutHander = function() {
     item.callbackTimerID = -1;
     item.callbackFunc.call(this, target);
    }.aspxBind(this);
    item.callbackTimerID = window.setTimeout(timeoutHander, this.callbackTimeout);
   }
  }.aspxBind(this);
  var observer = new window.MutationObserver(observerCallbackFunc);
  var config = { attributes: true, childList: true, characterData: true, subtree: true };
  observer.observe(target, config);
  item.observer = observer;
  item.config = config;
 },
 unsubscribe: function(elementID) {
  var item = this.items[elementID];
  if(item) {
   item.observer.disconnect();
   item.observer = null;
  }
  DomObserver.prototype.unsubscribe.call(this, elementID);
 },
 pauseItem: function(item) {
  DomObserver.prototype.pauseItem.call(this, item);
  item.observer.disconnect();
 },
 resumeItem: function(item) {
  DomObserver.prototype.resumeItem.call(this, item);
  if(!item.paused) {
   var target = this.getItemElement(item);
   if(target)
    item.observer.observe(target, item.config);
  }
 }
});
var domObserver = null;
function _aspxGetDomObserver() {
 if(domObserver == null)
  domObserver = DomObserver.IsMutationObserverAvailable() ? new MutationObserver() : new TimerObserver();
 return domObserver;
}
var ControlUpdateWatcher = ASPx.CreateClass(null, {
 constructor: function() {
  this.helpers = { };
  this.clearLockerTimerID = -1;
  this.clearLockerTimerDelay = 15;
  this.postProcessing = false;
  this.init();
 },
 init: function() {
  var postHandler = aspxGetPostHandler();
  postHandler.Post.AddHandler(this.OnPost, this);
 },
 Add: function(helper) {
  this.helpers[helper.GetName()] = helper;
 },
 CanSendCallback: function(dxCallbackOwner, arg) {
  this.LockConfirmOnBeforeWindowUnload();
  var modifiedHelpers = this.FilterModifiedHelpersByDXCallbackOwner(this.GetModifiedHelpers(), dxCallbackOwner, arg);
  if(modifiedHelpers.length === 0) return true;
  var modifiedHelpersInfo = this.GetToConfirmAndToResetLists(modifiedHelpers, dxCallbackOwner.name);
  if(!modifiedHelpersInfo) return true;
  if(modifiedHelpersInfo.toConfirm.length === 0) {
   this.ResetClientChanges(modifiedHelpersInfo.toReset);
   return true;
  }
  var helper = modifiedHelpersInfo.toConfirm[0];
  if(!confirm(helper.GetConfirmUpdateText()))
   return false;
  this.ResetClientChanges(modifiedHelpersInfo.toReset);
  return true;
 },
 OnPost: function(s, e) {
  if(this.isDxCallback(e))
   return;
  this.postProcessing = true;
  this.LockConfirmOnBeforeWindowUnload();
  var modifiedHelpersInfo = this.GetModifedHelpersInfo(e);
  if(!modifiedHelpersInfo)
   return;
  if(modifiedHelpersInfo.toConfirm.length === 0) {
   this.ResetClientChanges(modifiedHelpersInfo.toReset);
   return;
  }
  var helper = modifiedHelpersInfo.toConfirm[0];
  if(!confirm(helper.GetConfirmUpdateText())) {
   e.cancel = true;
   this.finishPostProcessing();
  }
  if(!e.cancel)
   this.ResetClientChanges(modifiedHelpersInfo.toReset);
 },
 isDxCallback: function(e) {
  return e.isDXCallback || this.isInternalUploadControlCallback();
 },
 isInternalUploadControlCallback: function() {
  var isInCallback = false;
  for(var key in this.helpers) {
   if(this.helpers.hasOwnProperty(key)) {
    var helper = this.helpers[key];
    isInCallback = isInCallback || helper.isInUploadCallback();
   }
  }
  return isInCallback;
 },
 finishPostProcessing: function() {
  this.postProcessing = false;
 },
 GetModifedHelpersInfo: function(e) {
  var modifiedHelpers = this.FilterModifiedHelpers(this.GetModifiedHelpers(), e);
  if(modifiedHelpers.length === 0) return;
  return this.GetToConfirmAndToResetLists(modifiedHelpers, e && e.ownerID);
 },
 GetToConfirmAndToResetLists: function(modifiedHelpers, ownerID) {
  var resetList = [ ];
  var confirmList = [ ];
  for(var i = 0; i < modifiedHelpers.length; i++) {
   var helper = modifiedHelpers[i];
   if(!helper.GetConfirmUpdateText()) { 
    resetList.push(helper);
    continue;
   }
   if(helper.CanShowConfirm(ownerID)) { 
    resetList.push(helper);
    confirmList.push(helper);
   }
  }
  return { toConfirm: confirmList, toReset: resetList };
 },
 FilterModifiedHelpers: function(modifiedHelpers, e) {
  if(modifiedHelpers.length === 0)
   return [ ];
  if(this.RequireProcessUpdatePanelCallback(e))
   return this.FilterModifiedHelpersByUpdatePanels(modifiedHelpers);
  if(this.postProcessing)
   return this.FilterModifiedHelpersByPostback(modifiedHelpers);
  return modifiedHelpers;
 },
 FilterModifiedHelpersByDXCallbackOwner: function(modifiedHelpers, dxCallbackOwner, arg) {
  var result = [ ];
  for(var i = 0; i < modifiedHelpers.length; i++) {
   var helper = modifiedHelpers[i];
   if(helper.NeedConfirmOnCallback(dxCallbackOwner, arg))
    result.push(helper);
  }
  return result;
 },
 FilterModifiedHelpersByUpdatePanels: function(modifiedHelpers) {
  var result = [ ];
  var updatePanels = this.GetUpdatePanelsWaitedForUpdate();
  for(var i = 0; i < updatePanels.length; i++) {
   var panelID = updatePanels[i].replace(/\$/g, "_");
   var panel = ASPx.GetElementById(panelID);
   if(!panel) continue;
   for(var j = 0; j < modifiedHelpers.length; j++) {
    var helper = modifiedHelpers[j];
    if(ASPx.GetIsParent(panel, helper.GetControlMainElement()))
     result.push(helper);
   }
  }
  return result;
 },
 FilterModifiedHelpersByPostback: function(modifiedHelpers) {
  var result = [ ];
  for(var i = 0; i < modifiedHelpers.length; i++) {
   var helper = modifiedHelpers[i];
   if(helper.NeedConfirmOnPostback())
    result.push(helper);
  }
  return result;
 },
 RequireProcessUpdatePanelCallback: function(e) {
  var rManager = this.GetMSRequestManager();
  if(rManager && e && e.isMSAjaxCallback)
   return rManager._postBackSettings.async;
  return false;
 },
 GetUpdatePanelsWaitedForUpdate: function() {
  var rManager = this.GetMSRequestManager();
  if(!rManager) return [ ];
  var panelUniqueIDs = rManager._postBackSettings.panelsToUpdate || [ ];
  var panelClientIDs = [ ];
  for(var i = 0; i < panelUniqueIDs.length; i++) {
   var index = ASPx.Data.ArrayIndexOf(rManager._updatePanelIDs, panelUniqueIDs[i]);
   if(index >= 0)
    panelClientIDs.push(rManager._updatePanelClientIDs[index]);
  }
  return panelClientIDs;
 },
 GetMSRequestManager: function() {
  return ASPx.GetMSAjaxRequestManager();
 },
 GetModifiedHelpers: function() {
  var result = [ ];
  for(var key in this.helpers) { 
   if(this.helpers.hasOwnProperty(key)) {
    var helper = this.helpers[key];
    if(helper.HasChanges())
     result.push(helper);
   }
  }
  return result;
 },
 ResetClientChanges: function(modifiedHelpers) {
  for(var i = 0; i < modifiedHelpers.length; i++)
   modifiedHelpers[i].ResetClientChanges();
 },
 GetConfirmUpdateMessage: function() {
  if(this.confirmOnWindowUnloadLocked) return;
  var modifiedHelpersInfo = this.GetModifedHelpersInfo();
  if(!modifiedHelpersInfo || modifiedHelpersInfo.toConfirm.length === 0) 
   return;
  var helper = modifiedHelpersInfo.toConfirm[0];
  return helper.GetConfirmUpdateText();
 },
 LockConfirmOnBeforeWindowUnload: function() {
  this.confirmOnWindowUnloadLocked = true;
  this.clearLockerTimerID = ASPx.Timer.ClearTimer(this.clearLockerTimerID);
  this.clearLockerTimerID = window.setTimeout(function() {
   this.confirmOnWindowUnloadLocked = false;
  }.aspxBind(this), this.clearLockerTimerDelay);
 },
 OnWindowBeforeUnload: function(e) {
  var confirmMessage = this.GetConfirmUpdateMessage();
  if(confirmMessage)
   e.returnValue = confirmMessage;
  this.finishPostProcessing();
  return confirmMessage;
 },
 OnWindowUnload: function(e) {
  if(this.confirmOnWindowUnloadLocked) return;
  var modifiedHelpersInfo = this.GetModifedHelpersInfo();
  if(!modifiedHelpersInfo) return;
  this.ResetClientChanges(modifiedHelpersInfo.toReset);
 },
 OnMouseDown: function(e) {
  if(ASPx.Browser.IE)
   this.PreventBeforeUnloadOnLinkClick(e);
 },
 OnFocusIn: function(e) {
  if(ASPx.Browser.IE)
   this.PreventBeforeUnloadOnLinkClick(e);
 },
 PreventBeforeUnloadOnLinkClick: function(e) {
  if(ASPx.GetObjectKeys(this.helpers).length == 0)
   return;
  var link = ASPx.GetParentByTagName(ASPx.Evt.GetEventSource(e), "A");
  if(!link || link.dxgvLinkClickHanlderAssigned)
   return;
  var url = ASPx.Attr.GetAttribute(link, "href");
  if(!url || url.indexOf("javascript:") < 0)
   return;
  ASPx.Evt.AttachEventToElement(link, "click", function(ev) { return ASPx.Evt.PreventEvent(ev); });
  link.dxgvLinkClickHanlderAssigned = true;
 }
});
ControlUpdateWatcher.Instance = null;
ControlUpdateWatcher.getInstance = function () {
 if (!ControlUpdateWatcher.Instance) {
  ControlUpdateWatcher.Instance = new ControlUpdateWatcher();
  ASPx.Evt.AttachEventToElement(window, "beforeunload", function(e) {
   return ControlUpdateWatcher.Instance.OnWindowBeforeUnload(e);
  });
  ASPx.Evt.AttachEventToElement(window, "unload", function(e) {
   ControlUpdateWatcher.Instance.OnWindowUnload(e);
  });
  ASPx.Evt.AttachEventToDocument("mousedown", function(e) {
   ControlUpdateWatcher.Instance.OnMouseDown(e);
  });
  ASPx.Evt.AttachEventToDocument("focusin", function(e) {
   ControlUpdateWatcher.Instance.OnFocusIn(e);
  });
 }
 return ControlUpdateWatcher.Instance;
};
var UpdateWatcherHelper = ASPx.CreateClass(null, {
 constructor: function(owner) {
  this.owner = owner;
  this.ownerWatcher = ControlUpdateWatcher.getInstance();
  this.ownerWatcher.Add(this);
 },
 GetName: function() {
  return this.owner.name;
 },
 GetControlMainElement: function() {
  return this.owner.GetMainElement();
 },
 GetControlParentForm: function(){
  return ASPx.GetParentByTagName(this.GetControlMainElement(), "FORM");
 },
 CanShowConfirm: function(requestOwnerID) {
  return true;
 },
 HasChanges: function() {
  return false;
 },
 GetConfirmUpdateText: function() {
  return "";
 },
 NeedConfirmOnCallback: function(dxCallbackOwner) {
  return true;
 },
 NeedConfirmOnPostback: function() {
  if(ASPx.IsUploadSubmitRequest)
   return !ASPx.IsUploadSubmitRequest(this.GetControlParentForm());
  return true;
 },
 ResetClientChanges: function() {
 },
 ConfirmOnCustomControlEvent: function() {
  var confirmMessage = this.GetConfirmUpdateText();
  if(confirmMessage)
   return confirm(confirmMessage);
  return false;
 },
 isInUploadCallback: function() {
  return false;
 }
});
var ControlTabIndexManager = ASPx.CreateClass(null, {
 constructor: function() {
  this.elementsWithChangedTabIndex = {};
 },
 getChangedElementsForControlId: function(id) {
  if(!this.elementsWithChangedTabIndex[id])
   this.elementsWithChangedTabIndex[id] = [];
  return this.elementsWithChangedTabIndex[id];
 },
 isElementWithChangedIndex: function(element) {
  for(var key in this.elementsWithChangedTabIndex)
   if(this.elementsWithChangedTabIndex.hasOwnProperty(key))
    if(this.elementsWithChangedTabIndex[key].indexOf(element) !== -1)
     return true;
  return false;
 },
 changeTabIndexAttribute: function(element, id) {
  var elements = this.getChangedElementsForControlId(id);
  ASPx.Attr.ChangeTabIndexAttribute(element);
  if(elements.indexOf(element) === -1)
   elements.push(element);
 },
 restoreTabIndexAttribute: function(element, id) {
  var elements = this.getChangedElementsForControlId(id),
   index = elements.indexOf(element);
  if(index !== -1) {
   elements.splice(index, 1);
   if(!this.isElementWithChangedIndex(element))
    ASPx.Attr.RestoreTabIndexAttribute(element);
  }
 }
});
ControlTabIndexManager.Instance = null;
ControlTabIndexManager.getInstance = function() {
 if(!ControlTabIndexManager.Instance)
  ControlTabIndexManager.Instance = new ControlTabIndexManager();
 return ControlTabIndexManager.Instance;
};
var ControlCallbackHandlersQueue = ASPx.CreateClass(null, {
 constructor: function (owner) {
  this.owner = owner;
  this.handlerInfos = [];
 },
 addCallbackHandler: function(handlerInfo) {
  this.handlerInfos.push(handlerInfo);
 },
 executeCallbacksHandlers: function() {
  for(var i = 0, handlerInfo; handlerInfo = this.handlerInfos[i]; i++)
   handlerInfo.handler.call(this.owner, handlerInfo.result);
  this.handlerInfos = [];
 }
});
var ControlCallbackQueueHelper = ASPx.CreateClass(null, {
 constructor: function (owner) {
  this.owner = owner;
  this.pendingCallbacks = [];
  this.receivedCallbacks = [];
  this.attachEvents();
 },
 showLoadingElements: function () {
  this.owner.ShowLoadingDiv();
  if (this.owner.IsCallbackAnimationEnabled())
   this.owner.StartBeginCallbackAnimation();
  else
   this.owner.ShowLoadingElementsInternal();
 },
 attachEvents: function () {
  this.owner.EndCallback.AddHandler(this.onEndCallback.aspxBind(this));
  this.owner.CallbackError.AddHandler(this.onCallbackError.aspxBind(this));
 },
 detachEvents: function () {
  this.owner.EndCallback.RemoveHandler(this.onEndCallback);
  this.owner.CallbackError.RemoveHandler(this.onCallbackError);
 },
 onCallbackError: function (owner, result) {
  this.sendErrorToChildControl(result);
 },
 ignoreDuplicates: function () {
  return true;
 },
 hasDuplicate: function (arg) {
  for (var i in this.pendingCallbacks) {
   if (this.pendingCallbacks[i].arg == arg && this.pendingCallbacks[i].state != ASPx.callbackState.aborted)
    return true;
  }
  return false;
 },
 getToken: function (halperContext, callbackInfo) {
  return {
   cancel: function () {
    if (callbackInfo.state == ASPx.callbackState.sent) {
     callbackInfo.state = ASPx.callbackState.aborted;
     halperContext.sendNext();
    }
    if (callbackInfo.state == ASPx.callbackState.inTurn)
     ASPx.Data.ArrayRemove(halperContext.pendingCallbacks, callbackInfo);
   },
   callbackId: -1
  };
 },
 sendCallback: function (arg, handlerContext, handler, commandName, onBeforeSend) {
  if (this.ignoreDuplicates() && this.hasDuplicate(arg))
   return false;
  var handlerContext = handlerContext || this.owner;
  var callbackInfo = {
   arg: arg,
   handlerContext: handlerContext,
   handler: handler || handlerContext.OnCallback,
   state: ASPx.callbackState.inTurn,
   callbackId: -1,
   onBeforeSend: onBeforeSend
  };
  this.pendingCallbacks.push(callbackInfo);
  if (!this.hasActiveCallback()) {
   this.createCallbackByCallbackInfo(callbackInfo, commandName);
  }
  return this.getToken(this, callbackInfo);
 },
 hasActiveCallback: function () {
  return this.getCallbacksInfoByState(ASPx.callbackState.sent).length > 0;
 },
 sendNext: function () {
  var nextCallbackInfo = this.getCallbacksInfoByState(ASPx.callbackState.inTurn)[0];
  if (nextCallbackInfo) {
   this.createCallbackByCallbackInfo(nextCallbackInfo);
   return nextCallbackInfo.callbackId;
  }
 },
 createCallbackByCallbackInfo: function(callbackInfo, commandName) {
  if(callbackInfo.onBeforeSend)
   callbackInfo.onBeforeSend();
  callbackInfo.callbackId = this.owner.CreateCallback(callbackInfo.arg, commandName);
  callbackInfo.state = ASPx.callbackState.sent;
 },
 onEndCallback: function () {
  if (!this.owner.isErrorOnCallback && this.hasPendingCallbacks()) {
   var curCallbackId;
   var curCallbackInfo;
   var handlerContext;
   for (var i in this.receivedCallbacks) {
    if(this.receivedCallbacks.hasOwnProperty(i)) {
     curCallbackId = this.receivedCallbacks[i];
     curCallbackInfo = this.getCallbackInfoById(curCallbackId);
     if (curCallbackInfo.state != ASPx.callbackState.aborted) {
      handlerContext = curCallbackInfo.handlerContext;
      if (handlerContext.OnEndCallback)
       handlerContext.OnEndCallback();
      this.sendNext();
     }
     ASPx.Data.ArrayRemove(this.pendingCallbacks, curCallbackInfo);
    }
   }
   ASPx.Data.ArrayClear(this.receivedCallbacks);
  }
 },
 hasPendingCallbacks: function () {
  return this.pendingCallbacks && this.pendingCallbacks.length && this.pendingCallbacks.length > 0;
 },
 processCallback: function (result, callbackId) {
  this.receivedCallbacks.push(callbackId);
  if (this.hasPendingCallbacks()) {
   var callbackInfo = this.getCallbackInfoById(callbackId);
   if (callbackInfo.state != ASPx.callbackState.aborted)
    callbackInfo.handler.call(callbackInfo.handlerContext, result);
  }
 },
 getCallbackInfoById: function (id) {
  for (var i in this.pendingCallbacks) {
   if (this.pendingCallbacks[i].callbackId == id)
    return this.pendingCallbacks[i];
  }
 },
 getCallbacksInfoByState: function (state) {
  var result = [];
  for (var i in this.pendingCallbacks) {
   if (this.pendingCallbacks[i].state == state)
    result.push(this.pendingCallbacks[i]);
  }
  return result;
 },
 sendErrorToChildControl: function (callbackObj) {
  if (!this.hasPendingCallbacks())
   return;
  var callbackInfo = this.getCallbackInfoById(callbackObj.callbackId || 0);
  if (!callbackInfo)
   return;
  var hasChildControlHandler = (callbackInfo.handlerContext != this.owner) && callbackInfo.handlerContext.OnCallbackError;
  if (hasChildControlHandler)
   callbackInfo.handlerContext.OnCallbackError.call(callbackInfo.handlerContext, callbackObj.message, callbackObj.data);
 }
});
var AccessibilityHelperBase = ASPx.CreateClass(null, {
 constructor: function(control) {
  this.control = control;
  this.timerID = -1;
  this.pronounceMessageTimeout = 500;
  this.activeItem = this.getItems()[0];
  this.pronounceIsStarted = false;
 },
 PronounceMessage: function(text, activeItemArgs, inactiveItemArgs, mainElementArgs, ownerMainElement) {   
  this.timerID = ASPx.Timer.ClearTimer(this.timerID);
  this.pronounceIsStarted = true;
  this.timerID = window.setTimeout(function() {
   this.PronounceMessageCore(text, activeItemArgs, inactiveItemArgs, mainElementArgs, ownerMainElement);
  }.aspxBind(this), this.getPronounceTimeout());
 },
 PronounceMessageCore: function(text, activeItemArgs, inactiveItemArgs, mainElementArgs, ownerMainElement) {
  if(!this.getItems())
   return;
  this.toogleItem();
  var mainElement = this.getMainElement();
  var activeItem = this.getItem(true);
  var inactiveItem = this.getItem();
  if(ASPx.Attr.GetAttribute(mainElement, "role") != "application")
   mainElementArgs = this.addArguments(mainElementArgs, { "aria-activedescendant" : activeItem.id });
  var messageAttrObj = {};
  var activeItemRole = ASPx.Attr.GetAttribute(activeItem, "role");
  var attrName = activeItemRole == "combobox" ? "aria-label" : "innerHtml";
  messageAttrObj[attrName] = ASPx.Str.EncodeHtml(text);
  activeItemArgs = this.addArguments(activeItemArgs, messageAttrObj);
  messageAttrObj[attrName] = "";
  inactiveItemArgs = this.addArguments(inactiveItemArgs, messageAttrObj);
  var errorTextElement = null;
  if(this.control.GetErrorCell()) {
   errorTextElement = this.getAriaExplanatoryTextManager().GetErrorTextElement();
   activeItemArgs = this.addArguments(activeItemArgs,   {"aria-invalid"  : !this.control.isValid ? "true" : "" });
   mainElementArgs = this.addArguments(mainElementArgs, { "aria-invalid" : "" });
   inactiveItemArgs = this.addArguments(inactiveItemArgs,  { "aria-invalid" : "" });
  }
  this.changeActivityAttributes(activeItem, activeItemArgs);
  if(errorTextElement) {
   this.getAriaExplanatoryTextManager().SetOrRemoveText([activeItem], errorTextElement, !this.control.isValid, false, true);
   this.getAriaExplanatoryTextManager().SetOrRemoveText([mainElement, inactiveItem], errorTextElement, false, false, false);
  }
  this.changeActivityAttributes(mainElement, mainElementArgs);
  if(!!ownerMainElement && ASPx.Attr.GetAttribute(ownerMainElement, "role") != "application")
   this.changeActivityAttributes(ownerMainElement, { "aria-activedescendant": activeItem.id });
  this.changeActivityAttributes(inactiveItem, inactiveItemArgs);
  this.pronounceIsStarted = false;
 },
 GetActiveElement: function(inputIsMainElement) {
  if(this.pronounceIsStarted) return null;
  var mainElement = inputIsMainElement ? this.control.GetInputElement() : this.getMainElement();
  var activeElementId = ASPx.Attr.GetAttribute(mainElement, 'aria-activedescendant');
  return activeElementId ? ASPx.GetElementById(activeElementId) : mainElement;
 },
 getMainElement: function() {
  if(!ASPx.IsExistsElement(this.mainElement))
   this.mainElement = this.control.GetAccessibilityAssistantElement();
  return this.mainElement;
 },
 getItems: function() {
  if(!ASPx.IsExistsElement(this.items))
   this.items = ASPx.GetChildElementNodes(this.getMainElement());
  return this.items;
 },
 getItem: function(isActive) {
  if(isActive)
   return this.activeItem;
  var items = this.getItems();
  return items[0] === this.activeItem ? items[1] : items[0];
 },
 getAriaExplanatoryTextManager: function() { return this.control.ariaExplanatoryTextManager; },
 getPronounceTimeout: function() { return this.pronounceMessageTimeout; },
 toogleItem: function() {
  this.activeItem = this.getItem();
 },
 addArguments: function(targetArgs, newArgs) {
  if(!targetArgs) targetArgs = { };
  for(var key in newArgs) {
   if(newArgs.hasOwnProperty(key) && !targetArgs.hasOwnProperty(key))
    targetArgs[key] = newArgs[key];
  }
  return targetArgs;
 },
 changeActivityAttributes: function(element, args) {
  if(!element)
   return;
  for(var key in args) {
   if(args.hasOwnProperty(key)) {
    var value = args[key];
    if(key == "innerHtml")
     ASPx.SetInnerHtml(element, value);
    else {
     var action = value !== "" ? ASPx.Attr.SetAttribute : ASPx.Attr.RemoveAttribute;
     action(element, key, value);
    }
   }
  }
 }
});
var AccessibilityPronouncer = ASPx.CreateClass(null, {
 constructor: function() {
  this.pronouncerId = "dxPronouncer";
  this.initialized = false;
  this.focusableMessageElement = null;
  this.messageElement = null;
  this.pronouncers = {
   live: new AccessibilityLivePronouncer(this),
   descendant: new AccessibilityDescendantPronouncer(this)
  };
 },
 Pronounce: function(args, type) {
  this.pronouncers[type].Pronounce(args);
 },
 EnsureInitialize: function() {
  if(!this.initialized)
   this.initialize();
 },
 RemoveState: function() {
  for(var pronouncer in this.pronouncers)
   if(this.pronouncers.hasOwnProperty(pronouncer))
    pronouncer.RemoveState();
 },
 RestoreControlState: function(type, mainElement) {
  this.pronouncers[type].RestoreControlState(mainElement);
 },
 RestoreElementsState: function(type, elements) {
  this.pronouncers[type].RestoreElementsState(elements);
 },
 RestoreElementState: function(type, element) {
  this.pronouncers[type].RestoreElementState(element);
 },
 initialize: function() {
  this.createFocusableMessageElement();
  this.createMessageElement();
  this.prepareFocusableMessageElement();
  this.setAttributesForKeyboardNavigation();
  this.initialized = true;
 },
 createFocusableMessageElement: function() {
  var focusableMessageElement = document.createElement("DIV");
  document.body.appendChild(focusableMessageElement);
  this.focusableMessageElement = focusableMessageElement;   
 },
 prepareFocusableMessageElement: function() {
  this.focusableMessageElement.className = "dxAIFME";
 },
 setAttributesForKeyboardNavigation: function() {
  ASPx.Attr.Aria.SetApplicationRole(this.focusableMessageElement);
  ASPx.Attr.Aria.SetSilence(this.focusableMessageElement);
 },
 createMessageElement: function() {
  var messageElement = document.createElement("DIV");
  messageElement.id = this.pronouncerId;
  ASPx.Attr.SetAttribute(messageElement, "role", "note");
  this.focusableMessageElement.appendChild(messageElement);
  this.messageElement = messageElement;
 },
 getMessage: function(messagePartsArg) {
  var messageParts = messagePartsArg.filter(function(x) { return ASPx.IsExists(x); });
  return messageParts.join(", ");
 }
});
var AccessibilityPronouncerBase = ASPx.CreateClass(null, {
 constructor: function() {
  this.state = { };
 },
 Pronounce: function(args) {
  var messageElement = this.getMessageElement();
  ASPx.Attr.Aria.SetOrRemoveLabel(messageElement);
  ASPx.SetInnerHtml(messageElement, "");
  this.PronounceCore(args);
 },
 PronounceCore: function(args) { },
 SaveElementState: function(element) { 
  if(this.state[element.id])
   return;
  this.state[element.id] = {
   element: element,
   descendant: ASPx.Attr.GetAttribute(element, ASPx.Attr.Aria.descendant)
  };
 },
 RemoveState: function() {
  this.state = { };
 },
 RestoreControlState: function(mainElement) { 
  for(var elementInfo in this.state) {
   if(this.state.hasOwnProperty(elementInfo)) {
    var element = this.state[elementInfo].element;
    if(!mainElement || ASPx.GetIsParent(mainElement, element))
     this.RestoreElementState(element);
   }
  }
 },
 RestoreElementsState: function(elements) { 
  for(var i = 0; i < elements.length; i++)
   this.RestoreElementState(elements[i]);
 },
 RestoreElementState: function(element) {
  var elementState = this.state[element.id];
  if(!elementState)
   return;
  ASPx.Attr.Aria.SetOrRemoveDescendant(element, elementState.descendant);
  delete this.state[element.id];
 },
 getMessage: function(args) {
  return ASPx.AccessibilityPronouncer.getMessage(args.messageParts);
 },
 getMessageElement: function() {
  return ASPx.AccessibilityPronouncer.messageElement;
 },
 getFocusableMessageElement: function() {
   return ASPx.AccessibilityPronouncer.focusableMessageElement;
 }
});
var AccessibilityLivePronouncer = ASPx.CreateClass(AccessibilityPronouncerBase, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
 },
 PronounceCore: function(args) {
  var message = this.getMessage(args);
  var messageElement = this.getMessageElement();
  ASPx.Attr.SetAttribute(this.getFocusableMessageElement(), "aria-live", "assertive");
  ASPx.Attr.Aria.SetAtomic(this.getFocusableMessageElement(), "true");
  ASPx.SetInnerHtml(messageElement, ASPx.Str.EncodeHtml(message));
 }
});
var AccessibilityDescendantPronouncer = ASPx.CreateClass(AccessibilityPronouncerBase, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
 },
 PronounceCore: function(args) {
  var message = this.getMessage(args);
  var activeElement = ASPx.GetActiveElement();
  var messageElement = this.getMessageElement();
  this.SaveElementState(activeElement);
  ASPx.Attr.RemoveAttribute(this.getFocusableMessageElement(), "aria-live");
  ASPx.Attr.RemoveAttribute(this.getFocusableMessageElement(), "aria-atomic");
  ASPx.Attr.Aria.SetOrRemoveLabel(messageElement, message);
  ASPx.Attr.Aria.SetOrRemoveDescendant(activeElement, messageElement.id);
 }
});
ASPx.AccessibilityPronouncerType = {
 live: "live",
 descendant: "descendant"
};
ASPx.AccessibilityPronouncer = new AccessibilityPronouncer();
var RestoreFocusHelper = ASPx.CreateClass(null, {
 constructor: function() {
  this.excludedIDs = [ "DXCBtn" ]; 
  this.pronouncerType = ASPx.AccessibilityPronouncerType.live;
  this.callbackQueue = [];
  this.Initialize();
 },
 Initialize: function() {
  var that = this;
  ASPx.attachToLoad(function() {
   ASPxClientControl.GetControlCollection().BeginCallback.AddHandler(that.OnBeginCallback, that);
   ASPxClientControl.GetControlCollection().EndCallback.AddHandler(that.OnEndCallback, that);
  });
 },
 OnBeginCallback: function(s, e) {
  var control = e.control;
  if(!control.allowRestoreFocusOnCallbacks())
   return;
  control.accessibilityFocusTreeLine = this.getFocusTreeLine(control);
  var controlHasCallbackTreeLine = this.callbackQueueContainsTreeLine(control);
  this.pushTreeLineInfoIntoCallbackQueue(control);
  if(control.accessibilityFocusTreeLine && !controlHasCallbackTreeLine)
   control.SendMessageToAssistiveTechnology(this.getDefaultCallbackMessage());
 },
 OnEndCallback: function(s, e) {
  var control = e.control;
  if(!control.allowRestoreFocusOnCallbacks())
   return;
  var treeLineInfo = this.shiftTreeLineInfoFromCallbackQueue(control);
  if(treeLineInfo.queueLength == 0) {
   if(!control.accessibilityFocusTreeLine && treeLineInfo.treeLine)
    control.accessibilityFocusTreeLine = treeLineInfo.treeLine;
   var focusElement = this.findFocusElement(control);
   var focusIsManagerByPopupwindow = this.isFocusManagedByActivePopupWindow(focusElement);
   var focusIsManagedByControl = control.shouldPreventFocusRestoringOnCallback && control.shouldPreventFocusRestoringOnCallback();
   if(!focusIsManagerByPopupwindow && !focusIsManagedByControl)
    ASPx.AccessibilityUtils.SetFocusAccessible(focusElement);
   delete control.accessibilityFocusTreeLine;
  }
 },
 pushTreeLineInfoIntoCallbackQueue: function(control) {
  var controlTreeLine = control.accessibilityFocusTreeLine ? control.accessibilityFocusTreeLine.slice(0) : null;
  if(!this.callbackQueue[control.name])
   this.callbackQueue[control.name] = [];
  this.callbackQueue[control.name].push(controlTreeLine);
 },
 shiftTreeLineInfoFromCallbackQueue: function(control) {
  var treeLineInfo = { queueLength: 0, treeLine: null };
  var treeLines = this.callbackQueue[control.name];
  if(treeLines && treeLines.length > 0) {
   treeLineInfo.treeLine = treeLines.shift();
   var linesCount = treeLines.length;
   treeLineInfo.queueLength = linesCount;
   if(linesCount > 0 && !treeLines[0] && treeLineInfo.treeLine)
    treeLines[0] = treeLineInfo.treeLine.slice(0);
  }
  return treeLineInfo;
 },
 callbackQueueContainsTreeLine: function(control) {
  var treeLines = this.callbackQueue[control.name];
  if(!treeLines || treeLines.length == 0) 
   return false;
  if(treeLines[treeLines.length - 1])
   return true;
  return false;
 },
 getDefaultCallbackMessage: function() {
  return ASPx.AccessibilitySR.DefaultCallbackMessage;
 },
 isFocusManagedByActivePopupWindow: function(focusElement) {
  var popupControl = this.getActivePopupControl();
  if(!popupControl || popupControl.accessibleFocusElement)
   return false;
  this.initializePopupAccessibleFocusElement(popupControl, focusElement);
  return popupControl.setFocusOnCallback;
 },
 getActivePopupControl: function() {
  var activePopupWindow = ASPx.GetPopupControlCollection && ASPx.GetPopupControlCollection().GetCurrentActiveWindowElement();
  if(!activePopupWindow)
   return null;
  var popupInfo = ASPx.GetPopupControlCollection().GetPopupWindowFromID(activePopupWindow.id);
  return popupInfo.popupControl;
 },
 initializePopupAccessibleFocusElement: function(popupControl, focusElement) {
  if(popupControl.setFocusOnCallback)
   popupControl.accessibleFocusElement = focusElement;
  else {
   var parentControl = popupControl.GetParentControl();
   if(parentControl && parentControl.GetMainElement())
    popupControl.accessibleFocusElement = ASPx.FindFirstChildActionElement(parentControl.GetMainElement());
  }
 },
 getFocusTreeLine: function(control) {
  var element = ASPx.GetActiveElement();
  if(!ASPx.IsExistsElement(element))
   return null;
  var mainElement = control.GetMainElement();
  if(!ASPx.GetIsParent(mainElement, element)) {
   var treeInfo = this.findFocusedControlElement(mainElement, element);
   element = treeInfo.focusElement;
   mainElement = treeInfo.rootElement;
  }
  return this.getTreeLineCore(mainElement, element);
 },
 getTreeLineCore: function(mainElement, element) {
  if(!element) return null;
  treeLine = [ ];
  while(element) {
   treeLine.push({ 
    id: element.id,
    tagName: element.tagName,
    index: ASPx.Data.ArrayIndexOf(element.parentNode.childNodes, element)
   });
   if(element === mainElement || element === document.body)
    break;
   element = element.parentNode;
  }
  return treeLine;
 },
 findFocusedControlElement: function(mainElement, activeElement) {
  var element = null;
  var parentElement = mainElement;
  var focusedEditor = ASPx.IsExists(ASPx.GetFocusedEditor) ? ASPx.GetFocusedEditor() : null;
  if(focusedEditor && ASPx.GetIsParent(mainElement, focusedEditor.GetMainElement()))
   element = focusedEditor.GetFocusableInputElement();
  else {
   if(mainElement && activeElement) {
    var mainControl = ASPx.GetClientControlByElementID(mainElement.id);
    var parentControls = ASPx.GetParentClientControls(activeElement.id);
    for(var i = parentControls.length - 1; i > -1; i--) {   
     if(mainControl.name == parentControls[i].name) {
      element = activeElement;
      var rootIndex = i > 0 ? i - 1 : i;
      parentElement = parentControls[rootIndex].GetMainElement();
      if(!parentElement && parentControls[rootIndex].GetCurrentWindowElement)
       parentElement = parentControls[rootIndex].GetCurrentWindowElement();
      break;
     }
    }
   }
  }
  return { focusElement: element, rootElement: parentElement }; 
 },
 findFocusElement: function(control) {
  if(!control.accessibilityFocusTreeLine)
   return;
  var treeLine = control.accessibilityFocusTreeLine.slice(0);
  var focusElementParent = this.findFocusElementParentById(treeLine);
  if(!focusElementParent) 
   return;
  return this.findFocusElementFromDOMTree(treeLine, focusElementParent);
 },
 findFocusElementParentById: function(treeLine) {
  for(var i = 0; i < treeLine.length; i++) {
   var id = treeLine[i].id;
   if(!this.isValidId(id))
    continue;
   var element = document.getElementById(id);
   if(element) {
    treeLine.splice(i, treeLine.length - i);
    treeLine.reverse();
    return element;
   }
  }
  return null;
 },
 findFocusElementFromDOMTree: function(treeLine, focusElementParent) {
  var element = focusElementParent;
  for(var i = 0; i < treeLine.length; i++) {
   var info = treeLine[i];
   if(info.index >= element.childNodes.length) {
    element = element.childNodes.length > 0 ? element.childNodes[element.childNodes.length - 1] : null;
    return this.findNeighbourFocusElement(element, focusElementParent);
   }
   var child = element.childNodes[info.index];
   if(child.tagName !== info.tagName)
    return this.findNeighbourFocusElement(child, focusElementParent);
   element = child;
  }
  return element;
 },
 findNeighbourFocusElement: function(element, focusElementParent) {
  ASPx.ActionElementsCache.BeginUsage();
  var result = this.findNeighbourFocusElementCore(element, focusElementParent);
  ASPx.ActionElementsCache.EndUsage();
  return result;
 },
 findNeighbourFocusElementCore: function(element, focusElementParent) {
  if(!element || !element.parentNode) return null;
  var neighbours = element.parentNode.childNodes;
  var indices = this.calcLeftRightIndices(ASPx.Data.ArrayIndexOf(neighbours, element), neighbours.length);
  for(var i = 0; i < indices.length; i++) {
   var index = indices[i];
   var actionElement = ASPx.FindFirstChildActionElement(neighbours[index]);
   if(actionElement)
    return actionElement;
  }
  if(element === focusElementParent)
   return null;
  return this.findNeighbourFocusElement(element.parentNode, focusElementParent);
 },
 calcLeftRightIndices: function(startIndex, count) {
  var indices = [ ];
  var incSides = [ 0, 0 ];
  var index = startIndex;
  for(var i = 0; i < count; i++) {
   indices.push(index);
   var even = i % 2 === 0;
   var nextIndex = this.calcNextIndex(startIndex, count, incSides, even);
   if(nextIndex < 0)
    nextIndex = this.calcNextIndex(startIndex, count, incSides, !even);
   index = nextIndex;
  }
  return indices;
 },
 calcNextIndex: function(startIndex, count, incSides, even) {
  var sideIndex = even ? 0 : 1;
  var inc = incSides[sideIndex];
  inc += even ? -1 : 1;
  var nextIndex = startIndex + inc;
  if(nextIndex >= 0 && nextIndex < count) {
   incSides[sideIndex] = inc;
   return nextIndex;
  }
  return -1;
 },
 isValidId: function(id) {
  return id && !this.isExcludedId(id);
 },
 isExcludedId: function(id) {
  var result = false;
  for(var i = 0; i < this.excludedIDs.length; i++) {
   if(id.indexOf(this.excludedIDs[i]) > -1) {
    result = true;
    break;
   }
  }
  return result;
 }
});
var EventStorage = ASPx.CreateClass(null, {
 constructor: function() {
  this.bag = { };
 },
 Save: function(e, data, overwrite) {
  var key = this.getEventKey(e);
  if(this.bag.hasOwnProperty(key) && !overwrite)
   return;
  this.bag[key] = data;
  window.setTimeout(function() { delete this.bag[key]; }.aspxBind(this), 100);
 },
 Load: function(e) {
  var key = this.getEventKey(e);
  return this.bag[key];
 },
 getEventKey: function(e) {
  if(ASPx.IsExists(e.timeStamp))
   return e.timeStamp.toString();
  var eventSource = ASPx.Evt.GetEventSource(e);
  var type = e.type.toString();
  return eventSource ? type + "_" + eventSource.uniqueID.toString() : type;
 }
});
ASPx.RestoreFocusHelper = new RestoreFocusHelper();
EventStorage.Instance = null;
EventStorage.getInstance = function() {
 if(!EventStorage.Instance)
  EventStorage.Instance = new EventStorage();
 return EventStorage.Instance;
};
var GetGlobalObject = function(objectName) {
 var fields = objectName.split('.');
 var obj = window[fields[0]];
 for(var i = 1; obj && i < fields.length; i++) {
  obj = obj[fields[i]];
 }
 return obj;
};
var GetExternalScriptProcessor = function() {
 return ASPx.ExternalScriptProcessor ? ASPx.ExternalScriptProcessor.getInstance() : null;
};
var SAVED_WIDTH_ATTR = "data-dx-ripple-saved-width";
var RIPPLE_FIXED_ROW_ATTR = "data-dx-ripple-locked";
var READ_ONLY_COMBOBOX_MARKER_CSS_CLASS = "dxICBReadonlyMarker";
var ThemesWithRipple = ['Material'];
var RippleHelper = {
 rippleTargetClassName: "dxRippleTarget",
 rippleTargetExternalClassName: "dxRippleTargetExternal",
 rippleContainerClassName: "dxRippleContainer",
 rippleClassName: "dxRipple",
 touchRadius: -1,
 isMobileExternalRipple: null,
 zoom: 1,
 Init: function() {
  if(this.getIsRippleFunctionalityEnabled()) {
   setTimeout(function() {
    this.calcTouchRadius();
   }.aspxBind(this), 0);
  }
 },
 calcTouchRadius: function() {
  var testBlock = document.createElement("DIV");
  ASPx.SetStyles(testBlock, {
   height: "1in",
   width: "1in",
   left: "-100%",
   top: "-100%",
   position: "absolute"
  });
  document.body.appendChild(testBlock);
  this.touchRadius = (1.8 / 2.54) * Math.max(testBlock.offsetWidth, testBlock.offsetHeight);
  document.body.removeChild(testBlock);
 },
 isRippleFunctionalityEnabled: null,
 checkRippleFunctionality: function() {
  if(ASPx.Browser.Safari && ASPx.Browser.Version <= 5.1)
   return false;
  for(var i = 0; i < ThemesWithRipple.length; i++) {
   var firstRippleThemeElement = document.querySelector("[class*='_" + ThemesWithRipple[i] + "']");
   if(firstRippleThemeElement)
    return true;
  }  
  return false;
 },
 ReInit: function() {
  this.isRippleFunctionalityEnabled = null;
  this.Init();
 },
 onDocumentMouseDown: function(evt) {
  if(RippleHelper.getIsRippleFunctionalityEnabled())
   RippleHelper.processMouseDown(evt);
 },
 getIsRippleFunctionalityEnabled: function() {
  if(!ASPx.IsExists(this.isRippleFunctionalityEnabled))
   this.isRippleFunctionalityEnabled = this.checkRippleFunctionality();
  return this.isRippleFunctionalityEnabled;
 },
   createTargetInfo: function(target) {
  return { 
   x: ASPx.GetAbsoluteX(target),
   y: ASPx.GetAbsoluteY(target),
   width: target.offsetWidth,
   height: target.offsetHeight,
   classNames: ASPx.GetClassNameList(target),
   getTarget: function() { return target; },
   getRect: function() { return {x: this.x, y: this.y, width: this.width, height: this.height }; }
  };
 },
 createEventInfo: function(evt) {
  return { x: this.getEventX(evt), y: this.getEventY(evt) };
 },
 processMouseDown: function(evt) {
  var evtSource = ASPx.Evt.GetEventSource(evt);
  var rippleTarget = this.getRippleTargetElement(evtSource);
  if(this.needToProcessRipple(rippleTarget, evtSource))
   this.processRipple(this.createTargetInfo(rippleTarget), this.createEventInfo(evt));
 },
 getRippleTargetElement: function(evtSource) {
  if(this.hasRippleMarker(evtSource))
   return evtSource;
  if(evtSource.tagName && evtSource.tagName.toLowerCase() == "input" && ASPx.ElementContainsCssClass(evtSource, "dxTI")) {
   var elements = ASPx.GetChildElementNodesByPredicate(evtSource.parentNode.parentNode, function(element) {
    return this.hasRippleMarker(element);
   }.aspxBind(this));
   return elements && elements[0];
  }
  return ASPx.GetParent(evtSource, function(element) {
   return this.hasRippleMarker(element);
  }.aspxBind(this));
 },
 hasRippleMarker: function(element) {
  if(!ASPx.IsExistsElement(element))
   return false;
  var computedStyles = window.getComputedStyle(element, ":before");
  if(ASPx.IsExists(computedStyles)) {
   var content = computedStyles.getPropertyValue("content");
   if(content.indexOf(this.rippleTargetExternalClassName) > -1) {
    ASPx.AddClassNameToElement(element, this.rippleTargetExternalClassName);
    return true;
   }
   return content.indexOf(this.rippleTargetClassName) > -1;
  }
  return false;
 },
 needToProcessRipple: function(rippleTarget, evtSource) {
  if(!rippleTarget || !ASPx.AnimationUtils)
   return false;
  var isClearButton = ASPx.ElementContainsCssClass(rippleTarget, "dxeButton") && rippleTarget.id && rippleTarget.id.indexOf("B-100") !== -1;
  var isEmptyCalendarDay = ASPx.ElementContainsCssClass(rippleTarget, "dxeCalendarDay") && ASPx.Str.Trim(rippleTarget.textContent) == "";
  var isReadonly = ASPx.ElementContainsCssClass(rippleTarget, READ_ONLY_COMBOBOX_MARKER_CSS_CLASS);
  var tempFixDisable = ASPx.ElementContainsCssClass(rippleTarget, "dxSwitcher") && ASPx.Browser.MacOSMobilePlatform;
  var rippleIsForbidden = isReadonly || isClearButton || isEmptyCalendarDay || ASPx.GetParentByPartialClassName(rippleTarget, "Disabled") ||
   ASPx.ElementContainsCssClass(rippleTarget, "dxgvBatchEditCell") || ASPx.ElementContainsCssClass(rippleTarget, "dxcvEditForm") ||
   ASPx.GetParentByPartialClassName(evtSource, "dxcvFocusedCell") || tempFixDisable;
  return !rippleIsForbidden;
 },
 hasBothOverflow: function(style) {
  return style.overflow == "scroll" || style.overflow == "auto" || style.overflow == "hidden";
 },
 hasOverflowX: function(style) {
  return style.overflowX == "scroll" || style.overflowX == "auto" || style.overflowX == "hidden";
 },
 hasOverflowY: function(style) {
  return style.overflowY == "scroll" || style.overflowY == "auto" || style.overflowY == "hidden";
 },
 getExternalRippleContainerSize: function(targetRect) {
  if(ASPx.Browser.MobileUI) {
   var origTouchRadius = this.getOriginTouchRadius();
   if(origTouchRadius < targetRect.width || origTouchRadius < targetRect.height)
    origTouchRadius = Math.max(targetRect.width, targetRect.height);
   return {x: targetRect.x + (targetRect.width - origTouchRadius) / 2, y: targetRect.y + (targetRect.height - origTouchRadius) / 2, width: origTouchRadius, height: origTouchRadius };
  }
  var result = { x: 0, y: 0, width: 0, height: 0 };
  var diff = targetRect.width - targetRect.height;
  if(diff > 0) {
   result.x = targetRect.x;
   result.y = targetRect.y - diff / 2;
   result.width = targetRect.width;
   result.height = targetRect.width;
  } else {
   result.x = targetRect.x + diff / 2;
   result.y = targetRect.y;
   result.width = targetRect.height;
   result.height = targetRect.height;
  }
  return result;
 },
 getInternalContainerSize: function(targetInfo) {
  var parentWithOverflow = RippleHelper.getParentWithOverflow(targetInfo.getTarget());
  if(!ASPx.IsExists(parentWithOverflow))
   return targetInfo;
  var parentWithOverflowStyle = ASPx.GetCurrentStyle(parentWithOverflow);
  var bothOverflow = this.hasBothOverflow(parentWithOverflowStyle);
  var overflowX = this.hasOverflowX(parentWithOverflowStyle);
  var overflowY = this.hasOverflowY(parentWithOverflowStyle);
  var parentRect = {
   x: ASPx.GetAbsoluteX(parentWithOverflow),
   y: ASPx.GetAbsoluteY(parentWithOverflow),
   width: parentWithOverflow.offsetWidth,
   height: parentWithOverflow.offsetHeight
  };
  return this.getInternalContainerSizeCore(targetInfo, parentRect, bothOverflow, overflowX, overflowY);
 },
 getInternalContainerSizeCore: function(targetRect, parentRect, bothOverflow, overflowX, overflowY) {
  var result = {};
  ASPx.Data.MergeHashTables(result, targetRect);
  if(bothOverflow || overflowX) {
   result.x = targetRect.x < parentRect.x ? parentRect.x : targetRect.x;
   if(targetRect.x + targetRect.width > parentRect.x + parentRect.width)
    result.width = parentRect.x + parentRect.width - targetRect.x;
   if(parentRect.x > targetRect.x)
    result.width -= (parentRect.x - targetRect.x);
  }
  if(bothOverflow || overflowY) {
   result.y = targetRect.y < parentRect.y ? parentRect.y : targetRect.y;
   if(targetRect.y + targetRect.height > parentRect.y + parentRect.height)
    result.height = parentRect.y + parentRect.height - targetRect.y;
   if(parentRect.y > targetRect.y)
    result.height -= (parentRect.y - targetRect.y);
  }
  return result;
 },
 calculateRippleContainerSize: function(targetInfo, isExternalRipple) {
  return isExternalRipple ? this.getExternalRippleContainerSize(targetInfo) : this.getInternalContainerSize(targetInfo);
 },
 getParentWithOverflow: function(rippleTarget) {
  var result = ASPx.GetParent(rippleTarget, function(element) {
   var elementStyle = ASPx.GetCurrentStyle(element);
   return this.hasBothOverflow(elementStyle) || this.hasOverflowX(elementStyle) || this.hasOverflowY(elementStyle);
  }.aspxBind(this));
  return result;
 },
 getDuration: function(targetInfo) {
  return this.IsExternalRipple(targetInfo) || ASPx.Browser.MobileUI ? 650 : 450;
 },
 createRippleTransition: function(container, rippleElement, radius, targetInfo) {
  var rippleSize = 2 * radius;
  var transitionEndIsAborted = true;
  var transitionProperties = {
   width: { from: 0, to: rippleSize, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "width", unit: "px" },
   height: { from: 0, to: rippleSize, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "height", unit: "px" },
   marginLeft: { from: 0, to: -rippleSize / 2, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "marginLeft", unit: "px" },
   marginTop: { from: 0, to: -rippleSize / 2, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "marginTop", unit: "px" },
   opacity: { from: 1, to: 0.05, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "opacity", unit: "%" }
  };
  var rippleTransition = ASPx.AnimationUtils.createMultipleAnimationTransition(rippleElement, {
   transition: ASPx.AnimationConstants.Transitions.RIPPLE,
   duration: this.getDuration(targetInfo),
   onComplete: function() {
    this.RemoveRippleContainer(container.parentElement);
    transitionEndIsAborted = false;
   }.bind(this)
  });
  rippleTransition.Start(transitionProperties);
  window.setTimeout(function() {
   if(transitionEndIsAborted)
    this.RemoveRippleContainer(container.parentElement);
  }.bind(this), 500);
 },
 calculateRadius: function(isExternalRipple, posX, posY, containerRect) {
  var radius = -1;
  if(isExternalRipple) {
   if(ASPx.Browser.MobileUI)
    radius = this.getOriginTouchRadius() / 2;
   else
    radius = Math.max(containerRect.height, containerRect.width);
  } else {
   var width1 = posX - containerRect.x;
   var width2 = containerRect.width - width1;
   var height1 = posY - containerRect.y;
   var height2 = containerRect.height - height1;
   var rippleWidth = Math.max(width1, width2);
   var rippleHeight = Math.max(height1, height2);
   radius = Math.sqrt(Math.pow(rippleHeight, 2) + Math.pow(rippleWidth, 2));
  }
  return radius;
 },
 createRippleElement: function(container, rippleCenter) {
  var rippleElement = document.createElement("DIV");
  rippleElement.className = this.rippleClassName;
  container.appendChild(rippleElement);
  ASPxClientUtils.SetAbsoluteX(rippleElement, rippleCenter.x);
  ASPxClientUtils.SetAbsoluteY(rippleElement, rippleCenter.y);
  return rippleElement;
 },
 processRipple: function(targetInfo, eventInfo) {
  this.initRippleProcess();
  var isExternalRipple = this.IsExternalRipple(targetInfo);
  var rippleCenter = this.getRippleCenter(targetInfo.getRect(), eventInfo, isExternalRipple);
  var container = this.createRippleContainer(targetInfo, isExternalRipple);
  var rippleElement = this.createRippleElement(container, rippleCenter);
  var radius = this.calculateRadius(isExternalRipple, rippleCenter.x, rippleCenter.y, this.getElementRect(container));
  this.createRippleTransition(container, rippleElement, radius, targetInfo);
 },
 initRippleProcess: function() {
  this.isMobileExternalRipple = null;
  this.zoom = screen.width / window.innerWidth;
 },
 getRippleCenter: function(targetInfo, eventInfo, isExternalRipple) {
  var posX = 0;
  var posY = 0;
  if(isExternalRipple) {
   posX = targetInfo.x + targetInfo.width / 2;
   posY = targetInfo.y + targetInfo.height / 2;
  } else {
   posX = eventInfo.x;
   posY = eventInfo.y;
  }
  return {x: posX, y: posY};
 },
 createRippleContainer: function(targetInfo, isExternalRipple) {
  var containerParent = targetInfo.getTarget();
  if(!containerParent)
   return;
  var containerTagName = containerParent.tagName == "TR" ? "TD" : "DIV";
  var container = document.createElement(containerTagName);
  container.className = this.rippleContainerClassName;
  if(containerParent.parentNode && containerParent.tagName == "IMG")
   containerParent = containerParent.parentNode;
  if(this.isARowInFixedLayoutTable(containerParent))
   this.lockFixedLayoutTableSizes(containerParent);
  containerParent.appendChild(container);
  if(isExternalRipple)
   container.style.borderRadius = "50%";
  var containerRect = this.calculateRippleContainerSize(targetInfo, isExternalRipple);
  this.assignContainerSettings(container, containerRect);
  return container;
 },
 isARowInFixedLayoutTable: function(containerParent) {
  if(containerParent.tagName !== "TR")
   return false;
  var parentTable = this.getParentTable(containerParent);
  return parentTable && ASPx.GetCurrentStyle(parentTable)["table-layout"] === "fixed";
 },
 processFirstRowOfFixedTable: function(containerRow, rowAction, cellAction) {
  var firstRow = this.getFirstRow(containerRow);
  rowAction(firstRow);
  var cells = ASPx.Data.CollectionToArray(firstRow.cells);
  cells.forEach(cellAction);
 },
 getParentTable: function(element) {
  var parentTable = element;
  while(parentTable && parentTable.tagName !== "TABLE")
   parentTable = parentTable.parentElement;
  return parentTable;
 },
 lockFixedLayoutTableSizes: function(containerRow) {
  var firstRow = this.getFirstRow(containerRow);
  if(this.incLockCount(firstRow) === 1) {
   var cells = ASPx.Data.CollectionToArray(firstRow.cells);
   var widths = cells.map(function(cell) { return cell.style.width; });
   var computedWidths = cells.map(function(cell) {
    if(ASPx.Browser.IE && ASPx.ElementHasCssClass(cell, "dxeCM"))
     return cell.offsetWidth + "px";
    return window.getComputedStyle(cell).width;
   });
   var fixWidth = function(cell, i) {
    if(ASPx.Attr.IsExistsAttribute(cell, SAVED_WIDTH_ATTR))
     return;
    if(widths[i])
     ASPx.Attr.SetAttribute(cell, SAVED_WIDTH_ATTR, widths[i]);
    cell.style.width = computedWidths[i];
   };
   cells.forEach(fixWidth);
  }
 }, 
 unlockFixedLayoutTableSizes: function(containerRow) {
  var firstRow = this.getFirstRow(containerRow);   
  if(this.decLockCount(firstRow) === 0) {
   var cells = ASPx.Data.CollectionToArray(firstRow.cells);
   var restoreState = function(cell) {
    if(ASPx.Attr.IsExistsAttribute(cell, SAVED_WIDTH_ATTR)) {
     cell.style.width = ASPx.Attr.GetAttribute(cell, SAVED_WIDTH_ATTR);
     ASPx.Attr.RemoveAttribute(cell, SAVED_WIDTH_ATTR);
    } else {
     cell.style.width = null;
    }
   };
   cells.forEach(restoreState);
  }
 },
 getFirstRow: function(containerRow) { return ASPx.GetChildByTagName(containerRow.parentElement, "TR", 0); },
 incLockCount: function(elem) { return this.changeLockCount(elem, 1); },
 decLockCount: function(elem) { return this.changeLockCount(elem, -1); },
 changeLockCount: function(elem, diff) {
  var lockCounter = this.getLockCount(elem);
  lockCounter += diff;
  lockCounter = Math.max(0, lockCounter);
  if(lockCounter === 0)
   ASPx.Attr.RemoveAttribute(elem, RIPPLE_FIXED_ROW_ATTR);
  else
   ASPx.Attr.SetAttribute(elem, RIPPLE_FIXED_ROW_ATTR, lockCounter);
  return lockCounter;
 },
 getLockCount: function(lockElement) {
  var attrValue = ASPx.Attr.GetAttribute(lockElement, RIPPLE_FIXED_ROW_ATTR);
  return parseInt(attrValue) || 0;
 },
 assignContainerSettings: function(container, containerRect) {
  var properties = {
   height: containerRect.height,
   width: containerRect.width,
   left: ASPx.PrepareClientPosForElement(containerRect.x, container, true),
   top: ASPx.PrepareClientPosForElement(containerRect.y, container, false)
  };
  if(ASPx.Browser.MobileUI)
   ASPx.Data.MergeHashTables(properties, {marginTop: 0, marginLeft: 0 });
  ASPx.SetStyles(container, properties, ASPx.Browser.MobileUI);
 },
 IsExternalRipple: function(targetInfo) {
  var hasExternalRippleClassName = ASPx.ElementContainsCssClass(targetInfo.getTarget(), this.rippleTargetExternalClassName);
  if(!ASPx.Browser.MobileUI)
   return hasExternalRippleClassName;
  return hasExternalRippleClassName || this.IsMobileExternalRipple(targetInfo);
 },
 IsMobileExternalRipple: function(targetInfo) {
  if(this.isMobileExternalRipple == null) {
   var originTouchRadius = this.getOriginTouchRadius();
   this.isMobileExternalRipple = ASPx.Browser.MobileUI && targetInfo.width < originTouchRadius && targetInfo.height < originTouchRadius;
  }
  return this.isMobileExternalRipple;
 },
 RemoveRippleContainer: function(element) {
  if(!element)
   return;
  var childs = ASPx.GetChildNodesByClassName(element, this.rippleContainerClassName);
  var rippleContainer = childs.length > 0 ? childs[0] : null;
  if(rippleContainer != null) {
   var containerParent = rippleContainer.parentNode;
   containerParent.removeChild(rippleContainer);
   if(this.isARowInFixedLayoutTable(containerParent))
    this.unlockFixedLayoutTableSizes(containerParent);
  }
 },
 getEventX: function(evt) {
  return ASPxClientUtils.GetEventX(evt);
 },
 getEventY: function(evt) {
  return ASPxClientUtils.GetEventY(evt);
 },
 getOriginTouchRadius: function() {
  return this.touchRadius / this.zoom;
 },
 getElementRect: function(element) {
  return { x: ASPx.GetAbsoluteX(element), y: ASPx.GetAbsoluteY(element), width: element.offsetWidth, height: element.offsetHeight };
 }
};
var AccessibilitySR = {
 AddStringResources: function(stringResourcesObj) {
  if(stringResourcesObj) {
   for(var key in stringResourcesObj)
    if(stringResourcesObj.hasOwnProperty(key))
     this[key] = stringResourcesObj[key];
  }
 }
};
ASPx.CollectionBase = CollectionBase;
ASPx.FunctionIsInCallstack = _aspxFunctionIsInCallstack;
ASPx.RaisePostHandlerOnPost = aspxRaisePostHandlerOnPost;
ASPx.GetPostHandler = aspxGetPostHandler;
ASPx.ProcessScriptsAndLinks = _aspxProcessScriptsAndLinks;
ASPx.InitializeLinks = _aspxInitializeLinks;
ASPx.InitializeScripts = _aspxInitializeScripts;
ASPx.RunStartupScripts = _aspxRunStartupScripts;
ASPx.IsStartupScriptsRunning = _aspxIsStartupScriptsRunning;
ASPx.AddScriptsRestartHandler = _aspxAddScriptsRestartHandler;
ASPx.GetFocusedElement = _aspxGetFocusedElement;
ASPx.GetDomObserver = _aspxGetDomObserver;
ASPx.CacheHelper = CacheHelper;
ASPx.ControlTree = ControlTree;
ASPx.ControlAdjuster = ControlAdjuster;
ASPx.GetControlAdjuster = GetControlAdjuster;
ASPx.ControlCallbackHandlersQueue = ControlCallbackHandlersQueue;
ASPx.ResourceManager = ResourceManager;
ASPx.UpdateWatcherHelper = UpdateWatcherHelper;
ASPx.EventStorage = EventStorage;
ASPx.GetGlobalObject = GetGlobalObject;
ASPx.GetExternalScriptProcessor = GetExternalScriptProcessor;
ASPx.CheckBoxCheckState = CheckBoxCheckState;
ASPx.CheckBoxInputKey = CheckBoxInputKey;
ASPx.CheckableElementStateController = CheckableElementStateController;
ASPx.CheckableElementHelper = CheckableElementHelper;
ASPx.CheckBoxInternal = CheckBoxInternal;
ASPx.CheckBoxInternalCollection = CheckBoxInternalCollection;
ASPx.ControlCallbackQueueHelper = ControlCallbackQueueHelper;
ASPx.FocusedStyleDecoration = FocusedStyleDecoration;
ASPx.EditorStyleDecoration = EditorStyleDecoration;
ASPx.TextEditorStyleDecoration = TextEditorStyleDecoration;
ASPx.AccessibilitySR = AccessibilitySR;
ASPx.KbdHelper = KbdHelper;
ASPx.AccessKeysHelper = AccessKeysHelper;
ASPx.AccessKey = AccessKey;
ASPx.IFrameHelper = IFrameHelper;
ASPx.Ident = Ident;
ASPx.TouchUIHelper = TouchUIHelper;
ASPx.ControlUpdateWatcher = ControlUpdateWatcher;
ASPx.ControlTabIndexManager = ControlTabIndexManager;
ASPx.AccessibilityHelperBase = AccessibilityHelperBase;
ASPx.RippleHelper = RippleHelper;
ASPx.ThemesWithRipple = ThemesWithRipple;
window.ASPxClientEvent = ASPxClientEvent;
window.ASPxClientEventArgs = ASPxClientEventArgs;
window.ASPxClientCancelEventArgs = ASPxClientCancelEventArgs;
window.ASPxClientProcessingModeEventArgs = ASPxClientProcessingModeEventArgs;
window.ASPxClientProcessingModeCancelEventArgs = ASPxClientProcessingModeCancelEventArgs;
ASPx.Evt.AttachEventToDocument(TouchUIHelper.touchMouseDownEventName, RippleHelper.onDocumentMouseDown);
ASPx.classesScriptParsed = true;
})(ASPx, { GCCheckInterval: 5000 });

(function () {
ASPx.StateItemsExist = false;
ASPx.FocusedItemKind = "FocusedStateItem";
ASPx.HoverItemKind = "HoverStateItem";
ASPx.PressedItemKind = "PressedStateItem";
ASPx.SelectedItemKind = "SelectedStateItem";
ASPx.DisabledItemKind = "DisabledStateItem";
ASPx.ReadOnlyItemKind = "ReadOnlyStateItem";
ASPx.CachedStatePrefix = "cached";
ASPxStateItem = ASPx.CreateClass(null, {
 constructor: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink){
  this.name = name;
  this.classNames = classNames;
  this.customClassNames = [];
  this.resultClassNames = [];
  this.cssTexts = cssTexts;
  this.postfixes = postfixes;
  this.imageObjs = imageObjs;
  this.imagePostfixes = imagePostfixes;
  this.kind = kind;
  this.classNamePostfix = kind.substr(0, 1).toLowerCase();
  this.enabled = true;
  this.needRefreshBetweenElements = false;
  this.elements = null;
  this.images = null;
  this.links = [];
  this.linkColor = null;
  this.linkTextDecoration = null;
  this.disableApplyingStyleToLink = !!disableApplyingStyleToLink; 
 },
 GetCssText: function(index){
  if(ASPx.IsExists(this.cssTexts[index]))
   return this.cssTexts[index];
  return this.cssTexts[0];
 },
 CreateStyleRule: function(index){
  if(this.GetCssText(index) == "") return "";
  var styleSheet = ASPx.GetCurrentStyleSheet();
  if(styleSheet)
   return ASPx.CreateImportantStyleRule(styleSheet, this.GetCssText(index), this.classNamePostfix);  
  return ""; 
 },
 GetClassName: function(index){
  if(ASPx.IsExists(this.classNames[index]))
   return this.classNames[index];
  return this.classNames[0];
 },
 GetResultClassName: function(index){
  if(!ASPx.IsExists(this.resultClassNames[index])) {
   if(!ASPx.IsExists(this.customClassNames[index]))
    this.customClassNames[index] = this.CreateStyleRule(index);
   if(this.GetClassName(index) != "" && this.customClassNames[index] != "")
    this.resultClassNames[index] = this.GetClassName(index) + " " + this.customClassNames[index];
   else if(this.GetClassName(index) != "")
    this.resultClassNames[index] = this.GetClassName(index);
   else if(this.customClassNames[index] != "")
    this.resultClassNames[index] = this.customClassNames[index];
   else
    this.resultClassNames[index] = "";
  }
  return this.resultClassNames[index];
 },
 GetElements: function(element){
  if(!this.elements || !ASPx.IsValidElements(this.elements)){
   if(this.postfixes && this.postfixes.length > 0){
    this.elements = [ ];
    var parentNode = element.parentNode;
    if(parentNode){
     for(var i = 0; i < this.postfixes.length; i++){
      var id = this.name + this.postfixes[i];
      this.elements[i] = ASPx.GetChildById(parentNode, id);
      if(!this.elements[i])
       this.elements[i] = ASPx.GetElementById(id);
     }
    }
   }
   else
    this.elements = [element];
  }
  return this.elements;
 },
 GetImages: function(element){
  if(!this.images || !ASPx.IsValidElements(this.images)){
   this.images = [ ];
   if(this.imagePostfixes && this.imagePostfixes.length > 0){
    var elements = this.GetElements(element);
    for(var i = 0; i < this.imagePostfixes.length; i++){
     var id = this.name + this.imagePostfixes[i];
     for(var j = 0; j < elements.length; j++){
      if(!elements[j]) continue;
      if(elements[j].id == id)
       this.images[i] = elements[j];
      else
       this.images[i] = ASPx.GetChildById(elements[j], id);
      if(this.images[i])
       break;
     }
    }
   }
  }
  return this.images;
 },
 Apply: function(element){
  if(!this.enabled) return;
  try{
   this.ApplyStyle(element);
   if(this.imageObjs && this.imageObjs.length > 0)
    this.ApplyImage(element);
   if(ASPx.Browser.IE && ASPx.Browser.MajorVersion >= 11 && ASPx.Browser.PlaformMajorVersion < 10)
    this.ForceRedrawAppearance(element);
  }
  catch(e){
  }
 },
 ApplyStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   if(this.GetResultClassName(i) != "") {
    var className = elements[i].className.replace(this.GetResultClassName(i), "");
    elements[i].className = ASPx.Str.Trim(className) + " " + this.GetResultClassName(i);
   }
   if(!ASPx.Browser.Opera || ASPx.Browser.Version >= 9)
    this.ApplyStyleToLinks(elements, i);
  }
 },
 ApplyStyleToLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  if(!ASPx.IsValidElements(this.links[index]))
   this.links[index] = ASPx.GetNodesByTagName(elements[index], "A");
  for(var i = 0; i < this.links[index].length; i++)
   this.ApplyStyleToLinkElement(this.links[index][i], index);
 },
 ApplyStyleToLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   ASPx.Attr.ChangeAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color", this.GetLinkColor(index));
  if(this.GetLinkTextDecoration(index) != "")
   ASPx.Attr.ChangeAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration", this.GetLinkTextDecoration(index));
 },
 ApplyImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   var useSpriteImage = typeof(this.imageObjs[i]) != "string";
   var newUrl = "", newCssClass = "", newBackground = "";
   if(useSpriteImage){
    newUrl = ASPx.EmptyImageUrl;           
    if(this.imageObjs[i].spriteCssClass) 
     newCssClass = this.imageObjs[i].spriteCssClass;
    if(this.imageObjs[i].spriteBackground)
     newBackground = this.imageObjs[i].spriteBackground;
   }
   else{
    newUrl = this.imageObjs[i];
    if(ASPx.Attr.IsExistsAttribute(images[i].style, "background"))   
     newBackground = " ";
   }
   if(newUrl != "")
    ASPx.Attr.ChangeAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src", newUrl);
   if(newCssClass != "")
    this.ApplyImageClassName(images[i], newCssClass);
   if(newBackground != ""){
    if(ASPx.Browser.WebKitFamily) {
     var savedBackground = ASPx.Attr.GetAttribute(images[i].style, "background");
     if(!useSpriteImage)
      savedBackground += " " + images[i].style["backgroundPosition"];
     ASPx.Attr.SetAttribute(images[i], "saved" + this.kind + "Background", savedBackground);
     ASPx.Attr.SetAttribute(images[i].style, "background", newBackground);
    }
    else
     ASPx.Attr.ChangeAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background", newBackground);
   }     
  }
 },
 ApplyImageClassName: function(element, newClassName){
  if(ASPx.Attr.GetAttribute(element, "saved" + this.kind + "ClassName"))
   this.CancelImageClassName(element);
  var className = element.className;
  ASPx.Attr.SetAttribute(element, "saved" + this.kind + "ClassName", className);
  element.className = className + " " + newClassName;
 },
 Cancel: function(element){
  if(!this.enabled) return;
  try{  
   if(this.imageObjs && this.imageObjs.length > 0)
    this.CancelImage(element);
   this.CancelStyle(element);
  }
  catch(e){
  }
 },
 CancelStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   if(this.GetResultClassName(i) != "") {
    var className = ASPx.Str.Trim(elements[i].className.replace(this.GetResultClassName(i), ""));
    elements[i].className = className;
   }
   if(!ASPx.Browser.Opera || ASPx.Browser.Version >= 9)
    this.CancelStyleFromLinks(elements, i);
  }
 },
 CancelStyleFromLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  if(!ASPx.IsValidElements(this.links[index]))
   this.links[index] = ASPx.GetNodesByTagName(elements[index], "A");
  for(var i = 0; i < this.links[index].length; i++)
   this.CancelStyleFromLinkElement(this.links[index][i], index);
 },
 CancelStyleFromLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   ASPx.Attr.RestoreAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color");
  if(this.GetLinkTextDecoration(index) != "")
   ASPx.Attr.RestoreAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration");
 },
 CancelImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   ASPx.Attr.RestoreAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src");
   this.CancelImageClassName(images[i]);
   ASPx.Attr.RestoreAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background");
  }
 },
 CancelImageClassName: function(element){
  var savedClassName = ASPx.Attr.GetAttribute(element, "saved" + this.kind + "ClassName");
  if(ASPx.IsExists(savedClassName)) {
   element.className = savedClassName;
   ASPx.Attr.RemoveAttribute(element, "saved" + this.kind + "ClassName");
  }
 },
 Clone: function(){
  return new ASPxStateItem(this.name, this.classNames, this.cssTexts, this.postfixes, 
   this.imageObjs, this.imagePostfixes, this.kind, this.disableApplyingStyleToLink);
 },
 IsChildElement: function(element){
  if(element != null){
   var elements = this.GetElements(element);
   for(var i = 0; i < elements.length; i++){
    if(!elements[i]) continue;
    if(ASPx.GetIsParent(elements[i], element)) 
     return true;
   }
  }
  return false;
 },
 ForceRedrawAppearance: function(element) {
  if(!aspxGetStateController().IsForceRedrawAppearanceLocked()) {
   var value = element.style.opacity;
   element.style.opacity = "0.7777";
   var dummy = element.offsetWidth;
   element.style.opacity = value;
  }
 },
 GetLinkColor: function(index){
  if(!ASPx.IsExists(this.linkColor)){
   var rule = ASPx.GetStyleSheetRules(this.customClassNames[index]);
   this.linkColor = rule ? rule.style.color : null;
   if(!ASPx.IsExists(this.linkColor)){
    var rule = ASPx.GetStyleSheetRules(this.GetClassName(index));
    this.linkColor = rule ? rule.style.color : null;
   }
   if(this.linkColor == null) 
    this.linkColor = "";
  }
  return this.linkColor;
 },
 GetLinkTextDecoration: function(index){
  if(!ASPx.IsExists(this.linkTextDecoration)){
   var rule = ASPx.GetStyleSheetRules(this.customClassNames[index]);
   this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   if(!ASPx.IsExists(this.linkTextDecoration)){
    var rule = ASPx.GetStyleSheetRules(this.GetClassName(index));
    this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   }
   if(this.linkTextDecoration == null) 
    this.linkTextDecoration = "";
  }
  return this.linkTextDecoration;
 }
});
ASPxClientStateEventArgs = ASPx.CreateClass(null, {
 constructor: function(item, element){
  this.item = item;
  this.element = element;
  this.toElement = null;
  this.fromElement = null;
  this.htmlEvent = null;
 }
});
ASPxStateController = ASPx.CreateClass(null, {
 constructor: function(){
  this.focusedItems = { };
  this.hoverItems = { };
  this.pressedItems = { };
  this.selectedItems = { };
  this.disabledItems = {};
  this.readOnlyItems = {};
  this.disabledScheme = {};
  this.currentFocusedElement = null;
  this.currentFocusedItemName = null;
  this.currentHoverElement = null;
  this.currentHoverItemName = null;
  this.currentPressedElement = null;
  this.currentPressedItemName = null;
  this.savedCurrentPressedElement = null;
  this.savedCurrentMouseMoveSrcElement = null;
  this.forceRedrawAppearanceLockCount = 0;
  this.stateItemType = ASPxStateItem;
  this.AfterSetFocusedState = new ASPxClientEvent();
  this.AfterClearFocusedState = new ASPxClientEvent();
  this.AfterSetHoverState = new ASPxClientEvent();
  this.AfterClearHoverState = new ASPxClientEvent();
  this.AfterSetPressedState = new ASPxClientEvent();
  this.AfterClearPressedState = new ASPxClientEvent();
  this.AfterDisabled = new ASPxClientEvent();
  this.AfterEnabled = new ASPxClientEvent();
  this.BeforeSetFocusedState = new ASPxClientEvent();
  this.BeforeClearFocusedState = new ASPxClientEvent();
  this.BeforeSetHoverState = new ASPxClientEvent();
  this.BeforeClearHoverState = new ASPxClientEvent();
  this.BeforeSetPressedState = new ASPxClientEvent();
  this.BeforeClearPressedState = new ASPxClientEvent();
  this.BeforeDisabled = new ASPxClientEvent();
  this.BeforeEnabled = new ASPxClientEvent();
  this.FocusedItemKeyDown = new ASPxClientEvent();
 }, 
 AddHoverItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.hoverItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.HoverItemKind, disableApplyingStyleToLink);
  this.AddItem(this.focusedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.FocusedItemKind, disableApplyingStyleToLink);
 },
 AddPressedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.pressedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.PressedItemKind, disableApplyingStyleToLink);
 },
 AddSelectedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.selectedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.SelectedItemKind, disableApplyingStyleToLink);
 },
 AddDisabledItem: function (name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink, rootId) {
  this.AddItem(this.disabledItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes,
   ASPx.DisabledItemKind, disableApplyingStyleToLink, this.addIdToDisabledItemScheme, rootId);
 },
 AddReadOnlyItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink) {
  this.AddItem(this.readOnlyItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.ReadOnlyItemKind, disableApplyingStyleToLink);
 },
 addIdToDisabledItemScheme: function(rootId, childId) {
  if (!rootId)
   return;
  if (!this.disabledScheme[rootId])
   this.disabledScheme[rootId] = [rootId];
  if (childId && (rootId != childId) && ASPx.Data.ArrayIndexOf(this.disabledScheme[rootId], childId) == -1)
   this.disabledScheme[rootId].push(childId);
 },
 removeIdFromDisabledItemScheme: function(rootId, childId) {
  if (!rootId || !this.disabledScheme[rootId])
   return;
  ASPx.Data.ArrayRemove(this.disabledScheme[rootId], childId);
  if (this.disabledScheme[rootId].length == 0)
   delete this.disabledScheme[rootId];
 },
 AddItem: function (items, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink, onAdd, rootId) {
  var type = this.getStateItemType();
  var stateItem = new type(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink);
  if (postfixes && postfixes.length > 0) {
   for (var i = 0; i < postfixes.length; i++) {
    items[name + postfixes[i]] = stateItem;
    if (onAdd)
     onAdd.call(this, rootId, name + postfixes[i]);
   }
  }
  else {
   if (onAdd)
    onAdd.call(this, rootId, name);
   items[name] = stateItem;
  }
  ASPx.StateItemsExist = true;
 },
 getStateItemType: function () { return this.stateItemType; },
 withCustomStateItemType: function (newType, callback) {
  this.stateItemType = newType;
  callback(this);
  this.stateItemType = ASPxStateItem;
 },
 RemoveHoverItem: function(name, postfixes){
  this.RemoveItem(this.hoverItems, name, postfixes);
  this.RemoveItem(this.focusedItems, name, postfixes);
 },
 RemovePressedItem: function(name, postfixes){
  this.RemoveItem(this.pressedItems, name, postfixes);
 },
 RemoveSelectedItem: function(name, postfixes){
  this.RemoveItem(this.selectedItems, name, postfixes);
 },
 RemoveDisabledItem: function (name, postfixes, rootId) {
  this.RemoveItem(this.disabledItems, name, postfixes, this.removeIdFromDisabledItemScheme, rootId);
 },
 RemoveReadOnlyItem: function(name, postfixes) {
  this.RemoveItem(this.readOnlyItems, name, postfixes);
 },
 RemoveItem: function (items, name, postfixes, onRemove, rootId) {
  if (postfixes && postfixes.length > 0) {
   for (var i = 0; i < postfixes.length; i++) {
    delete items[name + postfixes[i]];
    if (onRemove)
     onRemove.call(this, rootId, name + postfixes[i]);
   }
  }
  else {
   delete items[name];
   if (onRemove)
    onRemove.call(this, rootId, name);
  }
 },
 RemoveDisposedItems: function(){
  this.RemoveDisposedItemsByType(this.hoverItems);
  this.RemoveDisposedItemsByType(this.pressedItems);
  this.RemoveDisposedItemsByType(this.focusedItems);
  this.RemoveDisposedItemsByType(this.selectedItems);
  this.RemoveDisposedItemsByType(this.disabledItems);
  this.RemoveDisposedItemsByType(this.disabledScheme);
  this.RemoveDisposedItemsByType(this.readOnlyItems);
 },
 RemoveDisposedItemsByType: function(items){
  for(var key in items) {
   if(items.hasOwnProperty(key)) {
    var item = items[key];
    var element = document.getElementById(key);
    if(!element || !ASPx.IsValidElement(element))
     delete items[key];
    try {
     if(item && item.elements) {
      for(var i = 0; i < item.elements.length; i++) {
       if(!ASPx.IsValidElements(item.links[i]))
        item.links[i] = null;
      }
     }
    }
    catch(e) {
    }
   }
  }
 },
 GetFocusedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.focusedItems, ASPx.FocusedItemKind);
 },
 GetHoverElement: function(srcElement){
  return this.GetItemElement(srcElement, this.hoverItems, ASPx.HoverItemKind);
 },
 GetPressedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.pressedItems, ASPx.PressedItemKind);
 },
 GetSelectedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.selectedItems, ASPx.SelectedItemKind);
 },
 GetDisabledElement: function(srcElement){
  return this.GetItemElement(srcElement, this.disabledItems, ASPx.DisabledItemKind);
 },
 GetReadOnlyElement: function(srcElement) {
  return this.GetItemElement(srcElement, this.readOnlyItems, ASPx.ReadOnlyItemKind);
 },
 GetItemElement: function(srcElement, items, kind){
  if(srcElement && srcElement[ASPx.CachedStatePrefix + kind]){
   var cachedElement = srcElement[ASPx.CachedStatePrefix + kind];
   if(cachedElement != ASPx.EmptyObject)
    return cachedElement;
   return null;
  }
  var element = srcElement;
  while(element != null) {
   var item = items[element.id];
   if(item){
    this.CacheItemElement(srcElement, kind, element);
    element[kind] = item;
    return element;
   }
   element = element.parentNode;
  }
  this.CacheItemElement(srcElement, kind, ASPx.EmptyObject);
  return null;
 },
 CacheItemElement: function(srcElement, kind, value){
  if(srcElement && !srcElement[ASPx.CachedStatePrefix + kind])
   srcElement[ASPx.CachedStatePrefix + kind] = value;
 },
 DoSetFocusedState: function(element, fromElement){
  var item = element[ASPx.FocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetFocusedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetFocusedState.FireEvent(this, args);
  }
 },
 DoClearFocusedState: function(element, toElement){
  var item = element[ASPx.FocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearFocusedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearFocusedState.FireEvent(this, args);
  }
 },
 DoSetHoverState: function(element, fromElement){
  var item = element[ASPx.HoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetHoverState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetHoverState.FireEvent(this, args);
  }
 },
 DoClearHoverState: function(element, toElement){
  var item = element[ASPx.HoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearHoverState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearHoverState.FireEvent(this, args);
  }
 },
 DoSetPressedState: function(element){
  var item = element[ASPx.PressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeSetPressedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetPressedState.FireEvent(this, args);
  }
 },
 DoClearPressedState: function(element){
  var item = element[ASPx.PressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeClearPressedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearPressedState.FireEvent(this, args);
  }
 },
 SetCurrentFocusedElement: function(element){
  if(this.currentFocusedElement && !ASPx.IsValidElement(this.currentFocusedElement)){
   this.currentFocusedElement = null;
   this.currentFocusedItemName = "";
  }
  if(this.currentFocusedElement != element){
   var oldCurrentFocusedElement = this.currentFocusedElement;
   var item = (element != null) ? element[ASPx.FocusedItemKind] : null;
   var itemName = (item != null) ? item.name : "";
   if(this.currentFocusedItemName != itemName){
    if(this.currentHoverItemName != "")
     this.SetCurrentHoverElement(null);
    if(this.currentFocusedElement != null)
     this.DoClearFocusedState(this.currentFocusedElement, element);
    this.currentFocusedElement = element;
    item = (element != null) ? element[ASPx.FocusedItemKind] : null;
    this.currentFocusedItemName = (item != null) ? item.name : "";
    if(this.currentFocusedElement != null)
     this.DoSetFocusedState(this.currentFocusedElement, oldCurrentFocusedElement);
   }
  }
 },
 GetCurrentHoverElement: function() {
  return this.currentHoverElement;
 },
 SetCurrentHoverElement: function(element){
  if(this.currentHoverElement && !ASPx.IsValidElement(this.currentHoverElement)){
   this.currentHoverElement = null;
   this.currentHoverItemName = "";
  }
  var item = (element != null) ? element[ASPx.HoverItemKind] : null;
  if(item && !item.enabled) { 
   element = this.GetItemElement(element.parentNode, this.hoverItems, ASPx.HoverItemKind);
   item = (element != null) ? element[ASPx.HoverItemKind] : null;
  }
  if(this.currentHoverElement != element){
   var oldCurrentHoverElement = this.currentHoverElement,
    itemName = (item != null) ? item.name : "";
   if(this.currentHoverItemName != itemName || (item != null && item.needRefreshBetweenElements)){
    if(this.currentHoverElement != null)
     this.DoClearHoverState(this.currentHoverElement, element);
    item = (element != null) ? element[ASPx.HoverItemKind] : null;
    if(item == null || item.enabled){
     this.currentHoverElement = element;
     this.currentHoverItemName = (item != null) ? item.name : "";
     if(this.currentHoverElement != null)
      this.DoSetHoverState(this.currentHoverElement, oldCurrentHoverElement);
    }
   }
  }
 },
 SetCurrentPressedElement: function(element){
  if(this.currentPressedElement && !ASPx.IsValidElement(this.currentPressedElement)){
   this.currentPressedElement = null;
   this.currentPressedItemName = "";
  }
  if(this.currentPressedElement != element){
   if(this.currentPressedElement != null)
    this.DoClearPressedState(this.currentPressedElement);
   var item = (element != null) ? element[ASPx.PressedItemKind] : null;
   if(item == null || item.enabled){
    this.currentPressedElement = element;
    this.currentPressedItemName = (item != null) ? item.name : "";
    if(this.currentPressedElement != null)
     this.DoSetPressedState(this.currentPressedElement);
   }
  }
 },
 SetCurrentFocusedElementBySrcElement: function(srcElement){
  var element = this.GetFocusedElement(srcElement);
  this.SetCurrentFocusedElement(element);
 },
 SetCurrentHoverElementBySrcElement: function(srcElement){
  var element = this.GetHoverElement(srcElement);
  this.SetCurrentHoverElement(element);
 },
 SetCurrentPressedElementBySrcElement: function(srcElement){
  var element = this.GetPressedElement(srcElement);
  this.SetCurrentPressedElement(element);
 },
 SetPressedElement: function (element) {
  this.SetCurrentHoverElement(null);
  this.SetCurrentPressedElementBySrcElement(element);
  this.savedCurrentPressedElement = this.currentPressedElement;
 },
 SelectElement: function (element) {
  var item = element[ASPx.SelectedItemKind];
  if(item)
   item.Apply(element);
 }, 
 SelectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.SelectElement(element);
 }, 
 DeselectElement: function(element){
  var item = element[ASPx.SelectedItemKind];
  if(item)
   item.Cancel(element);
 }, 
 DeselectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.DeselectElement(element);
 },
 SetElementEnabled: function(element, enable){
  if(enable)
   this.EnableElement(element);
  else
   this.DisableElement(element);
 },
 SetElementReadOnly: function(element, readOnly) {
  var element = this.GetReadOnlyElement(element);
  if (element != null) {
   var item = element[ASPx.ReadOnlyItemKind];
   if(item) {
    if(readOnly) {
     if(item.name == this.currentPressedItemName)
      this.SetCurrentPressedElement(null);
     if(item.name == this.currentHoverItemName)
      this.SetCurrentHoverElement(null);
    }
    if(readOnly)
     item.Apply(element);
    else
     item.Cancel(element);
   }
  }
 },
 SetElementWithChildNodesEnabled: function (parentName, enabled) {
  var procFunct = (enabled ? this.EnableElement : this.DisableElement);
  var childItems = this.disabledScheme[parentName];
  if (childItems && childItems.length > 0)
   for (var i = 0; i < childItems.length; i++) {
    procFunct.call(this, document.getElementById(childItems[i]));
   }
 },
 DisableElement: function (element) {
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[ASPx.DisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeDisabled.FireEvent(this, args);
    if(item.name == this.currentPressedItemName)
     this.SetCurrentPressedElement(null);
    if(item.name == this.currentHoverItemName)
     this.SetCurrentHoverElement(null);
    item.Apply(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, false);
    this.AfterDisabled.FireEvent(this, args);
   }
  }
 }, 
 EnableElement: function(element){
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[ASPx.DisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeEnabled.FireEvent(this, args);
    item.Cancel(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, true);
    this.AfterEnabled.FireEvent(this, args);
   }
  }
 }, 
 SetMouseStateItemsEnabled: function(name, postfixes, enabled){   
  if(postfixes && postfixes.length > 0){
   for(var i = 0; i < postfixes.length; i ++){
    this.SetItemsEnabled(this.hoverItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.pressedItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.focusedItems, name + postfixes[i], enabled);
   }
  }
  else{
   this.SetItemsEnabled(this.hoverItems, name, enabled);
   this.SetItemsEnabled(this.pressedItems, name, enabled);
   this.SetItemsEnabled(this.focusedItems, name, enabled);
  }  
 },
 SetItemsEnabled: function(items, name, enabled){   
  if(items[name])
   items[name].enabled = enabled;
 },
 OnFocusMove: function(evt){
  var element = ASPx.Evt.GetEventSource(evt);
  aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
 },
 OnMouseMove: function(evt, checkElementChanged){
  var srcElement = ASPx.Evt.GetEventSource(evt);
  if(checkElementChanged && srcElement == this.savedCurrentMouseMoveSrcElement) return;
  this.savedCurrentMouseMoveSrcElement = srcElement;
  if(ASPx.Browser.IE && !ASPx.Evt.IsLeftButtonPressed(evt) && this.savedCurrentPressedElement != null)
   this.ClearSavedCurrentPressedElement();
  if(this.savedCurrentPressedElement == null)
   this.SetCurrentHoverElementBySrcElement(srcElement);
  else{
   var element = this.GetPressedElement(srcElement);
   if(element != this.currentPressedElement){
    if(element == this.savedCurrentPressedElement)
     this.SetCurrentPressedElement(this.savedCurrentPressedElement);
    else
     this.SetCurrentPressedElement(null);
   }
  }
 },
 OnMouseDown: function(evt){
  if(!ASPx.Evt.IsLeftButtonPressed(evt)) return;
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.OnMouseDownOnElement(srcElement);
 },
 OnMouseDownOnElement: function (element) {
  if(this.GetPressedElement(element) == null) return;
  this.SetPressedElement(element);
 },
 OnMouseUp: function(evt){
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.OnMouseUpOnElement(srcElement);
 },
 OnMouseUpOnElement: function(element){
  if(this.savedCurrentPressedElement == null) return;
  this.ClearSavedCurrentPressedElement();
  this.SetCurrentHoverElementBySrcElement(element);
 },
 OnMouseOver: function(evt){
  var element = ASPx.Evt.GetEventSource(evt);
  if(element && element.tagName == "IFRAME")
   this.OnMouseMove(evt, true);
 },
 OnKeyDown: function(evt){
  var element = this.GetFocusedElement(ASPx.Evt.GetEventSource(evt));
  if(element != null && element == this.currentFocusedElement) {
   var item = element[ASPx.FocusedItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    args.htmlEvent = evt;
    this.FocusedItemKeyDown.FireEvent(this, args);
   }
  }
 },
 OnKeyUpOnElement: function(evt) {
  if(this.savedCurrentPressedElement != null && ASPx.Evt.IsActionKeyPressed(evt))
   this.ClearSavedCurrentPressedElement();
 },
 OnSelectStart: function(evt){
  if(this.savedCurrentPressedElement) {
   ASPx.Selection.Clear();
   return false;
  }
 },
 ClearSavedCurrentPressedElement: function() {
  this.savedCurrentPressedElement = null;
  this.SetCurrentPressedElement(null);
 },
 ClearCache: function(srcElement, kind) {
  if(srcElement[ASPx.CachedStatePrefix + kind])
   srcElement[ASPx.CachedStatePrefix + kind] = null;
 },
 ClearElementCache: function(srcElement) {
  this.ClearCache(srcElement, ASPx.FocusedItemKind);
  this.ClearCache(srcElement, ASPx.HoverItemKind);
  this.ClearCache(srcElement, ASPx.PressedItemKind);
  this.ClearCache(srcElement, ASPx.SelectedItemKind);
  this.ClearCache(srcElement, ASPx.DisabledItemKind);
 },
 ClearElementCacheInContainer: function(container) {
  var elements = ASPx.GetNodes(container);
  elements.push(container);
  ASPx.Data.ForEach(elements, this.ClearElementCache.bind(this));
 },
 LockForceRedrawAppearance: function() {
  this.forceRedrawAppearanceLockCount++;
 },
 UnlockForceRedrawAppearance: function() {
  this.forceRedrawAppearanceLockCount--;
 },
 IsForceRedrawAppearanceLocked: function() {
  return this.forceRedrawAppearanceLockCount > 0;
 },
 GetHoverItem: function(srcElement) {
  var element = this.GetHoverElement(srcElement);
  return (element != null) ? element[ASPx.HoverItemKind] : null;
 }
});
var stateController = null;
function aspxGetStateController(){
 if(stateController == null)
  stateController = new ASPxStateController();
 return stateController;
}
function aspxAddStateItems(method, namePrefix, classes, disableApplyingStyleToLink){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][2].length; j ++) {
   var name = namePrefix;
   if(classes[i][2][j])
    name += "_" + classes[i][2][j];
   var postfixes = classes[i][3] || null;
   var imageObjs = (classes[i][4] && classes[i][4][j]) || null;
   var imagePostfixes = classes[i][5] || null;
   method.call(aspxGetStateController(), name, classes[i][0], classes[i][1], postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink, namePrefix);
  }
 }
}
ASPx.AddHoverItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddHoverItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddPressedItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddPressedItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddSelectedItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddSelectedItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddDisabledItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddDisabledItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddReadOnlyItems = function(namePrefix, classes, disableApplyingStyleToLink) {
 aspxAddStateItems(aspxGetStateController().AddReadOnlyItem, namePrefix, classes, disableApplyingStyleToLink);
};
function aspxRemoveStateItems(method, namePrefix, classes){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][0].length; j ++) {
   var name = namePrefix;
   if(classes[i][0][j])
    name += "_" + classes[i][0][j];
   method.call(aspxGetStateController(), name, classes[i][1], namePrefix);
  }
 }
}
ASPx.RemoveHoverItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveHoverItem, namePrefix, classes);
};
ASPx.RemovePressedItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemovePressedItem, namePrefix, classes);
};
ASPx.RemoveSelectedItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveSelectedItem, namePrefix, classes);
};
ASPx.RemoveDisabledItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveDisabledItem, namePrefix, classes);
};
ASPx.RemoveReadOnlyItems = function(namePrefix, classes) {
 aspxRemoveStateItems(aspxGetStateController().RemoveReadOnlyItem, namePrefix, classes);
};
ASPx.AddAfterClearFocusedState = function(handler){
 aspxGetStateController().AfterClearFocusedState.AddHandler(handler);
};
ASPx.AddAfterSetFocusedState = function(handler){
 aspxGetStateController().AfterSetFocusedState.AddHandler(handler);
};
ASPx.AddAfterClearHoverState = function(handler){
 aspxGetStateController().AfterClearHoverState.AddHandler(handler);
};
ASPx.AddAfterSetHoverState = function(handler){
 aspxGetStateController().AfterSetHoverState.AddHandler(handler);
};
ASPx.AddAfterClearPressedState = function(handler){
 aspxGetStateController().AfterClearPressedState.AddHandler(handler);
};
ASPx.AddAfterSetPressedState = function(handler){
 aspxGetStateController().AfterSetPressedState.AddHandler(handler);
};
ASPx.AddAfterDisabled = function(handler){
 aspxGetStateController().AfterDisabled.AddHandler(handler);
};
ASPx.AddAfterEnabled = function(handler){
 aspxGetStateController().AfterEnabled.AddHandler(handler);
};
ASPx.AddBeforeClearFocusedState = function(handler){
 aspxGetStateController().BeforeClearFocusedState.AddHandler(handler);
};
ASPx.AddBeforeSetFocusedState = function(handler){
 aspxGetStateController().BeforeSetFocusedState.AddHandler(handler);
};
ASPx.AddBeforeClearHoverState = function(handler){
 aspxGetStateController().BeforeClearHoverState.AddHandler(handler);
};
ASPx.AddBeforeSetHoverState = function(handler){
 aspxGetStateController().BeforeSetHoverState.AddHandler(handler);
};
ASPx.AddBeforeClearPressedState = function(handler){
 aspxGetStateController().BeforeClearPressedState.AddHandler(handler);
};
ASPx.AddBeforeSetPressedState = function(handler){
 aspxGetStateController().BeforeSetPressedState.AddHandler(handler);
};
ASPx.AddBeforeDisabled = function(handler){
 aspxGetStateController().BeforeDisabled.AddHandler(handler);
};
ASPx.AddBeforeEnabled = function(handler){
 aspxGetStateController().BeforeEnabled.AddHandler(handler);
};
ASPx.AddFocusedItemKeyDown = function(handler){
 aspxGetStateController().FocusedItemKeyDown.AddHandler(handler);
};
ASPx.SetHoverState = function(element){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(element);
};
ASPx.ClearHoverState = function(evt){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(null);
};
ASPx.UpdateHoverState = function(evt){
 aspxGetStateController().OnMouseMove(evt, false);
};
ASPx.SetFocusedState = function(element){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
};
ASPx.ClearFocusedState = function(evt){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(null);
};
ASPx.UpdateFocusedState = function(evt){
 aspxGetStateController().OnFocusMove(evt);
};
ASPx.AccessibilityMarkerClass = "dxalink";
ASPx.AssignAccessibilityEventsToChildrenLinks = function(container, clearFocusedStateOnMouseOut){
 var links = ASPx.GetNodesByPartialClassName(container, ASPx.AccessibilityMarkerClass);
 for(var i = 0; i < links.length; i++)
  ASPx.AssignAccessibilityEventsToLink(links[i], clearFocusedStateOnMouseOut);
};
ASPx.AssignAccessibilityEventsToLink = function(link, clearFocusedStateOnMouseOut) {
 if(!ASPx.ElementContainsCssClass(link, ASPx.AccessibilityMarkerClass))
  return;
 ASPx.AssignAccessibilityEventsToLinkCore(link, clearFocusedStateOnMouseOut);
};
ASPx.AssignAccessibilityEventsToLinkCore = function (link, clearFocusedStateOnMouseOut) {
 ASPx.Evt.AttachEventToElement(link, "focus", function (e) { ASPx.UpdateFocusedState(e); });
 var clearFocusedStateHandler = function (e) { ASPx.ClearFocusedState(e); };
 ASPx.Evt.AttachEventToElement(link, "blur", clearFocusedStateHandler);
 if(clearFocusedStateOnMouseOut)
  ASPx.Evt.AttachEventToElement(link, "mouseout", clearFocusedStateHandler);
};
ASPx.Evt.AttachEventToDocument("mousemove", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseMove(evt, true);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseDown(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseUp(evt);
});
ASPx.Evt.AttachEventToDocument("mouseover", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseOver(evt);
});
ASPx.Evt.AttachEventToDocument("keydown", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnKeyDown(evt);
});
ASPx.Evt.AttachEventToDocument("selectstart", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  return aspxGetStateController().OnSelectStart(evt);
});
ASPx.GetStateController = aspxGetStateController;
ASPx.StateItem = ASPxStateItem;
})();
(function () {
 var ASPx = window.ASPx || {};
 ASPx.ASPxImageLoad = {};
 ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass = "dxe-loadingImage";
 ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClassRegexp = new RegExp("dx\\w+-loadingImage");
 ASPx.ASPxImageLoad.OnLoad = function (image, customLoadingImage, isOldIE, customBackgroundImageUrl) {
  image.dxCustomBackgroundImageUrl = "";
  image.dxShowLoadingImage = true;
  image.dxCustomLoadingImage = customLoadingImage;
  if (customBackgroundImageUrl != "")
   image.dxCustomBackgroundImageUrl = "url('" + customBackgroundImageUrl + "')";
  ASPx.ASPxImageLoad.prepareImageBackground(image, isOldIE);
  ASPx.ASPxImageLoad.removeHandlers(image);
  image.className = image.className.replace(ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClassRegexp, "");
 };
 ASPx.ASPxImageLoad.removeASPxImageBackground = function (image, isOldIE) {
  if (isOldIE) 
   image.style.removeAttribute("background-image");
  else 
   image.style.backgroundImage = "";
 };
 ASPx.ASPxImageLoad.prepareImageBackground = function (image, isOldIE) {
  ASPx.ASPxImageLoad.removeASPxImageBackground(image, isOldIE);
  if (image.dxCustomBackgroundImageUrl != "")
   image.style.backgroundImage = image.dxCustomBackgroundImageUrl;
 };
 ASPx.ASPxImageLoad.removeHandlers = function (image) {
  image.removeAttribute("onload");
  image.removeAttribute("onabort");
  image.removeAttribute("onerror");
 };
 window.ASPx = ASPx;
})();
(function() {
var CheckingScriptObjectCommand = ASPx.CreateClass(null, {
 constructor: function(scriptName, markerObjectName) {
  this.scriptName = scriptName;
  this.markerObjectName = markerObjectName;
  this.isExisted = false;
 },
 Run: function() {
  var markerObj = this.GetMarkerObject();
  this.isExisted = !!markerObj;
  if(this.isExisted)
   markerObj.DXPatched = true;
 },
 GetErrorMessage: function() {
  return this.GetErrorMessageCore(true);
 },
 GetErrorMessageCore: function(isScriptRequired){
  var markerObj = this.GetMarkerObject();
  if(this.isExisted && markerObj && markerObj.DXPatched || !isScriptRequired && !markerObj)
   return null;
  if(isScriptRequired && !this.GetMarkerObject()){
   if(this.isExisted)
    return this.scriptName + " script was attached but has been overridden.";
   else
    return this.scriptName + " script was not attached.";
  }
  if(!this.isExisted)
   return this.scriptName + " script was attached after DevExpress scripts.";
  return this.scriptName + " script was attached multiple times and mixed up with DevExpress scripts.";
 },
 GetMarkerObject: function() {
  return ASPx.GetGlobalObject(this.markerObjectName);
 }
});
var PatchScriptCommand = ASPx.CreateClass(CheckingScriptObjectCommand, {
 constructor: function(scriptName, markerObjectName, patchMethod, required) {
  this.constructor.prototype.constructor.call(this, scriptName, markerObjectName);
  this.required = required;
  this.patchMethod = patchMethod;
 },
 Run: function() {
  CheckingScriptObjectCommand.prototype.Run.call(this);
  if(this.isExisted)
   this.patchMethod();
 },
 GetErrorMessage: function() {  
  return this.GetErrorMessageCore(this.required);
 }
});
var ExternalScriptProcessor = ASPx.CreateClass(null, {
 constructor: function() {
  this.commands = {};
 },
 Process: function(scriptName, markerObjectName, patchMethod, required) {
  var newCommand = this.CreateCommand(scriptName, markerObjectName, patchMethod, !!required);
  var oldCommand = this.commands[markerObjectName];
  if(oldCommand) {
   if(!oldCommand.patchMethod && !newCommand.patchMethod)
    newCommand = null;
   else if(newCommand.patchMethod && (!oldCommand.patchMethod || oldCommand.required))
    newCommand.required = true;
   else if(oldCommand.patchMethod && !newCommand.patchMethod) {
    oldCommand.required = true;
    newCommand = null;
   }
  }
  if(newCommand) {
   this.commands[markerObjectName] = newCommand;
   newCommand.Run();
  }
 },
 CreateCommand: function(scriptName, markerObjectName, patchMethod, required) {
  if(patchMethod)
   return new PatchScriptCommand(scriptName, markerObjectName, patchMethod, required);
  return new CheckingScriptObjectCommand(scriptName, markerObjectName);
 },
 ShowErrorMessages: function() {
  var messages = this.GetErrorMessages();
  var console = window.console;
  if(!messages.length || !console || !ASPx.IsFunction(console.error))
   return;
  for(var i = 0; i < messages.length; i++) {
   console.error(messages[i]);
  }
  ASPx.ShowKBErrorMessage("Please check the correctness of script registration on the page. For details, see ", "T272309");
 },
 GetErrorMessages: function() {
  var messages = [];
  for (var key in this.commands) {
   if (this.commands.hasOwnProperty(key)) {
    var message = this.commands[key].GetErrorMessage();
    if (message)
     messages.push(message);
   }
  }
  return messages;
 }
});
ExternalScriptProcessor.Instance = null;
ExternalScriptProcessor.getInstance = function() {
 if(!ExternalScriptProcessor.Instance)
  ExternalScriptProcessor.Instance = new ExternalScriptProcessor();
 return ExternalScriptProcessor.Instance;
};
ASPx.ExternalScriptProcessor = ExternalScriptProcessor;
})();
(function module(ASPx) {
ASPx.modules.Controls = module;
var ASPxClientBeginCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(command){
  this.constructor.prototype.constructor.call(this);
  this.command = command;
 }
});
var ASPxClientGlobalBeginCallbackEventArgs = ASPx.CreateClass(ASPxClientBeginCallbackEventArgs, {
 constructor: function(control, command){
  this.constructor.prototype.constructor.call(this, command);
  this.control = control;
 }
});
var ASPxClientEndCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(command){
  this.constructor.prototype.constructor.call(this);
  this.command = command;
 }
});
var ASPxClientGlobalEndCallbackEventArgs = ASPx.CreateClass(ASPxClientEndCallbackEventArgs, {
 constructor: function(control){
  this.constructor.prototype.constructor.call(this);
  this.control = control;
 }
});
var ASPxClientCustomDataCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(result) {
  this.constructor.prototype.constructor.call(this);
  this.result = result;
 }
});
var ASPxClientCallbackErrorEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function (message, callbackId) {
  this.constructor.prototype.constructor.call(this);
  this.message = message;
  this.handled = false;
  this.callbackId = callbackId;
 }
});
var ASPxClientGlobalCallbackErrorEventArgs = ASPx.CreateClass(ASPxClientCallbackErrorEventArgs, {
 constructor: function (control, message, callbackId) {
  this.constructor.prototype.constructor.call(this, message, callbackId);
  this.control = control;
 }
});
var ASPxClientValidationCompletedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function (container, validationGroup, invisibleControlsValidated, isValid, firstInvalidControl, firstVisibleInvalidControl) {
  this.constructor.prototype.constructor.call(this);
  this.container = container;
  this.validationGroup = validationGroup;
  this.invisibleControlsValidated = invisibleControlsValidated;
  this.isValid = isValid;
  this.firstInvalidControl = firstInvalidControl;
  this.firstVisibleInvalidControl = firstVisibleInvalidControl;
 }
});
var ASPxClientControlsInitializedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(isCallback) {
  this.isCallback = isCallback;
 }
});
var ASPxClientControlBeforePronounceEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(messageParts, control){
  this.constructor.prototype.constructor.call(this);
  this.messageParts = messageParts;
  this.control = control;
 }
});
var ASPxClientControlUnloadEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(control){
  this.constructor.prototype.constructor.call(this);
  this.control = control;
 }
});
var ASPxClientEndFocusEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(item) {
  this.constructor.prototype.constructor.call(this);
  this.item = item;
 }
});
var ASPxClientItemFocusedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(item) {
  this.constructor.prototype.constructor.call(this);
  this.item = item;
 }
});
var BeforeInitCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(callbackOwnerID){
  this.constructor.prototype.constructor.call(this);
  this.callbackOwnerID = callbackOwnerID;
 }
});
var ASPxClientBrowserWindowResizedInternalEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(eventInfo) {
  this.constructor.prototype.constructor.call(this);
  this.htmlEvent = eventInfo.htmlEvent;
  this.windowClientWidth = eventInfo.wndWidth;
  this.windowClientHeigth = eventInfo.wndHeight;
  this.previousWindowClientWidth = eventInfo.prevWndWidth;
  this.previousWindowClientHeight = eventInfo.prevWndHeight;
  this.virtualKeyboardShownOnAndroid = eventInfo.virtualKeyboardShownOnAndroid;
 }
});
ASPx.createControl = function(type, name, windowName, properties, events, setupMethod, data){
 var globalName = windowName && windowName.length > 0 ? windowName : name;
 var dxo = new type(name);
 var haveWrapper = ASPx.Platform === "NETCORE" && dxo.createWrapper && !DevExpress.AspNetCore.Internal.BackwardCompatibility.useLegacyClientAPI;
 if(haveWrapper) {
  window[globalName] = dxo.createWrapper();
  dxo.aspNetCoreWrapperInstance = window[globalName];
 }
 else
  dxo.InitGlobalVariable(globalName);
 if(properties)
  dxo.SetProperties(properties);
 if(events)
  dxo.SetEvents(events);
 if(setupMethod)
  setupMethod.call(dxo);
 if(data)
  dxo.SetData(data);
 dxo.AfterCreate();
};
var ASPxClientControlBase = ASPx.CreateClass(null, {
 constructor: function(name){
  this.name = name;
  this.uniqueID = name;   
  this.globalName = name;
  this.stateObject = null;
  this.needEncodeState = true;
  this.encodeHtml = true;
  this.enabled = true;
  this.clientEnabled = true;
  this.savedClientEnabled = true;
  this.clientVisible = true;
  this.accessibilityCompliant = false;
  this.parseJSPropertiesOnCallbackError = false;
  this.autoPostBack = false;
  this.allowMultipleCallbacks = true;
  this.callBack = null;
  this.enableCallbackAnimation = false;
  this.enableSlideCallbackAnimation = false;
  this.slideAnimationDirection = null;
  this.beginCallbackAnimationProcessing = false;
  this.endCallbackAnimationProcessing = false;
  this.savedCallbackResult = null;
  this.savedCallbacks = null;
  this.isCallbackAnimationPrevented = false;
  this.lpDelay = 300;
  this.lpTimer = -1;
  this.requestCount = 0;
  this.enableSwipeGestures = false;
  this.disableSwipeGestures = false;
  this.supportGestures = false;
  this.repeatedGestureValue = 0;
  this.repeatedGestureCount = 0;
  this.isInitialized = false;
  this.initialFocused = false;
  this.leadingAfterInitCall = ASPxClientControl.LeadingAfterInitCallConsts.None; 
  this.serverEvents = [];
  this.loadingPanelElement = null;
  this.loadingDivElement = null;  
  this.hasPhantomLoadingElements = false;
  this.mainElement = null;
  this.touchUIMouseScroller = null;
  this.hiddenFields = {};
  this.scPrefix = "dx";
  this.callbackHandlersQueue = new ASPx.ControlCallbackHandlersQueue(this);
  this.callbackCommand = {};
  this.currentCallbackID = -1;
  this.InitializeIntersectionObserversManager();
  this.Init = new ASPxClientEvent();
  this.BeginCallback = new ASPxClientEvent();
  this.EndCallback = new ASPxClientEvent();
  this.EndCallbackAnimationStart = new ASPxClientEvent();
  this.CallbackError = new ASPxClientEvent();
  this.CustomDataCallback = new ASPxClientEvent();
  this.BeforePronounce = new ASPxClientEvent();
  this.Unload = new ASPxClientEvent();
  aspxGetControlCollection().Add(this);
 },
 Initialize: function() {
  if(this.callBack != null)
   this.InitializeCallBackData();
  if (this.useCallbackQueue())
   this.callbackQueueHelper = new ASPx.ControlCallbackQueueHelper(this);
  ASPx.AccessibilityUtils.createAccessibleBackgrounds(this);
  if(this.accessibilityCompliant)
   ASPx.AccessibilityPronouncer.EnsureInitialize();
 },
 FinalizeInitialization: function() { },
 InlineInitialize: function() {
  this.savedClientEnabled = this.clientEnabled;
 },
 InitializeGestures: function() {
  if(this.isSwipeGesturesEnabled() && this.supportGestures) {
   ASPx.GesturesHelper.AddSwipeGestureHandler(this.name, 
    function() { return this.GetCallbackAnimationElement(); }.aspxBind(this), 
    function(evt) { return this.CanHandleGestureCore(evt); }.aspxBind(this), 
    function(value) { return this.AllowStartGesture(value); }.aspxBind(this),
    function(value) { return this.StartGesture(); }.aspxBind(this),
    function(value) { return this.AllowExecuteGesture(value); }.aspxBind(this),
    function(value) { this.ExecuteGesture(value); }.aspxBind(this),
    function(value) { this.CancelGesture(value); }.aspxBind(this),
    this.GetDefaultanimationEngineType(),
    this.rtl
   );
   if(ASPx.Browser.MSTouchUI)
    this.touchUIMouseScroller = ASPx.MouseScroller.Create(
     function() { return this.GetCallbackAnimationElement(); }.aspxBind(this),
     function() { return null; },
     function() { return this.GetCallbackAnimationElement(); }.aspxBind(this),
     function(element) { return this.NeedPreventTouchUIMouseScrolling(element); }.aspxBind(this),
     true
    );
  }
 },
 isSwipeGesturesEnabled: function() {
  return !this.disableSwipeGestures && (this.enableSwipeGestures || ASPx.Browser.TouchUI);
 },
 isSlideCallbackAnimationEnabled: function() {
  return this.enableSlideCallbackAnimation || this.isSwipeGesturesEnabled(); 
 },
 InitGlobalVariable: function(varName){
  if(!window) return;
  this.globalName = varName;
  window[varName] = this;
 },
 SetElementDisplay: function(element, value, checkCurrentStyle, makeInline) {
  ASPx.SetElementDisplay(element, value, checkCurrentStyle, makeInline);
 },
 SetProperties: function(properties, obj){
  if(!obj) obj = this;
  var isAspNetCoreWrapperInstanceExist = !!obj.aspNetCoreWrapperInstance;
  for(var name in properties){
   if(!properties.hasOwnProperty(name)) continue;
   obj[name] = properties[name];
   if(isAspNetCoreWrapperInstanceExist && name.indexOf("cp") === 0)
    obj.aspNetCoreWrapperInstance[name] = properties[name]; 
  }
 },
 SetEvents: function(events, obj){
  if(!obj) obj = this;
  for(var name in events){
   if(events.hasOwnProperty(name) && obj[name] && obj[name].AddHandler)
    obj[name].AddHandler(events[name]);
  }
 },
 SetData: function(data){
 },
 useCallbackQueue: function(){
  return false;
 },
 NeedPreventTouchUIMouseScrolling: function(element) {
  return false;
 },
 InitailizeFocus: function() {
  if(this.initialFocused && this.IsVisible())
   this.Focus();
 },
 AfterCreate: function() {
  this.AddDefaultStateControllerItems();
  this.InlineInitialize();
  this.InitializeGestures();
 },
 AfterInitialize: function() {
  this.initializeAriaDescriptor();
  this.InitailizeFocus();
  this.isInitialized = true;
  this.RaiseInit();
  if(this.savedCallbacks) {
   for(var i = 0; i < this.savedCallbacks.length; i++) 
    this.CreateCallbackInternal(this.savedCallbacks[i].arg, this.savedCallbacks[i].command, 
     false, this.savedCallbacks[i].callbackInfo);
   this.savedCallbacks = null;
  }
 },
 InitializeCallBackData: function() {
 },
 AtlasPreInitialize: function() {
 },
 AtlasInitialize: function() {
 },
 IsDOMDisposed: function() { 
  return !ASPx.IsExistsElement(this.GetMainElement());
 },
 initializeAriaDescriptor: function() {
  if(this.ariaDescription) {
   var descriptionObject = ASPx.Json.Eval(this.ariaDescription);
   if(descriptionObject) {
    this.ariaDescriptor = new AriaDescriptor(this, descriptionObject);
    this.applyAccessibilityAttributes(this.ariaDescriptor); 
   }
  }
 },
 applyAccessibilityAttributes: function() { },
 setAriaDescription: function(selector, argsList) {
  if(this.ariaDescriptor)
   this.ariaDescriptor.setDescription(selector, argsList || [[]]);
 },
 allowRestoreFocusOnCallbacks: function(){
  return this.accessibilityCompliant;
 },
 HtmlEncode: function(text) {
  return this.encodeHtml ? ASPx.Str.EncodeHtml(text) : text;
 },
 IsServerEventAssigned: function(eventName){
  return ASPx.Data.ArrayIndexOf(this.serverEvents, eventName) >= 0;
 },
 OnPost: function(args){
  this.SerializeStateHiddenField();
 },
 SerializeStateHiddenField: function() {
  this.UpdateStateObject();
  if(this.stateObject != null)
   this.UpdateStateHiddenField();
 },
 OnPostFinalization: function(args){
 },
 UpdateStateObject: function(){
 },
 UpdateStateObjectWithObject: function(obj){
  if(!obj) return;
  if(!this.stateObject)
   this.stateObject = { };
  for(var key in obj)
   if(obj.hasOwnProperty(key))
    this.stateObject[key] = obj[key];
 },
 UpdateStateHiddenField: function() {
  var stateHiddenField = this.GetStateHiddenField();
  if(stateHiddenField) {
   var stateObjectStr = ASPx.Json.ToJson(this.stateObject, !this.needEncodeState);
   stateHiddenField.value = this.needEncodeState ? ASPx.Str.EncodeHtml(stateObjectStr) : stateObjectStr;
  }
 },
 GetStateHiddenField: function() {
  return this.GetHiddenField(this.GetStateHiddenFieldName(), this.GetStateHiddenFieldID(), 
   this.GetStateHiddenFieldParent(), this.GetStateHiddenFieldOrigin());
 },
 GetStateHiddenFieldName: function() {
  return this.uniqueID;
 },
 GetStateHiddenFieldID: function() {
  return this.name + "_State";
 },
 GetStateHiddenFieldOrigin: function() {
  return this.GetMainElement();
 },
 GetStateHiddenFieldParent: function() {
  var element = this.GetStateHiddenFieldOrigin();
  return element ? element.parentNode : null;
 },
 GetHiddenField: function(name, id, parent, beforeElement) {
  var hiddenField = this.hiddenFields[id];
  if(!hiddenField || !ASPx.IsValidElement(hiddenField)) {
   if(parent) {
    var existingHiddenField = ASPx.GetElementById(this.GetStateHiddenFieldID());
    this.hiddenFields[id] = hiddenField = existingHiddenField || ASPx.CreateHiddenField(name, id);
    if(existingHiddenField)
     return existingHiddenField;
    if(beforeElement)
     parent.insertBefore(hiddenField, beforeElement);
    else
     parent.appendChild(hiddenField);
   }
  }
  return hiddenField;
 },
 GetChildElement: function(idPostfix){
  var mainElement = this.GetMainElement();
  if(idPostfix.charAt && idPostfix.charAt(0) !== "_")
   idPostfix = "_" + idPostfix;
  return mainElement ? ASPx.CacheHelper.GetCachedChildById(this, mainElement, this.name + idPostfix) : null;
 },
 getChildControl: function(idPostfix) {
  var result = null;
  var childControlId = this.getChildControlUniqueID(idPostfix);
  ASPx.GetControlCollection().ProcessControlsInContainer(this.GetMainElement(), function(control) {
   if(control.uniqueID == childControlId)
    result = control;
  });
  return result;  
 },
 getChildControlUniqueID: function(idPostfix) {
  idPostfix = idPostfix.split("_").join("$");
  if(idPostfix.charAt && idPostfix.charAt(0) !== "$")
   idPostfix = "$" + idPostfix;
  return this.uniqueID + idPostfix;  
 },
 getInnerControl: function(idPostfix) {
  var name = this.name + idPostfix;
  var result = window[name];
  return result && Ident.IsASPxClientControl(result)
   ? result
   : null;
 },
 GetParentForm: function(){
  return ASPx.GetParentByTagName(this.GetMainElement(), "FORM");
 },
 GetMainElement: function(){
  if(!ASPx.IsExistsElement(this.mainElement))
   this.mainElement = ASPx.GetElementById(this.GetMainElementId());
  return this.mainElement;
 },
 GetMainElementId: function() {
  return this.name;
 },
 IsLoadingContainerVisible: function(){
  return this.IsVisible();
 },
 GetLoadingPanelElement: function(){
  return ASPx.GetElementById(this.name + "_LP");
 },
 GetClonedLoadingPanel: function(){
  return document.getElementById(this.GetLoadingPanelElement().id + "V"); 
 },
 CloneLoadingPanel: function(element, parent) {
  var clone = element.cloneNode(true);
  clone.id = element.id + "V";
  parent.appendChild(clone);
  return clone;
 },
 CreateLoadingPanelWithoutBordersInsideContainer: function(container) {
  var loadingPanel = this.CreateLoadingPanelInsideContainer(container, false, true, true);
  var contentStyle = ASPx.GetCurrentStyle(container);
  if(!loadingPanel || !contentStyle)
   return;
  var elements = [ ];
  var table = (loadingPanel.tagName == "TABLE") ? loadingPanel : ASPx.GetNodeByTagName(loadingPanel, "TABLE", 0);
  if(table != null)
   elements.push(table);
  else
   elements.push(loadingPanel);
  var cells = ASPx.GetNodesByTagName(loadingPanel, "TD");
  if(!cells) cells = [ ];
  for(var i = 0; i < cells.length; i++)
   elements.push(cells[i]);
  for(var i = 0; i < elements.length; i++) {
   var el = elements[i];
   el.style.backgroundColor = contentStyle.backgroundColor;
   ASPx.RemoveBordersAndShadows(el);
  }
 },
 CreateLoadingPanelInsideContainer: function(parentElement, hideContent, collapseHeight, collapseWidth) {
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  var element = this.GetLoadingPanelElement();
  if(element != null){
   var width = collapseWidth ? 0 : ASPx.GetClearClientWidth(parentElement);
   var height = collapseHeight ? 0 : ASPx.GetClearClientHeight(parentElement);
   if(hideContent){
    for(var i = parentElement.childNodes.length - 1; i > -1; i--){
     if(parentElement.childNodes[i].style)
      parentElement.childNodes[i].style.display = "none";
     else if(parentElement.childNodes[i].nodeType == 3) 
      parentElement.removeChild(parentElement.childNodes[i]);
    }
   }
   else
    parentElement.innerHTML = "";
   var table = document.createElement("TABLE");
   parentElement.appendChild(table);
   table.border = 0;
   table.cellPadding = 0;
   table.cellSpacing = 0;
   ASPx.SetStyles(table, {
    width: (width > 0) ? width : "100%",
    height: (height > 0) ? height : "100%"
   });
   var tbody = document.createElement("TBODY");
   table.appendChild(tbody);
   var tr = document.createElement("TR");
   tbody.appendChild(tr);
   var td = document.createElement("TD");
   tr.appendChild(td);
   td.align = "center";
   td.vAlign = "middle";
   element = this.CloneLoadingPanel(element, td);
   ASPx.SetElementDisplay(element, true);
   this.loadingPanelElement = element;
   return element;
  } else
   parentElement.innerHTML = "&nbsp;";
  return null;
 },
 CreateLoadingPanelWithAbsolutePosition: function(parentElement, offsetElement) {
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  if(!offsetElement)
   offsetElement = parentElement;
  var element = this.GetLoadingPanelElement();
  if(element != null) {
   element = this.CloneLoadingPanel(element, parentElement);
   ASPx.SetStyles(element, {
    position: "absolute"
   });
   ASPx.SetElementDisplay(element, true);
   ASPx.Evt.AttachEventToElement(element, ASPx.Evt.GetMouseWheelEventName(), ASPx.Evt.PreventEvent);
   this.SetLoadingPanelLocation(offsetElement, element);
   this.loadingPanelElement = element;
   return element;
  }
  return null;
 },
 CreateLoadingPanelInline: function(parentElement, centerInParent){
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  var element = this.GetLoadingPanelElement();
  if(element != null) {
   element = this.CloneLoadingPanel(element, parentElement);
   if(centerInParent){
    ASPx.SetElementDisplay(element, true);
    parentElement.style.textAlign = "center";
   }
   else
    ASPx.SetElementDisplay(element, true);
   this.loadingPanelElement = element;
   return element;
  }
  return null;
 },
 ShowLoadingPanel: function() {
 },
 ShowLoadingElements: function() {
  if(this.InCallback() || this.lpTimer > -1) return;
  this.ShowLoadingDiv();
  if(this.IsCallbackAnimationEnabled())
   this.StartBeginCallbackAnimation();
  else
   this.ShowLoadingElementsInternal();
 },
 ShowLoadingElementsInternal: function() {
  if(this.lpDelay > 0 && !this.IsCallbackAnimationEnabled()) 
   this.lpTimer = window.setTimeout(function() { 
    this.ShowLoadingPanelOnTimer(); 
   }.aspxBind(this), this.lpDelay);
  else {
   this.RestoreLoadingDivOpacity();
   this.ShowLoadingPanel();
  }
 },
 GetLoadingPanelOffsetElement: function (baseElement) {
  if(this.IsCallbackAnimationEnabled()) {
   var element = this.GetLoadingPanelCallbackAnimationOffsetElement();
   if(element) {
    var container = typeof(ASPx.AnimationHelper) != "undefined" ? ASPx.AnimationHelper.findSlideAnimationContainer(element) : null;
    if(container)
     return container.parentNode.parentNode;
    else
     return element;
   }
  }
  return baseElement;
 },
 GetLoadingPanelCallbackAnimationOffsetElement: function () {
  return this.GetCallbackAnimationElement();
 },
 IsCallbackAnimationEnabled: function () {
  return (this.enableCallbackAnimation || this.isSlideCallbackAnimationEnabled()) && !this.isCallbackAnimationPrevented;
 },
 GetDefaultanimationEngineType: function() {
  return ASPx.AnimationEngineType.DEFAULT;
 },
 StartBeginCallbackAnimation: function () {
  this.beginCallbackAnimationProcessing = true;
  this.isCallbackFinished = false;
  var element = this.GetCallbackAnimationElement();
  if (element && this.isSlideCallbackAnimationEnabled() && this.slideAnimationDirection)
   ASPx.AnimationHelper.slideOut(element, this.slideAnimationDirection, this.FinishBeginCallbackAnimation.aspxBind(this), this.GetDefaultanimationEngineType(), this.rtl);
  else if(element && this.enableCallbackAnimation) 
   ASPx.AnimationHelper.fadeOut(element, this.FinishBeginCallbackAnimation.aspxBind(this), null, ASPx.AnimationEngineType.JS);
  else
   this.FinishBeginCallbackAnimation();
 },
 CancelBeginCallbackAnimation: function() {
  if(this.beginCallbackAnimationProcessing) {
   this.beginCallbackAnimationProcessing = false;
   var element = this.GetCallbackAnimationElement();
   ASPx.AnimationHelper.cancelAnimation(element);
  }
 },
 FinishBeginCallbackAnimation: function () {
  this.beginCallbackAnimationProcessing = false;
  if(!this.isCallbackFinished)
   this.ShowLoadingElementsInternal();
  else {
   this.DoCallback(this.savedCallbackResult);
   this.savedCallbackResult = null;
  }
 },
 CheckBeginCallbackAnimationInProgress: function(callbackResult) {
  if(this.beginCallbackAnimationProcessing) {
   this.savedCallbackResult = callbackResult;
   this.isCallbackFinished = true;
   return true;
  }
  return false;
 },
 StartEndCallbackAnimation: function () {
  this.HideLoadingPanel();
  this.SetInitialLoadingDivOpacity();
  this.RaiseEndCallbackAnimationStart();
  this.endCallbackAnimationProcessing = true;
  var element = this.GetCallbackAnimationElement();
  if(element && this.isSlideCallbackAnimationEnabled() && this.slideAnimationDirection) 
   ASPx.AnimationHelper.slideIn(element, this.slideAnimationDirection, this.FinishEndCallbackAnimation.aspxBind(this), this.GetDefaultanimationEngineType(), this.rtl);
  else if(element && this.enableCallbackAnimation) 
   ASPx.AnimationHelper.fadeIn(element, this.FinishEndCallbackAnimation.aspxBind(this), null, ASPx.AnimationEngineType.JS);
  else
   this.FinishEndCallbackAnimation();
  this.slideAnimationDirection = null;
 },
 FinishEndCallbackAnimation: function () {
  this.DoEndCallback();
  this.endCallbackAnimationProcessing = false;
  this.CheckRepeatGesture();
 },
 CheckEndCallbackAnimationNeeded: function() {
  if(!this.endCallbackAnimationProcessing && this.requestCount == 1) {
   this.StartEndCallbackAnimation();
   return true;
  }
  return false;
 },
 PreventCallbackAnimation: function() {
  this.isCallbackAnimationPrevented = true;
 },
 GetCallbackAnimationElement: function() {
  return null;
 },
 AssignSlideAnimationDirectionByPagerArgument: function(arg, currentPageIndex) {
  this.slideAnimationDirection = null;
  if(this.isSlideCallbackAnimationEnabled() && typeof(ASPx.AnimationHelper) != "undefined") {
   if(arg == PagerCommands.Next || arg == PagerCommands.Last)
    this.slideAnimationDirection = ASPx.AnimationHelper.SLIDE_LEFT_DIRECTION;
   else if(arg == PagerCommands.First || arg == PagerCommands.Prev)
    this.slideAnimationDirection = ASPx.AnimationHelper.SLIDE_RIGHT_DIRECTION;
   else if(!isNaN(currentPageIndex) && arg.indexOf(PagerCommands.PageNumber) == 0) {
    var newPageIndex = parseInt(arg.substring(2));
    if (!isNaN(newPageIndex)) {
     var leftDir = this.rtl ? ASPx.AnimationHelper.SLIDE_LEFT_DIRECTION : ASPx.AnimationHelper.SLIDE_RIGHT_DIRECTION;
     var rightDir = this.rtl ? ASPx.AnimationHelper.SLIDE_RIGHT_DIRECTION : ASPx.AnimationHelper.SLIDE_LEFT_DIRECTION;
     this.slideAnimationDirection = newPageIndex < currentPageIndex ? leftDir : rightDir;
    }
   }
  }
 },
 TryShowPhantomLoadingElements: function () {
  if(this.hasPhantomLoadingElements && this.InCallback()) {
   this.hasPhantomLoadingElements = false;
   this.ShowLoadingDivAndPanel();
  }
 },
 ShowLoadingDivAndPanel: function () {
  this.ShowLoadingDiv();
  this.RestoreLoadingDivOpacity();
  this.ShowLoadingPanel();
 },
 HideLoadingElements: function() {
  this.CancelBeginCallbackAnimation();
  this.HideLoadingPanel();
  this.HideLoadingDiv();
 },
 ShowLoadingPanelOnTimer: function() {
  this.ClearLoadingPanelTimer();
  if(!this.IsDOMDisposed()) {
   this.RestoreLoadingDivOpacity();
   this.ShowLoadingPanel();
  }
 },
 ClearLoadingPanelTimer: function() {
  this.lpTimer = ASPx.Timer.ClearTimer(this.lpTimer);  
 },
 HideLoadingPanel: function() {
  this.ClearLoadingPanelTimer();
  this.hasPhantomLoadingElements = false;
  if(ASPx.IsExistsElement(this.loadingPanelElement)) {
   ASPx.RemoveElement(this.loadingPanelElement);
   this.loadingPanelElement = null;
  }
 },
 SetLoadingPanelLocation: function(offsetElement, loadingPanel, x, y, offsetX, offsetY) {
  if(!ASPx.IsExists(x) || !ASPx.IsExists(y)){
   var x1 = ASPx.GetAbsoluteX(offsetElement);
   var y1 = ASPx.GetAbsoluteY(offsetElement);
   var x2 = x1;
   var y2 = y1;
   if(offsetElement == document.body) {
    x1 = 0;
    y1 = 0;
    x2 = ASPx.GetDocumentMaxClientWidth();
    y2 = ASPx.GetDocumentMaxClientHeight();
   }
   else{
    x2 += offsetElement.offsetWidth;
    y2 += offsetElement.offsetHeight;
   }
   if(x1 < ASPx.GetDocumentScrollLeft())
    x1 = ASPx.GetDocumentScrollLeft();
   if(y1 < ASPx.GetDocumentScrollTop())
    y1 = ASPx.GetDocumentScrollTop();
   if(x2 > ASPx.GetDocumentScrollLeft() + ASPx.GetDocumentClientWidth())
    x2 = ASPx.GetDocumentScrollLeft() + ASPx.GetDocumentClientWidth();
   if(y2 > ASPx.GetDocumentScrollTop() + ASPx.GetDocumentClientHeight())
    y2 = ASPx.GetDocumentScrollTop() + ASPx.GetDocumentClientHeight();
   x = x1 + ((x2 - x1 - loadingPanel.offsetWidth) / 2);
   y = y1 + ((y2 - y1 - loadingPanel.offsetHeight) / 2);
  }
  if(ASPx.IsExists(offsetX) && ASPx.IsExists(offsetY)){
   x += offsetX;
   y += offsetY;
  }
  x = ASPx.PrepareClientPosForElement(x, loadingPanel, true);
  y = ASPx.PrepareClientPosForElement(y, loadingPanel, false);
  if(ASPx.Browser.IE && ASPx.Browser.Version > 8) {
   x = Math.round(x);
   y = Math.round(y);
  }
  ASPx.SetStyles(loadingPanel, { left: x, top: y });
 },
 GetLoadingDiv: function(){
  return ASPx.GetElementById(this.name + "_LD");
 },
 CreateLoadingDiv: function(parentElement, offsetElement){
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingDiv();
  if(parentElement == null) 
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  if(!offsetElement)
   offsetElement = parentElement;
  var div = this.GetLoadingDiv();
  if(div != null){
   div = div.cloneNode(true);
   parentElement.appendChild(div);
   ASPx.SetElementDisplay(div, true);
   ASPx.Evt.AttachEventToElement(div, ASPx.TouchUIHelper.touchMouseDownEventName, ASPx.Evt.PreventEvent);
   ASPx.Evt.AttachEventToElement(div, ASPx.TouchUIHelper.touchMouseMoveEventName, ASPx.Evt.PreventEvent);
   ASPx.Evt.AttachEventToElement(div, ASPx.TouchUIHelper.touchMouseUpEventName, ASPx.Evt.PreventEvent);
   ASPx.Evt.AttachEventToElement(div, ASPx.Evt.GetMouseWheelEventName(), ASPx.Evt.PreventEvent);
   this.SetLoadingDivBounds(offsetElement, div);
   this.loadingDivElement = div;
   this.SetInitialLoadingDivOpacity();
   return div;
  }
  return null;
 },
 SetInitialLoadingDivOpacity: function() {
  if(!this.loadingDivElement) return;
  ASPx.Attr.SaveStyleAttribute(this.loadingDivElement, "opacity");
  ASPx.Attr.SaveStyleAttribute(this.loadingDivElement, "filter");
  ASPx.SetElementOpacity(this.loadingDivElement, 0.01);
 },
 RestoreLoadingDivOpacity: function() {
  if(!this.loadingDivElement) return;
  ASPx.Attr.RestoreStyleAttribute(this.loadingDivElement, "opacity");
  ASPx.Attr.RestoreStyleAttribute(this.loadingDivElement, "filter");
 },
 SetLoadingDivBounds: function(offsetElement, loadingDiv) {
  var absX = (offsetElement == document.body) ? 0 : ASPx.GetAbsoluteX(offsetElement);
  var absY = (offsetElement == document.body) ? 0 : ASPx.GetAbsoluteY(offsetElement);
  ASPx.SetStyles(loadingDiv, {
   left: ASPx.PrepareClientPosForElement(absX, loadingDiv, true),
   top: ASPx.PrepareClientPosForElement(absY, loadingDiv, false)
  });
  var width = (offsetElement == document.body) ? ASPx.GetDocumentWidth() : offsetElement.offsetWidth;
  var height = (offsetElement == document.body) ? ASPx.GetDocumentHeight() : offsetElement.offsetHeight;
  if(height < 0) 
   height = 0;
  ASPx.SetStyles(loadingDiv, { width: width, height: height });
  var correctedWidth = 2 * width - loadingDiv.offsetWidth;
  if(correctedWidth <= 0) correctedWidth = width;
  var correctedHeight = 2 * height - loadingDiv.offsetHeight;
  if(correctedHeight <= 0) correctedHeight = height;
  ASPx.SetStyles(loadingDiv, { width: correctedWidth, height: correctedHeight });
 },
 ShowLoadingDiv: function() {
 },
 HideLoadingDiv: function() {
  this.hasPhantomLoadingElements = false;
  if(ASPx.IsExistsElement(this.loadingDivElement)){
   ASPx.RemoveElement(this.loadingDivElement);
   this.loadingDivElement = null;
  }
 },
 CanHandleGesture: function(evt) {
  return false;
 },
 CanHandleGestureCore: function(evt) {
  var source = ASPx.Evt.GetEventSource(evt);
  if(ASPx.GetIsParent(this.loadingPanelElement, source) || ASPx.GetIsParent(this.loadingDivElement, source))
   return true; 
  var callbackAnimationElement = this.GetCallbackAnimationElement();
  if(!callbackAnimationElement)
   return false;
  var animationContainer = ASPx.AnimationHelper.getSlideAnimationContainer(callbackAnimationElement, false, false);
  if(animationContainer && ASPx.GetIsParent(animationContainer, source) && !ASPx.GetIsParent(animationContainer.childNodes[0], source))
   return true; 
  return this.CanHandleGesture(evt); 
 },
 AllowStartGesture: function() {
  return !this.beginCallbackAnimationProcessing && !this.endCallbackAnimationProcessing;
 },
 StartGesture: function() {
 },
 AllowExecuteGesture: function(value) {
  return false;
 },
 ExecuteGesture: function(value) {
 },
 CancelGesture: function(value) {
  if(this.repeatedGestureCount === 0) {
   this.repeatedGestureValue = value;
   this.repeatedGestureCount = 1;
  }
  else {
   if(this.repeatedGestureValue * value > 0)
    this.repeatedGestureCount++;
   else
    this.repeatedGestureCount--;
   if(this.repeatedGestureCount === 0)
    this.repeatedGestureCount = 0;
  }
 },
 CheckRepeatGesture: function() {
  if(this.repeatedGestureCount !== 0) {
   if(this.AllowExecuteGesture(this.repeatedGestureValue))
    this.ExecuteGesture(this.repeatedGestureValue, this.repeatedGestureCount);
   this.repeatedGestureValue = 0;
   this.repeatedGestureCount = 0;
  }
 },
 AllowExecutePagerGesture: function (pageIndex, pageCount, value) {
  if(pageIndex < 0) return false;
  if(pageCount <= 1) return false;
  if(value > 0 && pageIndex === 0) return false;
  if(value < 0 && pageIndex === pageCount - 1) return false;
  return true;
 },
 ExecutePagerGesture: function(pageIndex, pageCount, value, count, method) {
  if(!count) count = 1;
  var pageIndex = pageIndex + (value < 0 ? count : -count);
  if(pageIndex < 0) pageIndex = 0;
  if(pageIndex > pageCount - 1) pageIndex = pageCount - 1;
  method(PagerCommands.PageNumber + pageIndex);
 },
 RaiseInit: function(){
  if(!this.Init.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.Init.FireEvent(this, args);
  }
 },
 RaiseBeginCallbackInternal: function(command){
  if(!this.BeginCallback.IsEmpty()){
   var args = new ASPxClientBeginCallbackEventArgs(command);
   this.BeginCallback.FireEvent(this, args);
  }
 },
 RaiseEndCallbackInternal: function(command) {
  if(!this.EndCallback.IsEmpty()){
   var args = new ASPxClientEndCallbackEventArgs(command);
   this.EndCallback.FireEvent(this, args);
  }
 },
 RaiseCallbackErrorInternal: function(message, callbackId) {
  if(!this.CallbackError.IsEmpty()) {
   var args = new ASPxClientCallbackErrorEventArgs(message, callbackId);
   this.CallbackError.FireEvent(this, args);
   if(args.handled)
    return { isHandled: true, errorMessage: args.message };
  }
 },
 RaiseBeginCallback: function(command){
  this.RaiseBeginCallbackInternal(command);    
  aspxGetControlCollection().RaiseBeginCallback(this, command);
 },
 RaiseEndCallback: function(command){
  this.RaiseEndCallbackInternal(command);
  aspxGetControlCollection().RaiseEndCallback(this, command);
 },
 RaiseCallbackError: function (message, callbackId) {
  var result = this.RaiseCallbackErrorInternal(message, callbackId);
  if(!result) 
   result = aspxGetControlCollection().RaiseCallbackError(this, message, callbackId);
  return result;
 },
 RaiseEndCallbackAnimationStart: function(){
  if(!this.EndCallbackAnimationStart.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.EndCallbackAnimationStart.FireEvent(this, args);
  }
 },
 RaiseBeforePronounce: function(message) {
  var args = new ASPxClientControlBeforePronounceEventArgs(message, this);
  if(!this.BeforePronounce.IsEmpty())
   this.BeforePronounce.FireEvent(this, args);
  return args;
 },
 RaiseUnload: function() {
  var args = new ASPxClientControlUnloadEventArgs(this);
  if(!this.Unload.IsEmpty())
   this.Unload.FireEvent(this, args);
 },
 SendMessageToAssistiveTechnology: function(message) {
  if(!this.accessibilityCompliant)
   return;
  this.PronounceMessageInternal(message, ASPx.AccessibilityPronouncerType.live);
 },
 PronounceMessageInternal: function(messageArg, type) {
  var message = messageArg;
  if(!ASPx.Ident.IsArray(messageArg))
   message = [messageArg];
  var args = this.RaiseBeforePronounce(message);
  ASPx.AccessibilityPronouncer.Pronounce(args, type);
 },
 IsVisible: function() {
  var element = this.GetMainElement();
  return ASPx.IsElementVisible(element);
 },
 IsDisplayedElement: function(element) {
  while(element && element.tagName != "BODY") {
   if(!ASPx.GetElementDisplay(element)) 
    return false;
   element = element.parentNode;
  }
  return true;
 },
 IsDisplayed: function() {
  return this.IsDisplayedElement(this.GetMainElement());
 },
 IsHiddenElement: function(element) {
  return element && element.offsetWidth == 0 && element.offsetHeight == 0;
 },
 IsHidden: function() {
  return this.IsHiddenElement(this.GetMainElement());
 },
 IsDisposed: function() {
  return this.disposed;
 },
 GetParentControl: function() {
  var mainElement = this.getActualMainElement();
  var popupPostfix = ASPx.PCWIdSuffix + "-1";
  var result = null;
  ASPx.GetParent(mainElement, function(element) {
   if(element === mainElement || !element.id)
    return false;
   var controlName = element.id.replace(popupPostfix, "");
   result = ASPx.GetControlCollection().Get(controlName);
   return !!result;
  });
  return result;
 },
 getActualMainElement: function() { return this.GetMainElement(); },
 findParentByType: function (type) {
  var ctrl = this;
  while (ctrl) {
   var parent = ctrl.GetParentControl();
   if (parent && parent instanceof type)
    return parent;
   ctrl = parent;
  }
  return null;
 },
 Focus: function() {
 },
 GetClientVisible: function(){
  return this.GetVisible();
 },
 SetClientVisible: function(visible){
  this.SetVisible(visible);
 },
 GetVisible: function(){
  return this.clientVisible;
 },
 SetVisible: function(visible){
  if(this.clientVisible != visible){
   this.clientVisible = visible;
   ASPx.SetElementDisplay(this.GetMainElement(), visible);
   if(visible) {
    this.AdjustControl();
    var mainElement = this.GetMainElement();
    if(mainElement)
     aspxGetControlCollection().AdjustControls(mainElement);
   }
  }
 },
 GetEnabled: function() {
  return this.clientEnabled;
 },
 SetEnabled: function(enabled) {
  this.clientEnabled = enabled;
  if(ASPxClientControl.setEnabledLocked)
   return;
  else
   ASPxClientControl.setEnabledLocked = true;
  this.savedClientEnabled = enabled;
  aspxGetControlCollection().ProcessControlsInContainer(this.GetMainElement(), function(control) {
   if(ASPx.IsFunction(control.SetEnabled))
    control.SetEnabled(enabled && control.savedClientEnabled);
  });
  delete ASPxClientControl.setEnabledLocked;
 },
 InCallback: function() {
  return this.requestCount > 0;
 },
 DoBeginCallback: function(command) {
  this.RaiseBeginCallback(command || "");
  aspxGetControlCollection().Before_WebForm_InitCallback(this.name);
  if(typeof(WebForm_InitCallback) != "undefined" && WebForm_InitCallback) {
   __theFormPostData = "";
   __theFormPostCollection = [ ];
   this.ClearPostBackEventInput("__EVENTTARGET");
   this.ClearPostBackEventInput("__EVENTARGUMENT");
   WebForm_InitCallback();
   this.savedFormPostData = __theFormPostData;   
   this.savedFormPostCollection = __theFormPostCollection;
  }
 },
 ClearPostBackEventInput: function(id){
  var element = ASPx.GetElementById(id);
  if(element != null) element.value = "";
 },
 PerformDataCallback: function(arg, handler) {
  this.CreateCustomDataCallback(arg, "", handler);
 },
 sendCallbackViaQueue: function (prefix, arg, showLoadingPanel, context, handler, onBeforeSend) {
  if (!this.useCallbackQueue())
   return false;
  var context = context || this;
  var token = this.callbackQueueHelper.sendCallback(ASPx.FormatCallbackArg(prefix, arg), context, handler || context.OnCallback, prefix, onBeforeSend);
  if (showLoadingPanel)
   this.callbackQueueHelper.showLoadingElements();
  return token;
 },
 CreateCallback: function (arg, command, handler) {
  var callbackInfo = this.CreateCallbackInfo(ASPx.CallbackType.Common, handler || null);
  var callbackID = this.CreateCallbackByInfo(arg, command, callbackInfo);
  return callbackID;
 },
 CreateCustomDataCallback: function(arg, command, handler) {
  var callbackInfo = this.CreateCallbackInfo(ASPx.CallbackType.Data, handler);
  this.CreateCallbackByInfo(arg, command, callbackInfo);
 },
 CreateCallbackByInfo: function(arg, command, callbackInfo) {
  if(!this.CanCreateCallback()) return;
  var callbackID;
  if(typeof(WebForm_DoCallback) != "undefined" && WebForm_DoCallback && ASPx.documentLoaded || ASPx.Platform === "NETCORE")
   callbackID = this.CreateCallbackInternal(arg, command, true, callbackInfo);
  else {
   if(!this.savedCallbacks)
    this.savedCallbacks = [];
   var callbackInfo = { arg: arg, command: command, callbackInfo: callbackInfo };
   if(this.allowMultipleCallbacks)
    this.savedCallbacks.push(callbackInfo);
   else
    this.savedCallbacks[0] = callbackInfo;
  }
  return callbackID;
 },
 CreateCallbackInternal: function(arg, command, viaTimer, callbackInfo) {
  var watcher = ASPx.ControlUpdateWatcher.getInstance();
  if(watcher && !watcher.CanSendCallback(this, arg)) {
   this.CancelCallbackInternal();
   return;
  }
  this.requestCount++;
  this.DoBeginCallback(command);
  if(typeof(arg) == "undefined")
   arg = "";
  if(typeof(command) == "undefined")
   command = "";
  var callbackID = this.SaveCallbackInfo(callbackInfo, command),
   customArgs = this.GetCustomCallbackArgs();
  if(viaTimer)
   window.setTimeout(function() { this.CreateCallbackCoreWithCustomArgs(arg, command, callbackID, customArgs); }.aspxBind(this), 0);
  else
   this.CreateCallbackCoreWithCustomArgs(arg, command, callbackID, customArgs);
  return callbackID;
 },
 CreateCallbackCoreWithCustomArgs: function(arg, command, callbackID, customArgs) {
  this.CreateCallbackCore(arg, command, callbackID);
 },
 GetCustomCallbackArgs: function() {
  return {};
 },
 CancelCallbackInternal: function() {
  this.CancelCallbackCore();
  this.HideLoadingElements();
 },
 CancelCallbackCore: function() {
 },
 CreateCallbackCore: function(arg, command, callbackID) {
  var callBackMethod = this.GetCallbackMethod(command);
  __theFormPostData = this.savedFormPostData;
  __theFormPostCollection = this.savedFormPostCollection;
  callBackMethod.call(this, this.GetSerializedCallbackInfoByID(callbackID) + arg);
 },
 GetCallbackMethod: function(command){
  return this.callBack;
 },
 CanCreateCallback: function() {
  return !this.InCallback() || (this.allowMultipleCallbacks && !this.beginCallbackAnimationProcessing && !this.endCallbackAnimationProcessing);
 },
 DoLoadCallbackScripts: function() {
  ASPx.ProcessScriptsAndLinks(this.name, true);
 },
 DoEndCallback: function() {
  if(this.IsCallbackAnimationEnabled() && this.CheckEndCallbackAnimationNeeded()) 
   return;
  this.requestCount--;
  if (this.requestCount < 1) 
   this.callbackHandlersQueue.executeCallbacksHandlers();
  if(this.HideLoadingPanelOnCallback() && this.requestCount < 1) 
   this.HideLoadingElements();
  if(this.isSwipeGesturesEnabled() && this.supportGestures) {
   ASPx.GesturesHelper.UpdateSwipeAnimationContainer(this.name);
   if(this.touchUIMouseScroller)
    this.touchUIMouseScroller.update();
  }
  this.isCallbackAnimationPrevented = false;
  this.OnCallbackFinalized();
  this.AssignEllipsisTooltips();
  var command = this.GetCallbackCommand();
  this.RaiseEndCallback(command);
  this.InitializeIntersectionObserversManager();
  this.currentCallbackID = -1;
 },
 DoFinalizeCallback: function() {
 },
 OnCallbackFinalized: function() {
 },
 AssignEllipsisTooltips: function() { },
 GetCallbackCommand: function() {
  var result = "";
  if(this.currentCallbackID != -1) {
   var command = this.callbackCommand[this.currentCallbackID];
   if(command)
    result = command;
  }
  return result;
 },
 HideLoadingPanelOnCallback: function() {
  return true;
 },
 ShouldHideExistingLoadingElements: function() {
  return true;
 },
 EvalCallbackResult: function(resultString){
  return eval(resultString);
 },
 ParseJSProperties: function(resultObj) {
  if(resultObj.cp) {
   for(var name in resultObj.cp)
    if(resultObj.cp.hasOwnProperty(name)) {
     this[name] = resultObj.cp[name];
     if(this.aspNetCoreWrapperInstance)
      this.aspNetCoreWrapperInstance[name] = resultObj.cp[name]; 
    }
  }
 },
 DoCallback: function(result) {
  if(this.IsCallbackAnimationEnabled() && this.CheckBeginCallbackAnimationInProgress(result))
   return;
  result = ASPx.Str.Trim(result);
  if(result.indexOf(ASPx.CallbackResultPrefix) != 0) 
   this.ProcessCallbackGeneralError(result, false);
  else {
   var resultObj = null;
   try {
    resultObj = this.EvalCallbackResult(result);
   } 
   catch(e) {
   }
   if(resultObj) {
    this.currentCallbackID = resultObj.id;
    ASPx.CacheHelper.DropCache(this);
    if(resultObj.redirect) {
     this.ParseJSProperties(resultObj); 
     ASPx.Url.Redirect(resultObj.redirect);
    }
    else if(ASPx.IsExists(resultObj.generalError)) {
     this.ProcessCallbackGeneralError(resultObj.generalError, true);
    }
    else {
     var errorObj = resultObj.error;
     if(errorObj) { 
      if(this.parseJSPropertiesOnCallbackError)
       this.ParseJSProperties(resultObj);
      this.ProcessCallbackError(errorObj,resultObj.id);
     } else {
      this.ParseJSProperties(resultObj);
      var callbackInfo = this.DequeueCallbackInfo(resultObj.id);
      if(callbackInfo && callbackInfo.type == ASPx.CallbackType.Data)
       this.ProcessCustomDataCallback(resultObj.result, callbackInfo);
      else {
       if (this.useCallbackQueue() && this.callbackQueueHelper.getCallbackInfoById(resultObj.id))
        this.callbackQueueHelper.processCallback(resultObj.result, resultObj.id);
       else {
        this.ProcessCallback(resultObj.result, resultObj.id);
        if(callbackInfo && callbackInfo.handler) {
         var handlerInfo = { handler: callbackInfo.handler, result: resultObj.result.data };
         this.callbackHandlersQueue.addCallbackHandler(handlerInfo);
        }
       }
      }
     }
    }
   }
  }
  this.DoLoadCallbackScripts();
 },
 DoCallbackError: function(result) {
  this.HideLoadingElements();
  this.ProcessCallbackGeneralError(result, false); 
 },
 DoControlClick: function(evt) {
  this.OnControlClick(ASPx.Evt.GetEventSource(evt), evt);
 },
 ProcessCallback: function (result, callbackId) {
  this.OnCallback(result, callbackId);
 },
 ProcessCustomDataCallback: function(result, callbackInfo) {
  if(callbackInfo.handler != null)
   callbackInfo.handler(this, result);
  this.RaiseCustomDataCallback(result);
 },
 RaiseCustomDataCallback: function(result) {
  if(!this.CustomDataCallback.IsEmpty()) {
   var arg = new ASPxClientCustomDataCallbackEventArgs(result);
   this.CustomDataCallback.FireEvent(this, arg);
  }
 },
 OnCallback: function(result) {
 },
 CreateCallbackInfo: function(type, handler) {
  return { type: type, handler: handler };
 },
 GetSerializedCallbackInfoByID: function(callbackID) {
  return this.GetCallbackInfoByID(callbackID).type + callbackID + ASPx.CallbackSeparator;
 },
 SaveCallbackInfo: function(info, command) {
  var callbacks = this.GetActiveCallbacksInfo();
  var index = callbacks.indexOf(null);
  if(index === -1)
   index = callbacks.length;
  callbacks[index] = info;
  this.callbackCommand[index] = command;
  return index;
 },
 GetActiveCallbacksInfo: function() {
  var persistentProperties = this.GetPersistentProperties();
  if(!persistentProperties.activeCallbacks)
   persistentProperties.activeCallbacks = [ ];
  return persistentProperties.activeCallbacks;
 },
 GetPersistentProperties: function() {
  var storage = _aspxGetPersistentControlPropertiesStorage();
  var persistentProperties = storage[this.name];
  if(!persistentProperties) {
   persistentProperties = { };
   storage[this.name] = persistentProperties;
  }
  return persistentProperties;
 },
 GetCallbackInfoByID: function(callbackID) {
  return this.GetActiveCallbacksInfo()[callbackID];
 },
 DequeueCallbackInfo: function(index) {
  var activeCallbacksInfo = this.GetActiveCallbacksInfo();
  if(index < 0 || index >= activeCallbacksInfo.length)
   return null;
  var result = activeCallbacksInfo[index];
  activeCallbacksInfo[index] = null;
  return result;
 },
 ProcessCallbackError: function (errorObj, callbackId) {
  var data = ASPx.IsExists(errorObj.data) ? errorObj.data : null;
  var result = this.RaiseCallbackError(errorObj.message, callbackId);
  if(result.isHandled)
   this.OnCallbackErrorAfterUserHandle(result.errorMessage, data); 
  else
   this.OnCallbackError(result.errorMessage, data); 
 },
 OnCallbackError: function(errorMessage, data) {
  if(errorMessage)
   ASPx.ShowErrorAlert(errorMessage);
 },
 OnCallbackErrorAfterUserHandle: function(errorMessage, data) {
 },
 ProcessCallbackGeneralError: function(errorMessage, serverExceptionOnLastCallback) {
  this.serverExceptionOnLastCallback = serverExceptionOnLastCallback;
  var result = this.RaiseCallbackError(errorMessage);
  if(result.isHandled)
   this.OnCallbackGeneralErrorAfterUserHandle(result.errorMessage);
  else
   this.OnCallbackGeneralError(result.errorMessage);
 },
 OnCallbackGeneralError: function(errorMessage) {
  this.OnCallbackError(errorMessage, null);
 },
 OnCallbackGeneralErrorAfterUserHandle: function (errorMessage) {
 },
 SendPostBack: function(params, preventConvertToUpdatePanelCallback) {
  if(preventConvertToUpdatePanelCallback)
   this.sendMSAjaxCompatPostBack(params);
  else
   this.sendPostBackInternal(params);
 },
 sendPostBackInternal: function(params) {
  if(typeof(__doPostBack) != "undefined")
   __doPostBack(this.uniqueID, params);
  else{
   var form = this.GetParentForm();
   if(form) form.submit();
  }
 },
 sendMSAjaxCompatPostBack: function(params) {
  var rm = ASPx.GetMSAjaxRequestManager();
  var triggers = rm ? rm._postBackControlClientIDs : null;
  var needRegister = triggers && ASPx.Ident.IsArray(triggers) && ASPx.Data.ArrayIndexOf(triggers, this.name) == -1;
  if(needRegister)
   triggers.unshift(this.name);
  this.sendPostBackInternal(params);
  if(needRegister)
   triggers.shift();
 },
 IsValidInstance: function () {
  return aspxGetControlCollection().GetByName(this.name) === this;
 },
 OnDispose: function() { 
  var varName = this.globalName;
  if(varName && varName !== "" && window && window[varName] && window[varName] == this){
   try{
    delete window[varName];
   }
   catch(e){  }
  }
  if(this.callbackQueueHelper)
   this.callbackQueueHelper.detachEvents();
  if (!this.IsDisposed())
   this.disposed = true;
 },
 OnGlobalControlsInitialized: function(args) { 
 },
 OnGlobalBrowserWindowResized: function(args) { 
 },
 OnGlobalBeginCallback: function(args) { 
 },
 OnGlobalEndCallback: function(args) { 
 },
 OnGlobalCallbackError: function(args) { 
 },
 OnGlobalValidationCompleted: function(args) { 
 },
 AddDefaultStateControllerItems: function() {
  var states = this.scStates;
  if(!states) return;
  var postfix = this.scPostfix ? ("_" + this.scPostfix) : "";
  var mainElementId = this.GetMainElementId();
  if(states & 2)
   this.AddDefaultReadOnlyStateControllerItem(this.scPrefix + "ReadOnly" + postfix, mainElementId);
  if(states & 4)
   this.AddDefaultDisabledStateControllerItem(this.scPrefix + "Disabled" + postfix, mainElementId);
 },
 AddDefaultReadOnlyStateControllerItem: function(cssClass, mainElementId) { throw "Not implemented"; },
 AddDefaultDisabledStateControllerItem: function(cssClass, mainElementId) { throw "Not implemented"; },
 DOMContentLoaded: function() { },
 IsStateControllerEnabled: function() { return false; },
 InitializeDOM: function() {
  var mainElement = this.GetMainElement();
  if(mainElement)
   ASPx.SetElementInitializedFlag(mainElement);
 },
 IsDOMInitialized: function() {
  var mainElement = this.GetMainElement();
  return mainElement && ASPx.GetElementInitializedFlag(mainElement);
 },
 AdjustControl: function(nestedCall) { },
 OnBrowserWindowResizeInternal: function(e) { },
 RegisterInControlTree: function(tree) { },
 InitializeIntersectionObserversManager: function () {
  var elementToObserve = this.getElementToObserveVisibilityChange();
  if(elementToObserve) {
   ASPx.IntersectionObserversManager.SubscribeElemensVisibilityChangeInBrowserWindow(elementToObserve, this.processVisibilityChanged.bind(this));
  }
 },
 getElementToObserveVisibilityChange: function () { },
 processVisibilityChanged: function (visible) { }
});
ASPxClientControlBase.Cast = function(obj) {
 if(typeof obj == "string")
  return window[obj];
 return obj;
};
var persistentControlPropertiesStorage = null;
function _aspxGetPersistentControlPropertiesStorage() {
 if(persistentControlPropertiesStorage == null)
  persistentControlPropertiesStorage = { };
 return persistentControlPropertiesStorage;
}
var ELLIPSIS_MARKER_CLASS = "dx-ellipsis";
var ELLIPSIS_TOOLTIP_MARKER_ATTR = "dxEllipsisTitle";
var ASPxClientControl = ASPx.CreateClass(ASPxClientControlBase, {
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.rtl = false;
  this.enableEllipsis = false;
  this.isNative = false;
  this.isControlCollapsed = false;
  this.isInsideHierarchyAdjustment = false;
  this.controlOwner = null;
  this.adjustedSizes = { };
  this.dialogContentHashTable = { };
  this.renderIFrameForPopupElements = false;
  this.widthValueSetInPercentage = false;
  this.heightValueSetInPercentage = false;
  this.verticalAlignedElements = { };
  this.wrappedTextContainers = { };
  this.scrollPositionState = { };
  this.sizingConfig = {
   allowSetWidth: true,
   allowSetHeight: true,
   correction : false,
   adjustControl : false,
   supportPercentHeight: false,
   supportAutoHeight: false
  };
  this.percentSizeConfig = {
   width: -1,
   height: -1,
   markerWidth: -1,
   markerHeight: -1
  };  
 },
 querySelector: function(selector) { return this.querySelectorAll(selector)[0] || null; },
 querySelectorAll: function(selector) {
  return ASPx.CacheHelper.GetCachedElement(this, "querySelectorAll_" + selector,
   function() { return Array.prototype.slice.call(this.GetMainElement().querySelectorAll(selector)); });
 },
 createAccessKey: function (popupItem, getPopupElement, keyTipElement, key, onlyClick, manualStopProcessing) {
  return new ASPx.AccessKey(popupItem, getPopupElement, keyTipElement, key, onlyClick, manualStopProcessing);
 },
 InlineInitialize: function() {
  this.InitializeDOM();
  ASPxClientControlBase.prototype.InlineInitialize.call(this);
 },
 AfterCreate: function() { 
  ASPxClientControlBase.prototype.AfterCreate.call(this);
  if(!this.CanInitializeAdjustmentOnDOMContentLoaded() || ASPx.IsStartupScriptsRunning())
   this.InitializeAdjustment();
 },
 DOMContentLoaded: function() {
  if(this.CanInitializeAdjustmentOnDOMContentLoaded()) 
   this.InitializeAdjustment();
 },
 CanInitializeAdjustmentOnDOMContentLoaded: function() {
  return !ASPx.Browser.IE || ASPx.Browser.Version >= 10; 
 },
 InitializeAdjustment: function() {
  this.UpdateAdjustmentFlags();
  this.AdjustControl();
 },
 AfterInitialize: function() {
  this.AdjustControl();
  ASPxClientControlBase.prototype.AfterInitialize.call(this);
 },
 IsStateControllerEnabled: function(){
  return typeof(ASPx.GetStateController) != "undefined" && ASPx.GetStateController();
 },
 GetWidth: function() {
  return this.GetMainElement().offsetWidth;
 },
 GetHeight: function() {
  return this.GetMainElement().offsetHeight;
 },
 SetWidth: function(width) {
  if(this.sizingConfig.allowSetWidth)
   this.SetSizeCore("width", width, "GetWidth", false);
 },
 SetHeight: function(height) {
  if(this.sizingConfig.allowSetHeight)
   this.SetSizeCore("height", height, "GetHeight", false);
 },
 SetSizeCore: function(sizePropertyName, size, getFunctionName, corrected) {
  if(size < 0 || !this.GetMainElement())
   return;
  this.GetMainElement().style[sizePropertyName] = size + "px";
  this.UpdateAdjustmentFlags(sizePropertyName);
  if(this.sizingConfig.adjustControl)
   this.AdjustControl(true);
  if(this.sizingConfig.correction && !corrected) {
   var realSize = this[getFunctionName]();
   if(realSize != size) {
    var correctedSize = size - (realSize - size);
    this.SetSizeCore(sizePropertyName, correctedSize, getFunctionName, true);
   }
  }
 },
 AdjustControl: function(nestedCall) {
  if(this.IsAdjustmentRequired() && (!ASPxClientControl.adjustControlLocked || nestedCall)) {
   ASPxClientControl.adjustControlLocked = true;
   try {
    if(!this.IsAdjustmentAllowed())
     return;
    this.AdjustControlCore();
    this.UpdateAdjustedSizes();
   } 
   finally {
    delete ASPxClientControl.adjustControlLocked;
   }
  }
  this.AssignEllipsisTooltips();
  this.TryShowPhantomLoadingElements();
 },
 ResetControlAdjustment: function () {
  this.adjustedSizes = { };
 },
 UpdateAdjustmentFlags: function(sizeProperty) {
  var mainElement = this.GetMainElement();
  if(mainElement) {
   var mainElementStyle = ASPx.GetCurrentStyle(mainElement);
   this.UpdatePercentSizeConfig([mainElementStyle.width, mainElement.style.width], [mainElementStyle.height, mainElement.style.height], sizeProperty);
  }
 },
 UpdatePercentSizeConfig: function(widths, heights, modifyStyleProperty) {
  switch(modifyStyleProperty) {
   case "width":
    this.UpdatePercentWidthConfig(widths);
    break;
   case "height":
    this.UpdatePercentHeightConfig(heights);
    break;
   default:
    this.UpdatePercentWidthConfig(widths);
    this.UpdatePercentHeightConfig(heights);
    break;
  }
  this.ResetControlPercentMarkerSize();
 },
 UpdatePercentWidthConfig: function(widths) {
  this.widthValueSetInPercentage = false;
  for(var i = 0; i < widths.length; i++) {
   if(this.IsPercentageWidth(widths[i])) {
    this.percentSizeConfig.width = widths[i];
    this.widthValueSetInPercentage = true;
    break;
   }
  }
 },
 IsPercentageWidth: function(width) { return ASPx.IsPercentageSize(width); },
 UpdatePercentHeightConfig: function(heights) {
  this.heightValueSetInPercentage = false;
    for(var i = 0; i < heights.length; i++) {
   if(ASPx.IsPercentageSize(heights[i])) {
    this.percentSizeConfig.height = heights[i];
    this.heightValueSetInPercentage = true;
    break;
   }
  }
 },
 GetAdjustedSizes: function() {
  var mainElement = this.GetMainElement();
  if(mainElement) 
   return { width: mainElement.offsetWidth, height: mainElement.offsetHeight };
  return { width: 0, height: 0 };
 },
 IsAdjusted: function() {
  return (this.adjustedSizes.width && this.adjustedSizes.width > 0) && (this.adjustedSizes.height && this.adjustedSizes.height > 0);
 },
 IsAdjustmentRequired: function() {
  if(!this.IsAdjusted())
   return true;
  if(this.widthValueSetInPercentage)
   return true;
  if(this.heightValueSetInPercentage)
   return true;
  var sizes = this.GetAdjustedSizes();
  for(var name in sizes){
   if(this.adjustedSizes[name] !== sizes[name])
    return true;
  }
  return false;
 },
 IsAdjustmentAllowed: function() {
  var mainElement = this.GetMainElement();
  return mainElement && this.IsDisplayed() && !this.IsHidden() && this.IsDOMInitialized();
 },
 UpdateAdjustedSizes: function() {
  var sizes = this.GetAdjustedSizes();
  for(var name in sizes)
   if(sizes.hasOwnProperty(name))
    this.adjustedSizes[name] = sizes[name];
 },
 AdjustControlCore: function() {
 },
 AdjustAutoHeight: function() {
 },
 IsControlCollapsed: function() {
  return this.isControlCollapsed;
 },
 NeedCollapseControl: function() {
  return this.NeedCollapseControlCore() && this.IsAdjustmentRequired() && this.IsAdjustmentAllowed();
 },
 NeedCollapseControlCore: function() {
  return false;
 },
 CollapseEditor: function() {
 },
 CollapseControl: function() {
  this.SaveScrollPositions();
  var mainElement = this.GetMainElement(),
   marker = this.GetControlPercentSizeMarker();
  marker.style.height = this.heightValueSetInPercentage && this.sizingConfig.supportPercentHeight
   ? this.percentSizeConfig.height 
   : (mainElement.offsetHeight + "px");
  mainElement.style.display = "none";
  this.isControlCollapsed = true;
 },
 ExpandControl: function() {
  var mainElement = this.GetMainElement();
  mainElement.style.display = "";
  this.GetControlPercentSizeMarker().style.height = "0px";
  this.isControlCollapsed = false;
  this.RestoreScrollPositions();
 },
 CanCauseReadjustment: function() {
  return this.NeedCollapseControlCore();
 },
 IsExpandableByAdjustment: function() {
  return false;
 },
 HasFixedPosition: function() {
  return false;
 },
 SaveScrollPositions: function() {
  var mainElement = this.GetMainElement();
  this.scrollPositionState.outer = ASPx.GetOuterScrollPosition(mainElement.parentNode);
  this.scrollPositionState.inner = ASPx.GetInnerScrollPositions(mainElement);
 },
 RestoreScrollPositions: function() {
  ASPx.RestoreOuterScrollPosition(this.scrollPositionState.outer);
  ASPx.RestoreInnerScrollPositions(this.scrollPositionState.inner);
 },
 GetControlPercentSizeMarker: function() {
  if(this.percentSizeMarker === undefined) {
   this.percentSizeMarker = ASPx.CreateHtmlElementFromString("<div style='height:0px;font-size:0px;line-height:0;width:100%;'></div>");
   ASPx.InsertElementAfter(this.percentSizeMarker, this.GetMainElement());
  }
  return this.percentSizeMarker;
 },
 KeepControlPercentSizeMarker: function(needCollapse, needCalculateHeight) {
  var marker = this.GetControlPercentSizeMarker(),
   markerHeight;
  if(needCollapse)
   this.CollapseControl();
  if(this.widthValueSetInPercentage && marker.style.width !== this.percentSizeConfig.width)
   marker.style.width = this.percentSizeConfig.width;
  if(needCalculateHeight) {
   if(this.IsControlCollapsed())
    markerHeight = marker.style.height;
   marker.style.height = this.percentSizeConfig.height;
  }
  this.percentSizeConfig.markerWidth = marker.offsetWidth;
  if(needCalculateHeight) {
   this.percentSizeConfig.markerHeight = marker.offsetHeight;
   if(this.IsControlCollapsed())
    marker.style.height = markerHeight;
   else
    marker.style.height = "0px";
  }
  if(needCollapse)
   this.ExpandControl();
 },
 ResetControlPercentMarkerSize: function() {
  this.percentSizeConfig.markerWidth = -1;
  this.percentSizeConfig.markerHeight = -1;
 },
 GetControlPercentMarkerSize: function(hideControl, force) {
  var needCalculateHeight = this.heightValueSetInPercentage && this.sizingConfig.supportPercentHeight;
  if(force || this.percentSizeConfig.markerWidth < 1 || (needCalculateHeight && this.percentSizeConfig.markerHeight < 1))
   this.KeepControlPercentSizeMarker(hideControl && !this.IsControlCollapsed(), needCalculateHeight);
  return {
   width: this.percentSizeConfig.markerWidth,
   height: this.percentSizeConfig.markerHeight
  };
 },
 AssignEllipsisTooltips: function() {
  if(this.RequireAssignTooltips())
   this.AssignEllipsisTooltipsCore();
 },
 AssignEllipsisTooltipsCore: function(rootElement, reassingExistingTooltips) {
  var requirePaddingManipulation = ASPx.Browser.IE || ASPx.Browser.Edge || ASPx.Browser.Firefox;
  rootElement = rootElement || this.GetMainElement();
  var nodes = this.GetEllipsisNodes(rootElement);
  var nodeInfos = [];
  var nodesCount = nodes.length;
  for(var i = 0; i < nodesCount; i++) {
   var node = nodes[i];
   var info = { node: node };
   if(requirePaddingManipulation) {
    var style = ASPx.GetCurrentStyle(node);
    info.paddingLeft = node.style.paddingLeft;
    info.totalPadding = ASPx.GetLeftRightPaddings(node, style);
   }
   nodeInfos.push(info);
  }
  if(requirePaddingManipulation) {
   for(var i = 0; i < nodesCount; i++) {
    var info = nodeInfos[i];
    ASPx.SetStyles(info.node, { paddingLeft: info.totalPadding }, true);
   }
  }
  for(var i = 0; i < nodesCount; i++) {
   var info = nodeInfos[i];
   var node = info.node;
   info.isTextShortened = node.scrollWidth > node.clientWidth;
   info.hasTitle = ASPx.Attr.GetAttribute(node, "title") !== null;
   if(!info.hasTitle || reassingExistingTooltips)
    info.title = ASPx.GetEllipsisTooltipText(node);
  }
  for(var i = 0; i < nodesCount; i++) {
   var info = nodeInfos[i];
   var node = info.node;
   if(info.isTextShortened && info.title) {
    ASPx.Attr.SetAttribute(node, "title", info.title);
    ASPx.Attr.SetAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR, true);
   }
   if(!info.isTextShortened && info.hasTitle)
    ASPx.Attr.RemoveAttribute(node, "title");
  }
  if(requirePaddingManipulation) {
   for(var i = 0; i < nodesCount; i++) {
    var info = nodeInfos[i];
    var node = info.node;
    node.style.paddingLeft = info.paddingLeft;
   }
  }
 },
 GetEllipsisNodes: function(element) {
  var ellipsibleNodes = ASPx.Data.CollectionToArray(ASPx.GetNodesByClassName(element, ELLIPSIS_MARKER_CLASS));
  if(ASPx.ElementHasCssClass(element, ELLIPSIS_MARKER_CLASS))
   ellipsibleNodes.push(element);
  return ellipsibleNodes.filter(function(node) {
   return !ASPx.Attr.IsExistsAttribute(node, "title") || ASPx.Attr.IsExistsAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR);
  });
 },
 RequireAssignTooltips: function() {
  return this.enableEllipsis && !ASPx.Browser.MobileUI;
 },
 RemoveEllipsisFromNode: function(node) {
  ASPx.RemoveClassNameFromElement(node, ELLIPSIS_MARKER_CLASS);
  this.RemoveEllipsisTooltip(node);
 },
 RemoveEllipsisTooltip: function(node) {
  if(ASPx.Attr.IsExistsAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR)) {
   ASPx.Attr.RemoveAttribute(node, "title");
   ASPx.Attr.RemoveAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR);
  }
 },
 OnBrowserWindowResize: function(e) {
 },
 OnBrowserWindowResizeInternal: function(e){
  if(this.BrowserWindowResizeSubscriber()) 
   this.OnBrowserWindowResize(e);
 },
 BrowserWindowResizeSubscriber: function() {
  return this.widthValueSetInPercentage || !this.IsAdjusted();
 },
 ShrinkWrappedText: function(getElements, key, reCorrect) {
  if(!ASPx.Browser.Safari) return;
  var elements = ASPx.CacheHelper.GetCachedElements(this, key, getElements, this.wrappedTextContainers);
  for(var i = 0; i < elements.length; i++)
   this.ShrinkWrappedTextInContainer(elements[i], reCorrect);
 },
 ShrinkWrappedTextInContainer: function(container, reCorrect) {
  if(!ASPx.Browser.Safari || !container || (container.dxWrappedTextShrinked && !reCorrect) || container.offsetWidth === 0) return;
  ASPx.ShrinkWrappedTextInContainer(container);
  container.dxWrappedTextShrinked = true;
 },
 CorrectWrappedText: function(getElements, key, reCorrect) {
  var elements = ASPx.CacheHelper.GetCachedElements(this, key, getElements, this.wrappedTextContainers);
  for(var i = 0; i < elements.length; i++)
   this.CorrectWrappedTextInContainer(elements[i], reCorrect);
 },
 CorrectWrappedTextInContainer: function(container, reCorrect) {
  if(!container || (container.dxWrappedTextCorrected && !reCorrect) || container.offsetWidth === 0) return;
  ASPx.AdjustWrappedTextInContainer(container);
  container.dxWrappedTextCorrected = true;
 },
 CorrectVerticalAlignment: function(alignMethod, getElements, key, reAlign) {
  var elements = ASPx.CacheHelper.GetCachedElements(this, key, getElements, this.verticalAlignedElements);
  for(var i = 0; i < elements.length; i++)
   this.CorrectElementVerticalAlignment(alignMethod, elements[i], reAlign);
 },
 CorrectElementVerticalAlignment: function(alignMethod, element, reAlign) {
  if(!element || (element.dxVerticalAligned && !reAlign) || element.offsetHeight === 0) return;
  alignMethod(element);
  element.dxVerticalAligned = true;
 },
 ClearVerticalAlignedElementsCache: function() {
  ASPx.CacheHelper.DropCache(this.verticalAlignedElements);
 },
 ClearWrappedTextContainersCache: function() {
  ASPx.CacheHelper.DropCache(this.wrappedTextContainers);
 },
 AdjustPagerControls: function() {
  if(typeof(ASPx.GetPagersCollection) != "undefined")
   ASPx.GetPagersCollection().AdjustControls(this.GetMainElement());
 },
 RegisterInControlTree: function(tree) {
  var mainElement = this.GetMainElement();
  if(mainElement && mainElement.id)
   tree.createNode(mainElement.id, this);
 },
 GetItemElementName: function(element) {
  var name = "";
  if(element.id)
   name = element.id.substring(this.name.length + 1);
  return name;
 },
 GetLinkElement: function(element) {
  if(element == null) return null;
  return (element.tagName == "A") ? element : ASPx.GetNodeByTagName(element, "A", 0);
 },
 GetInternalHyperlinkElement: function(parentElement, index) {
  var element = ASPx.GetNodeByTagName(parentElement, "A", index);
  if(element == null) 
   element = ASPx.GetNodeByTagName(parentElement, "SPAN", index);
  return element;
 },
 OnControlClick: function(clickedElement, htmlEvent) {
 }
});
ASPxClientControl.Cast = function(obj) {
 if(typeof obj == "string")
  return window[obj];
 return obj;
};
ASPxClientControl.AdjustControls = function(container, collapseControls){
 aspxGetControlCollection().AdjustControls(container, collapseControls);
};
ASPxClientControl.GetControlCollection = function(){
 return aspxGetControlCollection();
};
ASPxClientControl.LeadingAfterInitCallConsts = {
 None: 0,
 Direct: 1,
 Reverse: 2
};
var ASPxClientComponent = ASPx.CreateClass(ASPxClientControl, {
 constructor: function (name) {
  this.constructor.prototype.constructor.call(this, name);
 },
 IsDOMDisposed: function() { 
  return false;
 }
});
var ASPxClientControlCollection = ASPx.CreateClass(ASPx.CollectionBase, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
  this.prevWndWidth = "";
  this.prevWndHeight = "";
  this.requestCountInternal = 0; 
  this.BeforeInitCallback = new ASPxClientEvent();
  this.ControlsInitialized = new ASPxClientEvent();
  this.BrowserWindowResized = new ASPxClientEvent();
  this.BrowserWindowResizedInternal = new ASPxClientEvent();
  this.BeginCallback = new ASPxClientEvent();
  this.EndCallback = new ASPxClientEvent();
  this.CallbackError = new ASPxClientEvent();
  this.ValidationCompleted = new ASPxClientEvent();
  aspxGetControlCollectionCollection().Add(this);
 },
 Add: function(element) {
  var existsElement = this.Get(element.name);
  if(existsElement && existsElement !== element) 
   this.Remove(existsElement);
  ASPx.CollectionBase.prototype.Add.call(this, element.name, element);
 },
 Remove: function(element) {
  if(element && element instanceof ASPxClientControl && !element.IsDisposed())
   element.OnDispose();
  ASPx.CollectionBase.prototype.Remove.call(this, element.name);
 },
 GetGlobal: function(name) {
  var result = window[name];
  return result && Ident.IsASPxClientControl(result)
   ? result
   : null;
 },
 GetByName: function(name){
  return this.Get(name) || this.GetGlobal(name);
 },
 GetCollectionType: function(){
  return ASPxClientControlCollection.BaseCollectionType;
 },
 GetControlsByPredicate: function(predicate) {
  var result = [];
  this.ForEachControl(function(control) {
   if(!predicate || predicate(control))
    result.push(control);
  });
  return result;
 },
 GetControlsByType: function(type) {
  return this.GetControlsByPredicate(function(control) { 
   return type && (control instanceof type);
  });
 },
 ForEachControl: function(action, context) {
  context = context || this;
  this.elementsMap.forEachEntry(function(name, control) {
   if(Ident.IsASPxClientControl(control) && (!this.filterPredicate || this.filterPredicate(control)))
    return action.call(context, control);
  }, context);
 },
 ProcessActionByPredicate: function(action, predicate) {
  try {
   this.filterPredicate = predicate;
   action(this);
  }
  finally {
   this.filterPredicate = null;
  }
 },
 adjustControlsInternal: function(container, context, collapseControls, adjustFunc) {
  context = context || this;
  var func = function(control) {
   adjustFunc.call(context, control);
  };
  ASPx.GetControlAdjuster().adjustControlsInHierarchy(this, func, container, collapseControls);
 },
 AdjustControls: function(container, collapseControls) {
  container = container || null;
  window.setTimeout(function() {
   this.AdjustControlsCore(container, collapseControls);
  }.aspxBind(this), 0);
 },
 AdjustControlsCore: function(container, collapseControls) {
  var adjustFunction = function(control) { control.AdjustControl(); };
  this.adjustControlsInternal(container, this, collapseControls, adjustFunction);
 },
 CollapseControls: function(container) {
  this.ProcessControlsInContainer(container, function(control) {
   if(control.isASPxClientEdit)
    control.CollapseEditor();
   else if(!!window.ASPxClientRibbon && control instanceof ASPxClientRibbon)
    control.CollapseControl();
  });
 },
 AtlasInitialize: function(isCallback) {
  this.ForEachControl(function(control) {
   control.AtlasPreInitialize();
  });
  ASPx.ProcessScriptsAndLinks("", isCallback);
  this.ForEachControl(function(control) {
   control.AtlasInitialize();
  });
 },
 DOMContentLoaded: function() {
  this.ForEachControl(function(control){
    control.DOMContentLoaded();
  });
 },
 OnDocumentUnload: function() {
  this.ForEachControl(function(control) {
   control.RaiseUnload();
  });
 },
 Initialize: function() {
  ASPx.GetPostHandler().Post.AddHandler(
   function(s, e) { this.OnPost(e); }.aspxBind(this)
  );
  ASPx.GetPostHandler().PostFinalization.AddHandler(
   function(s, e) { this.OnPostFinalization(e); }.aspxBind(this)
  );
  this.InitializeElements(false );
  if(typeof(Sys) != "undefined" && typeof(Sys.Application) != "undefined") {
   var checkIsInitialized = function() {
    if(Sys.Application.get_isInitialized())
     Sys.Application.add_load(aspxCAInit);
    else
     setTimeout(checkIsInitialized, 0);
   };
   checkIsInitialized();
  }
  this.InitWindowSizeCache();
 },
 FinalizeInitialization: function() {
  this.ForEachControl(function(control) {
   control.FinalizeInitialization();
  });
 },
 InitializeElements: function(isCallback) {
  this.ForEachControl(function(control){
   if(!control.isInitialized)
    control.Initialize();
  });
  this.AfterInitializeElementsLeadingCall();
  this.AfterInitializeElements();
  this.RaiseControlsInitialized(isCallback);
 },
 AfterInitializeElementsLeadingCall: function() {
  var controls = {};
  controls[ASPxClientControl.LeadingAfterInitCallConsts.Direct] = [];
  controls[ASPxClientControl.LeadingAfterInitCallConsts.Reverse] = [];
  this.ForEachControl(function(control) {
   if(control.leadingAfterInitCall != ASPxClientControl.LeadingAfterInitCallConsts.None && !control.isInitialized)
    controls[control.leadingAfterInitCall].push(control);
  });
  var directInitControls = controls[ASPxClientControl.LeadingAfterInitCallConsts.Direct],
   reverseInitControls = controls[ASPxClientControl.LeadingAfterInitCallConsts.Reverse];
  for(var i = 0, control; control = directInitControls[i]; i++)
   control.AfterInitialize();
  for(var i = reverseInitControls.length - 1, control; control = reverseInitControls[i]; i--)
   control.AfterInitialize();
 },
 AfterInitializeElements: function() {
  this.ForEachControl(function(control) {
   if(control.leadingAfterInitCall == ASPxClientControl.LeadingAfterInitCallConsts.None && !control.isInitialized)
    control.AfterInitialize();
  });
  ASPx.RippleHelper.Init();
 },
 DoFinalizeCallback: function() {
  this.ForEachControl(function(control){
   control.DoFinalizeCallback();
  });
 },
 ProcessControlsInContainer: function(container, processFunc, filterFunc) {
  this.ForEachControl(function(control){
   if((!filterFunc || filterFunc(control)) && (!container || this.IsControlInContainer(container, control)))
    processFunc(control);
  });
 },
 IsControlInContainer: function(container, control) {
  if(control.GetMainElement) {
   var mainElement = control.GetMainElement();
   if(mainElement && (mainElement != container)) {
    if(ASPx.GetIsParent(container, mainElement))
     return true;
   }
  }
  return false;
 },
 RaiseControlsInitialized: function(isCallback) {
  if(typeof(isCallback) == "undefined")
   isCallback = true;
  var args = new ASPxClientControlsInitializedEventArgs(isCallback);
  if(!this.ControlsInitialized.IsEmpty())  
   this.ControlsInitialized.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalControlsInitialized(args);
  });
 },
 RaiseBrowserWindowResized: function() {
  var args = new ASPxClientEventArgs();
  if(!this.BrowserWindowResized.IsEmpty())
   this.BrowserWindowResized.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalBrowserWindowResized(args);
  });
 },
 RaiseBrowserWindowResizedInternal: function(eventInfo) {
  var args = new ASPxClientBrowserWindowResizedInternalEventArgs(eventInfo);
  if(!this.BrowserWindowResizedInternal.IsEmpty())
   this.BrowserWindowResizedInternal.FireEvent(this, args);
 },
 RaiseBeginCallback: function (control, command) {
  var args = new ASPxClientGlobalBeginCallbackEventArgs(control, command);
  if(!this.BeginCallback.IsEmpty())
   this.BeginCallback.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalBeginCallback(args);
  });
  this.IncrementRequestCount();
 },
 RaiseEndCallback: function (control) {
  var args = new ASPxClientGlobalEndCallbackEventArgs(control);
  if (!this.EndCallback.IsEmpty()) 
   this.EndCallback.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalEndCallback(args);
  });
  this.DecrementRequestCount();
 },
 InCallback: function() {
  return this.requestCountInternal > 0;
 },
 RaiseCallbackError: function (control, message, callbackId) {
  var args = new ASPxClientGlobalCallbackErrorEventArgs(control, message, callbackId);
  if (!this.CallbackError.IsEmpty()) 
   this.CallbackError.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalCallbackError(args);
  });
  if(args.handled)
   return { isHandled: true, errorMessage: args.message };  
  return { isHandled: false, errorMessage: message };
 },
 RaiseValidationCompleted: function (container, validationGroup, invisibleControlsValidated, isValid, firstInvalidControl, firstVisibleInvalidControl) {
  var args = new ASPxClientValidationCompletedEventArgs(container, validationGroup, invisibleControlsValidated, isValid, firstInvalidControl, firstVisibleInvalidControl);
  if (!this.ValidationCompleted.IsEmpty()) 
   this.ValidationCompleted.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalValidationCompleted(args);
  });
  return args.isValid;
 },
 Before_WebForm_InitCallback: function(callbackOwnerID){
  var args = new BeforeInitCallbackEventArgs(callbackOwnerID);
  this.BeforeInitCallback.FireEvent(this, args);
 },
 InitWindowSizeCache: function(){
  this.prevWndWidth = ASPx.GetDocumentClientWidth();
  this.prevWndHeight = ASPx.GetDocumentClientHeight();
 },
 OnBrowserWindowResize: function(evt){
  var shouldIgnoreNestedEvents = ASPx.Browser.IE && ASPx.Browser.MajorVersion == 8;
  if(shouldIgnoreNestedEvents) {
   if(this.prevWndWidth === "" || this.prevWndHeight === "" || this.browserWindowResizeLocked)
    return;
   this.browserWindowResizeLocked = true;
  }
  this.OnBrowserWindowResizeCore(evt);
  if(shouldIgnoreNestedEvents)
   this.browserWindowResizeLocked = false;
 },
 OnBrowserWindowResizeCore: function(htmlEvent){
  var args = this.CreateOnBrowserWindowResizeEventArgs(htmlEvent);
  if(this.CalculateIsBrowserWindowSizeChanged()) {
   this.RaiseBrowserWindowResizedInternal(args);
   this.adjustControlsInternal(null, this, true, function(control) {
    if(control.IsDOMInitialized())
     control.OnBrowserWindowResizeInternal(args);
   });
   this.RaiseBrowserWindowResized();
  }
 },
 CreateOnBrowserWindowResizeEventArgs: function(htmlEvent) {
  return {
   htmlEvent: htmlEvent,
   wndWidth: ASPx.GetDocumentClientWidth(),
   wndHeight: ASPx.GetDocumentClientHeight(),
   prevWndWidth: this.prevWndWidth,
   prevWndHeight: this.prevWndHeight,
   virtualKeyboardShownOnAndroid: this.IsVirtualKeyboardShownOnAndroid()
  };
 },
 IsVirtualKeyboardShownOnAndroid: function() {
  if(!ASPx.Browser.AndroidMobilePlatform)
   return false;
  var documentClientWidth = ASPx.GetDocumentClientWidth();
  var documentClientHeight = ASPx.GetDocumentClientHeight();
  var isDocumentClientHeightChangedOnly = documentClientWidth === this.prevWndWidth && documentClientHeight !== this.prevWndHeight;
  return isDocumentClientHeightChangedOnly && this.IsElementSupportKeyboardInput(document.activeElement);
 },
 IsElementSupportKeyboardInput: function(element) {
  if(!element || !element.tagName)
   return false;
  var supportedKeyboardInputTagNames = ["INPUT", "TEXTAREA"];
  return supportedKeyboardInputTagNames.indexOf(element.tagName) !== -1;
 },
 CalculateIsBrowserWindowSizeChanged: function(){
  var wndWidth = ASPx.GetDocumentClientWidth();
  var wndHeight = ASPx.GetDocumentClientHeight();
  var isBrowserWindowSizeChanged = (this.prevWndWidth != wndWidth) || (this.prevWndHeight != wndHeight);
  if(isBrowserWindowSizeChanged){
   this.prevWndWidth = wndWidth;
   this.prevWndHeight = wndHeight;
   return true;
  }
  return false;
 },
 OnPost: function(args){
  this.ForEachControl(function(control) {
   control.OnPost(args);
  }, null);
 },
 OnPostFinalization: function(args){
  this.ForEachControl(function(control) {
   control.OnPostFinalization(args);
  }, null);
 },
 IncrementRequestCount: function() {
  this.requestCountInternal++;
 },
 DecrementRequestCount: function() {
  this.requestCountInternal--;
 },
 ResetRequestCount: function() {
  this.requestCountInternal = 0;
 }
});
ASPxClientControlCollection.BaseCollectionType = "Control";
var controlCollection = null;
function aspxGetControlCollection(){
 if(controlCollection == null) {
  controlCollection = new ASPxClientControlCollection();
  if(ASPx.loadControlCollectionPreloadHandlers)
   ASPx.loadControlCollectionPreloadHandlers(controlCollection);
 }
 return controlCollection;
}
var ControlCollectionCollection = ASPx.CreateClass(ASPx.CollectionBase, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
 },
 Add: function(element) {
  var key = element.GetCollectionType();
  if(!key) throw "The collection type isn't specified.";
  if(this.Get(key)) throw "The collection with type='" + key + "' already exists.";
  ASPx.CollectionBase.prototype.Add.call(this, key, element);
 },
 RemoveDisposedControls: function(){
  var baseCollection = this.Get(ASPxClientControlCollection.BaseCollectionType);
  var disposedControls = [];
  baseCollection.elementsMap.forEachEntry(function(name, control) {
   if(!ASPx.Ident.IsASPxClientControl(control)) return;
   if(control.IsDOMDisposed())
    disposedControls.push(control);
  });
  this.RemoveControls(disposedControls);
 },
 RemoveControls: function(controls){
  for(var i = 0; i < controls.length; i++) {
   this.elementsMap.forEachEntry(function(key, collection) {
    if(ASPx.Ident.IsASPxClientCollection(collection))
     collection.Remove(controls[i]);
   });
  }
 }
});
var controlCollectionCollection = null;
function aspxGetControlCollectionCollection(){
 if(controlCollectionCollection == null)
  controlCollectionCollection = new ControlCollectionCollection();
 return controlCollectionCollection;
}
var AriaDescriptionAttributes = {
 Role: "0",
 AriaLabel: "1",
 TabIndex: "2",
 AriaOwns: "3",
 AriaDescribedBy: "4",
 AriaDisabled: "5",
 AriaHasPopup: "6",
 AriaLevel: "7"
};
var AriaDescriptor = ASPx.CreateClass(null, {
 constructor: function(ownerControl, description) {
  this.ownerControl = ownerControl;
  this.rootElement = ownerControl.GetMainElement();
  this.description = description;
 },
 setDescription: function(name, argList) {
  var description = this.findChildDescription(name);
  if(description) {
   var elements = name ? this.rootElement.querySelectorAll(this.getDescriptionSelector(description)) : [this.rootElement];
   for(var i = 0; i < elements.length; i++)
    this.applyDescriptionToElement(elements[i], description, argList[i] || argList[0]);
  }
 },
 getDescriptionName: function(description) {
  return description.n;
 },
 getDescriptionSelector: function(description) {
  return description.s;
 },
 findChildDescription: function(name) {
  if(name === this.getDescriptionName(this.description))
   return this.description;
  var childCollection = this.description.c || [];
  for(var i = 0; i < childCollection.length; i++) {
   var childDescription = childCollection[i];
   if(this.getDescriptionName(childDescription) === name)
    return childDescription;
  }
  return null;
 },
 applyDescriptionToElement: function(element, description, args) {
  if(!description || !element)
   return;
  this.trySetAriaOwnsAttribute(element, description);
  this.trySetAriaDescribedByAttribute(element, description);
  this.trySetAttribute(element, description, AriaDescriptionAttributes.Role, "role");
  this.trySetAttribute(element, description, AriaDescriptionAttributes.TabIndex, "tabindex");
  this.trySetAttribute(element, description, AriaDescriptionAttributes.AriaLevel, "aria-level");
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaLabel, function(value) {
   ASPx.Attr.SetAttribute(element, "aria-label", ASPx.Str.ApplyReplacement(value, args));
  });
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaDisabled, function(value) {
   ASPx.Attr.SetAttribute(element, "aria-disabled", !!value); 
  });
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaHasPopup, function(value) {
   ASPx.Attr.SetAttribute(element, "aria-haspopup", !!value);
  });
 },
 trySetAriaDescribedByAttribute: function(element, description) {
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaDescribedBy, function(selectorInfo) {
   var descriptor = this.getNodesBySelector(element, selectorInfo.descriptorSelector)[0];
   var target = this.getNodesBySelector(element, selectorInfo.targetSelector)[0];
   if(!target || !descriptor)
    return;
   ASPx.Attr.SetAttribute(target, "aria-describedby", this.getNodeId(descriptor));
  });
 },
 trySetAriaOwnsAttribute: function(element, description) {
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaOwns, function(selector) {
   var ownedNodes = this.getNodesBySelector(element, selector);
   var ariaOwnsAttributeValue = "";
   for(var i = 0; i < ownedNodes.length; i++)
    ariaOwnsAttributeValue += (this.getNodeId(ownedNodes[i]) + (i != ownedNodes.length - 1 ? " " : ""));
   ASPx.Attr.SetAttribute(element, "aria-owns", ariaOwnsAttributeValue);
  });
 },
 trySetAttribute: function(element, description, ariaAttribute, attributeName) {
  this.executeOnDescription(description, ariaAttribute, function(value) { 
   ASPx.Attr.SetAttribute(element, attributeName, description[ariaAttribute]); 
  });
 },
 executeOnDescription: function(description, ariaDescAttr, callback) {
  var descInfo = description[ariaDescAttr];
  if(ASPx.IsExists(descInfo))
   callback.aspxBind(this)(descInfo);
 },
 getNodesBySelector: function(element, selector) {
  var id = element.id || "";
  var childNodes = element.querySelectorAll("#" + this.getNodeId(element) + " > " + selector);
  ASPx.Attr.SetOrRemoveAttribute(element, "id", id);
  return childNodes;
 },
 getNodeId: function(node) {
  if(!node.id)
   node.id = this.createRandomId();
  return node.id; 
 },
 createRandomId: function() {
  return "r" + ASPx.CreateGuid();
 }
});
PagerCommands = {
 Next : "PBN",
 Prev : "PBP",
 Last : "PBL",
 First : "PBF",
 PageNumber : "PN",
 PageSize : "PSP"
};
ASPx.callbackProcessed = false;
ASPx.Callback = function(result, context){ 
 var collection = aspxGetControlCollection();
 collection.DoFinalizeCallback();
 var control = collection.Get(context);
 if(control != null)
  control.DoCallback(result);
 ASPx.RippleHelper.ReInit();
 ASPx.callbackProcessed = true;
};
ASPx.CallbackError = function(result, context){
 var control = aspxGetControlCollection().Get(context);
 if(control != null)
  control.DoCallbackError(result, false);
 ASPx.callbackProcessed = true;
};
ASPx.CClick = function(name, evt) {
 var control = aspxGetControlCollection().Get(name);
 if(control != null) control.DoControlClick(evt);
};
function aspxCAInit() {
 var isAppInit = typeof(Sys$_Application$initialize) != "undefined" &&
  ASPx.FunctionIsInCallstack(arguments.callee, Sys$_Application$initialize, 10 );
 aspxGetControlCollection().AtlasInitialize(!isAppInit);
}
ASPx.Evt.AttachEventToElement(window, "resize", aspxGlobalWindowResize);
function aspxGlobalWindowResize(evt){
 aspxGetControlCollection().OnBrowserWindowResize(evt); 
}
ASPx.Evt.AttachEventToElement(window, "unload", aspxClassesUnload);
function aspxClassesUnload(evt) {
 aspxGetControlCollection().OnDocumentUnload();
}
ASPx.attachToLoad(aspxClassesDOMContentLoaded);
function aspxClassesDOMContentLoaded(evt){
 aspxGetControlCollection().DOMContentLoaded();
}
ASPx.GetControlCollection = aspxGetControlCollection;
ASPx.GetControlCollectionCollection = aspxGetControlCollectionCollection;
ASPx.GetPersistentControlPropertiesStorage = _aspxGetPersistentControlPropertiesStorage;
ASPx.PagerCommands = PagerCommands;
ASPx.ELLIPSIS_MARKER_CLASS = ELLIPSIS_MARKER_CLASS;
window.ASPxClientBeginCallbackEventArgs = ASPxClientBeginCallbackEventArgs;
window.ASPxClientGlobalBeginCallbackEventArgs = ASPxClientGlobalBeginCallbackEventArgs;
window.ASPxClientEndCallbackEventArgs = ASPxClientEndCallbackEventArgs;
window.ASPxClientGlobalEndCallbackEventArgs = ASPxClientGlobalEndCallbackEventArgs;
window.ASPxClientCallbackErrorEventArgs = ASPxClientCallbackErrorEventArgs;
window.ASPxClientGlobalCallbackErrorEventArgs = ASPxClientGlobalCallbackErrorEventArgs;
window.ASPxClientCustomDataCallbackEventArgs = ASPxClientCustomDataCallbackEventArgs;
window.ASPxClientValidationCompletedEventArgs = ASPxClientValidationCompletedEventArgs;
window.ASPxClientControlsInitializedEventArgs = ASPxClientControlsInitializedEventArgs;
window.ASPxClientControlBeforePronounceEventArgs = ASPxClientControlBeforePronounceEventArgs;
window.ASPxClientControlUnloadEventArgs = ASPxClientControlUnloadEventArgs;
window.ASPxClientEndFocusEventArgs = ASPxClientEndFocusEventArgs;
window.ASPxClientItemFocusedEventArgs = ASPxClientItemFocusedEventArgs;
window.ASPxClientControlCollection = ASPxClientControlCollection;
window.ASPxClientControlBase = ASPxClientControlBase;
window.ASPxClientControl = ASPxClientControl;
window.ASPxClientComponent = ASPxClientComponent;
})(ASPx);

(function () {
 var PositionAnimationTransition = ASPx.CreateClass(ASPx.AnimationTransitionBase, {
  constructor: function (element, options) {
   this.constructor.prototype.constructor.call(this, element, options);
   this.direction = options.direction;
   this.animationTransition = this.createAnimationTransition();
   AnimationHelper.appendWKAnimationClassNameIfRequired(this.element);
  },
  Start: function (to) {
   var from = this.GetValue();
   if(ASPx.AnimationUtils.CanUseCssTransform()) {
    from = this.convertPosToCssTransformPos(from);
    to = this.convertPosToCssTransformPos(to);
   }
   this.animationTransition.Start(from, to);
  },
  SetValue: function (value) {
   ASPx.AnimationUtils.SetTransformValue(this.element, value, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  },
  GetValue: function () {
   return ASPx.AnimationUtils.GetTransformValue(this.element, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  },
  createAnimationTransition: function () {
   var transition = ASPx.AnimationUtils.CanUseCssTransform() ? this.createTransformAnimationTransition() : this.createPositionAnimationTransition();
   transition.transition = ASPx.AnimationConstants.Transitions.POW_EASE_OUT;
   return transition;
  },
  createTransformAnimationTransition: function () {
   return ASPx.AnimationUtils.createCssAnimationTransition(this.element, {
    property: ASPx.AnimationUtils.CanUseCssTransform(),
    duration: this.duration,
    onComplete: this.onComplete
   });
  },
  createPositionAnimationTransition: function () {
   return AnimationHelper.createAnimationTransition(this.element, {
    property: this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION ? "top" : "left",
    unit: "px",
    duration: this.duration,
    onComplete: this.onComplete
   });
  },
  convertPosToCssTransformPos: function (position) {
   return ASPx.AnimationUtils.GetTransformCssText(position, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  }
 });
 var AnimationHelper = {
  SLIDE_HORIZONTAL_DIRECTION: 0,
  SLIDE_VERTICAL_DIRECTION: 1,
  SLIDE_TOP_DIRECTION: 0,
  SLIDE_RIGHT_DIRECTION: 1,
  SLIDE_BOTTOM_DIRECTION: 2,
  SLIDE_LEFT_DIRECTION: 3,
  SLIDE_CONTAINER_CLASS: "dxAC",
  MAXIMUM_DEPTH: 3,
  createAnimationTransition: function (element, options) {
   if(options.onStep)
    options.animationEngineType = AnimationEngineType.JS;
   switch(options.animationEngineType) {
    case AnimationEngineType.JS:
     return ASPx.AnimationUtils.createJsAnimationTransition(element, options);
    case AnimationEngineType.CSS:
     return ASPx.AnimationUtils.createCssAnimationTransition(element, options);
    default:
     return ASPx.AnimationUtils.CanUseCssTransition() ? ASPx.AnimationUtils.createCssAnimationTransition(element, options) :
      ASPx.AnimationUtils.createJsAnimationTransition(element, options);
   }
  },
  createMultipleAnimationTransition: function (element, options) {
   return ASPx.AnimationUtils.createMultipleAnimationTransition(element, options);
  },
  createSimpleAnimationTransition: function (options) {
   return ASPx.AnimationUtils.createSimpleAnimationTransition(options);
  },
  cancelAnimation: function (element) {
   ASPx.AnimationTransitionBase.Cancel(element);
  },
  fadeIn: function(element, onComplete, duration, animationEngineType) {
   AnimationHelper.fadeTo(element, {
    from: 0, to: 1,
    onComplete: onComplete,
    animationEngineType: animationEngineType || AnimationEngineType.DEFAULT,
    duration: duration || ASPx.AnimationConstants.Durations.DEFAULT
   });
  },
  fadeOut: function(element, onComplete, duration, animationEngineType) {
   AnimationHelper.fadeTo(element, {
    from: ASPx.GetElementOpacity(element), to: 0,
    onComplete: onComplete,
    animationEngineType: animationEngineType || AnimationEngineType.DEFAULT,
    duration: duration || ASPx.AnimationConstants.Durations.DEFAULT
   });
  },
  fadeTo: function (element, options) {
   options.property = "opacity";
   if(!options.duration)
    options.duration = ASPx.AnimationConstants.Durations.SHORT;
   var transition = AnimationHelper.createAnimationTransition(element, options);
   if(!ASPx.IsExists(options.from))
    options.from = transition.GetValue();
   transition.Start(options.from, options.to);
  },
  slideIn: function (element, direction, onComplete, animationEngineType, rtl) {
   AnimationHelper.setOpacity(element, 1);
   var animationContainer = AnimationHelper.getSlideAnimationContainer(element, true, true);
   var pos = AnimationHelper.getSlideInStartPos(animationContainer, direction, rtl);
   var transition = AnimationHelper.createSlideTransition(animationContainer, direction,
    function (el) {
     AnimationHelper.resetSlideAnimationContainerSize(animationContainer);
     if(onComplete)
      onComplete(el);
    }, animationEngineType, rtl);
   transition.Start(pos, 0);
  },
  slideOut: function (element, direction, onComplete, animationEngineType, rtl) {
   var animationContainer = AnimationHelper.getSlideAnimationContainer(element, true, true);
   var pos = AnimationHelper.getSlideOutFinishPos(animationContainer, direction, rtl);
   var transition = AnimationHelper.createSlideTransition(animationContainer, direction,
    function (el) {
     AnimationHelper.setOpacity(el.firstChild, 0);
     if(onComplete)
      onComplete(el);
    }, animationEngineType, rtl);
   transition.Start(pos);
  },
  slideTo: function (element, options) {
   if(!ASPx.IsExists(options.direction))
    options.direction = AnimationHelper.SLIDE_HORIZONTAL_DIRECTION;
   var transition = new PositionAnimationTransition(element, options);
   transition.Start(options.to);
  },
  setOpacity: function (element, value) {
   ASPx.AnimationUtils.setOpacity(element, value);
  },
  appendWKAnimationClassNameIfRequired: function (element) {
   if(ASPx.AnimationUtils.CanUseCssTransform() && ASPx.Browser.WebKitFamily && !ASPx.ElementHasCssClass(element, "dx-wbv"))
    element.className += " dx-wbv";
  },
  findSlideAnimationContainer: function (element) {
   var container = element;
   for(var i = 0; i < AnimationHelper.MAXIMUM_DEPTH; i++) {
    if(container.tagName == "BODY")
     return null;
    if(ASPx.ElementHasCssClass(container, AnimationHelper.SLIDE_CONTAINER_CLASS))
     return container;
    container = container.parentNode;
   }
   return null;
  },
  createSlideAnimationContainer: function (element) {
   var rootContainer = document.createElement("DIV");
   ASPx.SetStyles(rootContainer, {
    className: AnimationHelper.SLIDE_CONTAINER_CLASS,
    overflow: "hidden"
   });
   var elementContainer = document.createElement("DIV");
   rootContainer.appendChild(elementContainer);
   var parentNode = element.parentNode;
   parentNode.insertBefore(rootContainer, element);
   elementContainer.appendChild(element);
   return rootContainer;
  },
  getSlideAnimationContainer: function (element, create, fixSize) {
   if(!element) return;
   var width = element.offsetWidth;
   var height = element.offsetHeight;
   var container;
   if(element.className == AnimationHelper.SLIDE_CONTAINER_CLASS)
    container = element;
   if(!container)
    container = AnimationHelper.findSlideAnimationContainer(element);
   if(!container && create)
    container = AnimationHelper.createSlideAnimationContainer(element);
   if(container && fixSize) {
    ASPx.SetStyles(container, {
     width: width, height: height
    });
    ASPx.SetStyles(container.firstChild, {
     width: width, height: height
    });
   }
   return container;
  },
  resetSlideAnimationContainerSize: function (container) {
   ASPx.SetStyles(container, {
    width: "", height: ""
   });
   ASPx.SetStyles(container.firstChild, {
    width: "", height: ""
   });
  },
  getModifyProperty: function (direction, rtl) {
   if(direction == AnimationHelper.SLIDE_TOP_DIRECTION || direction == AnimationHelper.SLIDE_BOTTOM_DIRECTION)
    return "marginTop";
   return rtl ? "margin-right" : "margin-left";
  },
  createSlideTransition: function (animationContainer, direction, complete, animationEngineType, rtl) {
   if(rtl == undefined)
    rtl = false;
   return AnimationHelper.createAnimationTransition(animationContainer.firstChild, {
    unit: "px",
    property: AnimationHelper.getModifyProperty(direction, rtl),
    onComplete: complete,
    animationEngineType: animationEngineType
   });
  },
  getSlideInStartPos: function (animationContainer, direction, rtl) {
   var dir = rtl ? -1 : 1;
   switch (direction) {
    case AnimationHelper.SLIDE_TOP_DIRECTION:
     return animationContainer.offsetHeight;
    case AnimationHelper.SLIDE_LEFT_DIRECTION:
     return animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_RIGHT_DIRECTION:
     return -animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_BOTTOM_DIRECTION:
     return -animationContainer.offsetHeight;
   }
  },
  getSlideOutFinishPos: function (animationContainer, direction, rtl) {
   var dir = rtl ? -1 : 1;
   switch (direction) {
    case AnimationHelper.SLIDE_TOP_DIRECTION:
     return -animationContainer.offsetHeight;
    case AnimationHelper.SLIDE_LEFT_DIRECTION:
     return -animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_RIGHT_DIRECTION:
     return animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_BOTTOM_DIRECTION:
     return animationContainer.offsetHeight;
   }
  }
 };
 var GestureHandler = ASPx.CreateClass(null, {
  constructor: function (getAnimationElement, canHandle, allowStart) {
   this.getAnimationElement = getAnimationElement;
   this.canHandle = canHandle;
   this.allowStart = allowStart;
   this.startMousePosX = 0;
   this.startMousePosY = 0;
   this.startTime = null;
   this.isEventsPrevented = false;
   this.savedElements = [];
  },
  OnSelectStart: function(evt) {
   ASPx.Evt.PreventEvent(evt); 
  },
  OnDragStart: function(evt) {
   ASPx.Evt.PreventEvent(evt);  
  },
  OnMouseDown: function (evt) {
   this.startMousePosX = ASPx.Evt.GetEventX(evt);
   this.startMousePosY = ASPx.Evt.GetEventY(evt);
   this.startTime = new Date();
  },
  OnMouseMove: function(evt) {
   if(!ASPx.Browser.MobileUI)
    ASPx.Selection.Clear();
   if(Math.abs(this.GetCurrentDistanceX(evt)) < GestureHandler.SLIDER_MIN_START_DISTANCE && Math.abs(this.GetCurrentDistanceY(evt)) < GestureHandler.SLIDER_MIN_START_DISTANCE)
    GesturesHelper.isExecutedGesture = false;
  },
  OnMouseUp: function (evt) {
  },
  CanHandleEvent: function (evt) {
   return !this.canHandle || this.canHandle(evt);
  },
  IsStartAllowed: function(value) {
   return !this.allowStart || this.allowStart(value);
  },
  RollbackGesture: function () {
  },
  GetRubberPosition: function (position) {
   return position / GestureHandler.FACTOR_RUBBER;
  },
  GetCurrentDistanceX: function (evt) {
   return ASPx.Evt.GetEventX(evt) - this.startMousePosX;
  },
  GetCurrentDistanceY: function (evt) {
   return ASPx.Evt.GetEventY(evt) - this.startMousePosY;
  },
  GetDistanceLimit: function () {
   return (new Date() - this.startTime) < GestureHandler.MAX_TIME_SPAN ? GestureHandler.MIN_DISTANCE_LIMIT : GestureHandler.MAX_DISTANCE_LIMIT;
  },
  GetContainerElement: function () {
  },
  AttachPreventEvents: function (evt) {
   if(!this.isEventsPrevented) {
    var element = ASPx.Evt.GetEventSource(evt);
    var container = this.GetContainerElement();
    while(element && element != container) {
     ASPx.Evt.AttachEventToElement(element, "mouseup", ASPx.Evt.PreventEvent);
     ASPx.Evt.AttachEventToElement(element, "click", ASPx.Evt.PreventEvent);
     this.savedElements.push(element);
     element = element.parentNode;
    }
    this.isEventsPrevented = true;
   }
  },
  DetachPreventEvents: function () {
   if(this.isEventsPrevented) {
    window.setTimeout(function () {
     while(this.savedElements.length > 0) {
      var element = this.savedElements.pop();
      ASPx.Evt.DetachEventFromElement(element, "mouseup", ASPx.Evt.PreventEvent);
      ASPx.Evt.DetachEventFromElement(element, "click", ASPx.Evt.PreventEvent);
     }
    }.aspxBind(this), 0);
    this.isEventsPrevented = false;
   }
  }
 });
 GestureHandler.MAX_DISTANCE_LIMIT = 70;
 GestureHandler.MIN_DISTANCE_LIMIT = 10;
 GestureHandler.MIN_START_DISTANCE = 0;
 GestureHandler.SLIDER_MIN_START_DISTANCE = 5;
 GestureHandler.MAX_TIME_SPAN = 300;
 GestureHandler.FACTOR_RUBBER = 4;
 GestureHandler.RETURN_ANIMATION_DURATION = 150;
 var SwipeSlideGestureHandler = ASPx.CreateClass(GestureHandler, {
  constructor: function (getAnimationElement, direction, canHandle, backward, forward, rollback, move) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, canHandle);
   this.slideElement = this.getAnimationElement();
   this.container = this.slideElement.parentNode;
   this.direction = direction;
   this.backward = backward;
   this.forward = forward;
   this.rollback = rollback;
   this.slideElementSize = 0;
   this.containerElementSize = 0;
   this.startSliderElementPosition = 0;
   this.centeredSlideElementPosition = 0;
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   this.slideElementSize = this.GetElementSize();
   this.startSliderElementPosition = this.GetElementPosition();
   this.containerElementSize = this.GetContainerElementSize();
   if(this.slideElementSize <= this.containerElementSize)
    this.centeredSlideElementPosition = (this.containerElementSize - this.slideElementSize) / 2;
  },
  OnMouseMove: function (evt) {
   GestureHandler.prototype.OnMouseMove.call(this, evt);
   if(!ASPx.Browser.TouchUI && !ASPx.GetIsParent(this.container, ASPx.Evt.GetEventSource(evt))) {
    GesturesHelper.OnDocumentMouseUp(evt);
    return;
   }
   var distance = this.GetCurrentDistance(evt);
   if(Math.abs(distance) < GestureHandler.SLIDER_MIN_START_DISTANCE || ASPx.TouchUIHelper.isGesture)
    return;
   this.SetElementPosition(this.GetCalculatedPosition(distance));
   this.AttachPreventEvents(evt);
   ASPx.Evt.PreventEvent(evt);
  },
  GetCalculatedPosition: function (distance) {
   ASPx.AnimationTransitionBase.Cancel(this.slideElement);
   var position = this.startSliderElementPosition + distance,
    maxPosition = -(this.slideElementSize - this.containerElementSize),
    minPosition = 0;
   if(this.centeredSlideElementPosition > 0)
    position = this.GetRubberPosition(distance) + this.centeredSlideElementPosition;
   else if(position > minPosition)
    position = this.GetRubberPosition(distance);
   else if(position < maxPosition)
    position = this.GetRubberPosition(distance) + maxPosition;
   return position;
  },
  OnMouseUp: function (evt) {
   this.DetachPreventEvents();
   if(this.GetCurrentDistance(evt) != 0)
    this.OnMouseUpCore(evt);
  },
  OnMouseUpCore: function (evt) {
   var distance = this.GetCurrentDistance(evt);
   if(this.centeredSlideElementPosition > 0 || this.CheckSlidePanelIsOutOfBounds())
    this.PerformRollback();
   else
    this.PerformAction(distance);
  },
  PerformAction: function (distance) {
   if(Math.abs(distance) < this.GetDistanceLimit())
    this.PerformRollback();
   else if(distance < 0)
    this.PerformForward();
   else
    this.PerformBackward();
  },
  PerformBackward: function () {
   this.backward();
  },
  PerformForward: function () {
   this.forward();
  },
  PerformRollback: function () {
   this.rollback();
  },
  CheckSlidePanelIsOutOfBounds: function () {
   var minOffset = -(this.slideElementSize - this.containerElementSize), maxOffset = 0;
   var slideElementPos = this.GetElementPosition();
   if(slideElementPos > maxOffset || slideElementPos < minOffset)
    return true;
   return false;
  },
  GetContainerElement: function () {
   return this.container;
  },
  GetElementSize: function () {
   return this.IsHorizontalDirection() ? this.slideElement.offsetWidth : this.slideElement.offsetHeight;
  },
  GetContainerElementSize: function () {
   return this.IsHorizontalDirection() ? ASPx.GetClearClientWidth(this.container) : ASPx.GetClearClientHeight(this.container);
  },
  GetCurrentDistance: function (evt) {
   return this.IsHorizontalDirection() ? this.GetCurrentDistanceX(evt) : this.GetCurrentDistanceY(evt);
  },
  GetElementPosition: function () {
   return ASPx.AnimationUtils.GetTransformValue(this.slideElement, !this.IsHorizontalDirection());
  },
  SetElementPosition: function (position) {
   ASPx.AnimationUtils.SetTransformValue(this.slideElement, position, !this.IsHorizontalDirection());
  },
  IsHorizontalDirection: function () {
   return this.direction == AnimationHelper.SLIDE_HORIZONTAL_DIRECTION;
  }
 });
 var SwipeSimpleSlideGestureHandler = ASPx.CreateClass(SwipeSlideGestureHandler, {
  constructor: function (getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, direction, canHandle, backward, forward, rollback);
   this.container = this.slideElement;
   this.updatePosition = updatePosition;
   this.prevDistance = 0;
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   this.prevDistance = 0;
  },
  OnMouseUpCore: function (evt) {
   this.PerformAction(this.GetCurrentDistance(evt));
  },
  PerformAction: function (distance) {
   if(Math.abs(distance) < this.GetDistanceLimit())
    this.PerformRollback();
   else if(distance < 0)
    this.PerformForward();
   else
    this.PerformBackward();
  },
  GetCalculatedPosition: function (distance) {
   var position = distance - this.prevDistance;
   this.prevDistance = distance;
   return position;
  },
  SetElementPosition: function (position) {
   this.updatePosition(position);
  }
 });
 var SwipeGestureHandler = ASPx.CreateClass(GestureHandler, {
  constructor: function (getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType, rtl) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, canHandle, allowStart);
   this.start = start;
   this.allowComplete = allowComplete;
   this.complete = complete;
   this.cancel = cancel;
   this.animationTween = null;
   this.currentDistanceX = 0;
   this.currentDistanceY = 0;
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
   this.animationEngineType = animationEngineType;
   this.rtl = rtl;
   this.UpdateAnimationContainer();
  },
  UpdateAnimationContainer: function () {
   this.animationContainer = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, false);
  },
  CanHandleEvent: function (evt) {
   if(GestureHandler.prototype.CanHandleEvent.call(this, evt))
    return true;
   return this.animationTween && this.animationContainer && ASPx.GetIsParent(this.animationContainer, ASPx.Evt.GetEventSource(evt));
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   if(this.animationTween)
    this.animationTween.Cancel();
   this.currentDistanceX = 0;
   this.currentDistanceY = 0;
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
  },
  OnMouseMove: function (evt) {
   GestureHandler.prototype.OnMouseMove.call(this, evt);
   var isZoomGestureConflict = evt.touches && evt.touches.length > 1;
   if (isZoomGestureConflict)
    return false;
   this.currentDistanceX = this.GetCurrentDistanceX(evt);
   this.currentDistanceY = this.GetCurrentDistanceY(evt);
   if(this.rtl)
    this.currentDistanceX = -this.currentDistanceX;
   if(!this.animationTween && !this.tryStartScrolling && (Math.abs(this.currentDistanceX) >
    GestureHandler.MIN_START_DISTANCE || Math.abs(this.currentDistanceY) > GestureHandler.MIN_START_DISTANCE)) {
    if(Math.abs(this.currentDistanceY) < Math.abs(this.currentDistanceX)) {
     this.tryStartGesture = true;
     if(this.IsStartAllowed(this.currentDistanceX)) {
      this.animationContainer = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, true);
      this.animationTween = AnimationHelper.createSlideTransition(this.animationContainer, AnimationHelper.SLIDE_LEFT_DIRECTION,
       function () {
        AnimationHelper.resetSlideAnimationContainerSize(this.animationContainer);
        this.animationContainer = null;
        this.animationTween = null;
       }.aspxBind(this), this.animationEngineType, this.rtl);
      this.PerformStart(this.currentDistanceX);
      this.AttachPreventEvents(evt);
     }
    }
    else
     this.tryStartScrolling = true;
   }
   if(this.animationTween) {
    if(this.allowComplete && !this.allowComplete(this.currentDistanceX))
     this.currentDistanceX = this.GetRubberPosition(this.currentDistanceX);
    this.animationTween.SetValue(this.currentDistanceX);
   }
   if(!this.tryStartScrolling && !ASPx.TouchUIHelper.isGesture && evt.touches && evt.touches.length < 2)
    ASPx.Evt.PreventEvent(evt);
  },
  OnMouseUp: function (evt) {
   if(!this.animationTween) {
    if(this.tryStartGesture)
     this.PerformCancel(this.currentDistanceX);
   }
   else {
    if(Math.abs(this.currentDistanceX) < this.GetDistanceLimit())
     this.RollbackGesture();
    else {
     if(this.IsCompleteAllowed(this.currentDistanceX)) {
      this.PerformComplete(this.currentDistanceX);
      this.animationContainer = null;
      this.animationTween = null;
     }
     else
      this.RollbackGesture();
    }
   }
   this.DetachPreventEvents();
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
  },
  PerformStart: function (value) {
   if(this.start)
    this.start(value);
  },
  IsCompleteAllowed: function (value) {
   return !this.allowComplete || this.allowComplete(value);
  },
  PerformComplete: function (value) {
   if(this.complete)
    this.complete(value);
  },
  PerformCancel: function (value) {
   if(this.cancel)
    this.cancel(value);
  },
  RollbackGesture: function () {
   this.animationTween.Start(this.currentDistanceX, 0);
  },
  ResetGestureElementPosition: function () {
   if (this.currentDistanceX === 0) return;
   var container = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement());
   var onComplete = function () { AnimationHelper.resetSlideAnimationContainerSize(container); };
   var animation = AnimationHelper.createSlideTransition(container, AnimationHelper.SLIDE_LEFT_DIRECTION, onComplete, this.animationEngineType, this.rtl);
   animation.Start(this.currentDistanceX, 0);
  },
  GetContainerElement: function () {
   return this.animationContainer;
  }
 });
 var GesturesHelper = {
  handlers: {},
  activeHandler: null,
  isAttachedEvents: false,
  isExecutedGesture: false,
  AddSwipeGestureHandler: function (id, getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType, rtl) {
   this.handlers[id] = new SwipeGestureHandler(getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType, rtl);
  },
  UpdateSwipeAnimationContainer: function (id) {
   if(this.handlers[id])
    this.handlers[id].UpdateAnimationContainer();
  },
  AddSwipeSlideGestureHandler: function (id, getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition) {
   if(updatePosition)
    this.handlers[id] = new SwipeSimpleSlideGestureHandler(getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition);
   else
    this.handlers[id] = new SwipeSlideGestureHandler(getAnimationElement, direction, canHandle, backward, forward, rollback);
  },
  getParentDXEditorWithSwipeGestures: function(element) {
     return ASPx.GetParent(element, function(parent) {
      var parentObj = ASPx.GetControlCollection().Get(parent.id);
      return parentObj && parentObj.supportGestures && parentObj.isSwipeGesturesEnabled();
   });
  },
  canHandleMouseDown: function(evt) {
   if(!ASPx.Evt.IsLeftButtonPressed(evt))
    return false;
   var element = ASPx.Evt.GetEventSource(evt);
   var dxFocusedEditor = ASPx.Ident.scripts.ASPxClientEdit && ASPx.GetFocusedEditor();
   if(dxFocusedEditor && dxFocusedEditor.IsEditorElement(element)) {
    var elementParentDXEditorWithSwipeGestures = GesturesHelper.getParentDXEditorWithSwipeGestures(element);
    if(!elementParentDXEditorWithSwipeGestures || !dxFocusedEditor.IsEditorElement(elementParentDXEditorWithSwipeGestures))
     return false;
   }
   var isTextEditor = element.tagName == "TEXTAREA" || element.tagName == "INPUT" && ASPx.Attr.GetAttribute(element, "type") == "text";
   if(isTextEditor && document.activeElement == element)
    return false;
   return true;  
  },
  OnDocumentDragStart: function(evt) {
   if(GesturesHelper.activeHandler)
    GesturesHelper.activeHandler.OnDragStart(evt);
  },
  OnDocumentSelectStart: function(evt) {
   if(GesturesHelper.activeHandler)
    GesturesHelper.activeHandler.OnSelectStart(evt);
  },
  OnDocumentMouseDown: function (evt) {
   if(!GesturesHelper.canHandleMouseDown(evt))
    return;
   GesturesHelper.activeHandler = GesturesHelper.FindHandler(evt);
   if(GesturesHelper.activeHandler)
    GesturesHelper.activeHandler.OnMouseDown(evt);
  },
  OnDocumentMouseMove: function (evt) {
   if(GesturesHelper.activeHandler) {
    GesturesHelper.isExecutedGesture = true;
    GesturesHelper.activeHandler.OnMouseMove(evt);
   }
  },
  OnDocumentMouseUp: function (evt) {
   if(GesturesHelper.activeHandler) {
    GesturesHelper.activeHandler.OnMouseUp(evt);
    GesturesHelper.activeHandler = null;
    window.setTimeout(function () { GesturesHelper.isExecutedGesture = false; }, 0);
   }
  },
  AttachEvents: function () {
   if(!GesturesHelper.isAttachedEvents) {
    GesturesHelper.Attach(ASPx.Evt.AttachEventToElement);
    GesturesHelper.isAttachedEvents = true;
   }
  },
  DetachEvents: function () {
   if(GesturesHelper.isAttachedEvents) {
    GesturesHelper.Attach(ASPx.Evt.DetachEventFromElement);
    GesturesHelper.isAttachedEvents = false;
   }
  },
  Attach: function (changeEventsMethod) {
   var doc = window.document;
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseDownEventName, GesturesHelper.OnDocumentMouseDown);
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseMoveEventName, GesturesHelper.OnDocumentMouseMove);
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseUpEventName, GesturesHelper.OnDocumentMouseUp);
   if(!ASPx.Browser.MobileUI) {
    changeEventsMethod(doc, "selectstart", GesturesHelper.OnDocumentSelectStart);
    changeEventsMethod(doc, "dragstart", GesturesHelper.OnDocumentDragStart);
   }
  },
  FindHandler: function (evt) {
   var handlers = [];
   for(var id in GesturesHelper.handlers) {
    if(GesturesHelper.handlers.hasOwnProperty(id)) {
     var handler = GesturesHelper.handlers[id];
     if(handler.CanHandleEvent && handler.CanHandleEvent(evt))
      handlers.push(handler);
    }
   }
   if(!handlers.length)
    return null;
   handlers.sort(function (a, b) {
    return ASPx.GetIsParent(a.getAnimationElement(), b.getAnimationElement()) ? 1 : -1;
   });
   return handlers[0];
  },
  IsExecutedGesture: function () {
   return GesturesHelper.isExecutedGesture;
  }
 };
 GesturesHelper.AttachEvents();
 var AnimationEngineType = {
  "DEFAULT": 0,
  "CSS": 1,
  "JS": 2
 };
 ASPx.AnimationEngineType = AnimationEngineType;
 ASPx.AnimationHelper = AnimationHelper;
 ASPx.GesturesHelper = GesturesHelper;
})();

(function() {
 var InitializeMobileScripts = function() {
  var customScrollableElementsCollection = [];
  var SCROLLBAR_CLASSNAMES = {
   VERTICAL: "dxTouchVScrollHandle",
   HORIZONTAL: "dxTouchHScrollHandle",
   SHOWN_VERTICAL: "dxTouchScrollHandleVisible",
   SHOWN_HORIZONTAL: "dxTouchScrollHandleVisible",
   CUSTOMIZED_NATIVE: "dxTouchNativeScrollHandle"
  };
  ASPx.Evt.AttachEventToDocument("gesturestart", function() {
   ASPx.TouchUIHelper.isGesture = true;
  });
  ASPx.Evt.AttachEventToDocument("gestureend", function() {
   ASPx.TouchUIHelper.isGesture = false;
  });
  ASPx.TouchUIHelper.MakeScrollable = function(element, options) {
   return new ASPx.TouchUIHelper.ScrollExtender(element, options);
  };
  ASPx.TouchUIHelper.ScrollExtender = function(element, options) {
   this.parseOptions(options ? options : {});
   this.create(element);
  };
  ASPx.TouchUIHelper.preventScrollOnEvent = function(evt) {
   evt.ASPxTouchUIScrollOff = true;
  };
  var isCustomScroll = function(elem) { return ASPx.Data.ArrayContains(customScrollableElementsCollection, elem); };
  var isNativeScroll = function(elem) {
   var style = window.getComputedStyle(elem);
   return ["overflow", "overflow-x", "overflow-y"].some(function(prop) {
    return ASPx.Data.ArrayContains(["scroll", "auto"], style[prop]);
   });
  };
  var requirePreventCustomScroll = function(elem, scrollElement) {
   if(!scrollElement)
    return;
   while(elem && elem !== scrollElement && elem.tagName !== 'BODY') {
    if(isNativeScroll(elem) || isCustomScroll(elem))
     return true;
    elem = elem.parentNode;
   }
   return false;
  };
  ASPx.TouchUIHelper.RequirePreventCustomScroll = requirePreventCustomScroll;
  ASPx.TouchUIHelper.InitNativeScrolling = function(element, options) {
   if(options.showHorizontalScrollbar || options.showVerticalScrollbar) {
    element.style["overflow"] = "scroll";
    element.style["overflow-x"] = options.showHorizontalScrollbar ? "scroll" : "hidden";
    element.style["overflow-y"] = options.showVerticalScrollbar ? "scroll" : "hidden";
    element.style["-webkit-overflow-scrolling"] = "touch";
    if(options.customizeNativeScrolling)
     ASPx.AddClassNameToElement(element, SCROLLBAR_CLASSNAMES.CUSTOMIZED_NATIVE);
   }
  };
  ASPx.TouchUIHelper.ScrollExtender.prototype = {
   ChangeElement: function(element) {
    this.Destroy();
    this.create(element);
   },
   Destroy: function() {
    this.destroyScrollHandlers();
    this.detachEventHandlers();
    ASPx.Data.ArrayRemove(customScrollableElementsCollection, this.element);
   },
   PreventAndStopScroll: function() {
    this.updateScrollHandles();
    this.stopScroll();
    this.ReleaseScrolling();
   },
   LockScrollUpdate: function() {
    this.scrollUpdateLocked = true;
   },
   UnlockScrollUpdate: function() {
    this.scrollUpdateLocked = false;
   },
   acceptElement: function(element) {
    if(typeof (element) == "string")
     element = document.getElementById(element);
    this.element = element;
    this.touchEventHandlersElement = this.options.touchEventHandlersElement ? this.options.touchEventHandlersElement : this.element;
    if(ASPx.Browser.AndroidMobilePlatform) {
     element.dxScrollable = true;
     element.style["overflow-x"] = "hidden";
     element.style["overflow-y"] = "hidden";
    }
    return element;
   },
   create: function(element) {
    this.acceptElement(element);
    if(this.options.nativeScrolling) {
     ASPx.TouchUIHelper.InitNativeScrolling(this.element, this.options);
    } else {
     customScrollableElementsCollection.push(this.element);
     if(ASPx.Browser.IE) {
      this.msGesture = new MSGesture();
      this.msGesture.target = this.element;
      this.pointerCount = 0;
     }
     this.createScrollHandlers();
     this.createEventHandlers();
     this.updateInitData();
     this.updateScrollHandles();
     this.attachEventHandlers();
    }
   },
   parseOptions: function(options) {
    this.options = {};
    this.options.showHorizontalScrollbar = options.showHorizontalScrollbar !== false;
    this.options.showVerticalScrollbar = options.showVerticalScrollbar !== false;
    this.options.acceleration = options.acceleration || 0.8;
    this.options.timeStep = options.timeStep || 50;
    this.options.minScrollbarSize = options.minScrollbarSize || 20;
    this.options.vScrollClassName = options.vScrollClassName || SCROLLBAR_CLASSNAMES.VERTICAL;
    this.options.hScrollClassName = options.hScrollClassName || SCROLLBAR_CLASSNAMES.HORIZONTAL;
    this.options.vScrollClassNameShown = [
     this.options.vScrollClassName,
     options.vScrollClassNameShown || SCROLLBAR_CLASSNAMES.SHOWN_VERTICAL
    ].join(" ");
    this.options.hScrollClassNameShown = [
     this.options.hScrollClassName,
     options.hScrollClassNameShown || SCROLLBAR_CLASSNAMES.SHOWN_HORIZONTAL
    ].join(" ");
    this.options.forceCustomScroll = options.forceCustomScroll === true;
    this.options.forceOnDesktop = options.forceOnDesktop === true;
    this.options.allowMouseWheelOnCtrl = options.allowMouseWheelOnCtrl !== false;
    var nativeScrollPossible = !options.acceleration && !options.timeStep && !options.minScrollbarSize && !options.vScrollClassName && !options.hScrollClassName && !options.forceCustomScroll;
    if(nativeScrollPossible && ASPx.TouchUIHelper.IsNativeScrolling())
     this.options.nativeScrolling = true;
    if(ASPx.Browser.AndroidMobilePlatform && ASPx.Browser.WebKitFamily)
     this.options.customizeNativeScrolling = true;
    this.options.touchEventHandlersElement = options.touchEventHandlersElement;
    this.options.scrollPageIfCannotScrollDiv = options.scrollPageIfCannotScrollDiv === true;
    this.options.enableMultiTouchScrolling = options.enableMultiTouchScrolling !== false;
   },
   createEventHandlers: function() {
    var instance = this;
    this.onTouchStart = function(e) {
     if(ASPx.Browser.IE) {
      instance.pointerCount++;
      instance.msGesture.addPointer(e.pointerId);
      if(instance.pointerCount != 1) return;
     }
     if(!instance.options.enableMultiTouchScrolling && ASPx.TouchUIHelper.IsMultiTouchEvent(e)) return;
     if(!ASPx.TouchUIHelper.isGesture) {
      if(!ASPx.TouchUIHelper.ScrollExtender.activeScrolling) {
       if(requirePreventCustomScroll(ASPx.Evt.GetEventSource(e), instance.touchEventHandlersElement)) {
        e.stopPropagation();
        return;
       }
       ASPx.TouchUIHelper.ScrollExtender.activeScrolling = instance;
       instance.startScroll(e);
      }
     }
    };
    this.onTouchMove = function(e) {
     if(ASPx.Browser.IE && instance.pointerCount != 1) return;
     if(!instance.options.enableMultiTouchScrolling && ASPx.TouchUIHelper.IsMultiTouchEvent(e)) return;
     if(e.cancelable && !ASPx.TouchUIHelper.isGesture && instance.ScrollingActive(e)) {
      var scrolled = instance.scroll(e);
      var alwaysPreventDefault = !instance.options.scrollPageIfCannotScrollDiv;
      if((instance.scrollBarsShown && alwaysPreventDefault) || (!alwaysPreventDefault && scrolled))
       ASPx.Evt.PreventEvent(e);
     }
    };
    this.onTouchEnd = function(e) {
     if(ASPx.Browser.IE) {
      if(instance.pointerCount == 0) return;
      instance.pointerCount--;
     }
     if(!instance.options.enableMultiTouchScrolling && ASPx.TouchUIHelper.IsMultiTouchEvent(e)) return;
     if(!ASPx.TouchUIHelper.isGesture) {
      instance.scrollLeft = instance.element.scrollLeft;
      instance.scrollTop = instance.element.scrollTop;
      instance.stopScroll();
      if(ASPx.TouchUIHelper.ScrollExtender.activeScrolling && ASPx.TouchUIHelper.ScrollExtender.activeScrolling.initTouchX == instance.initTouchX && ASPx.TouchUIHelper.ScrollExtender.activeScrolling.initTouchY == instance.initTouchY)
       instance.MouseEventEmulationProtectHelper.onTouchEnd(instance.initTouchX, instance.initTouchY, e);
      instance.ReleaseScrolling();
     }
    };
    this.onScroll = function(e) {
     if(ASPx.TouchUIHelper.isGesture && instance.ScrollingActive(e)) {
      instance.showScrollBars();
      instance.updateScrollHandles();
     }
    };
    this.onClick = function() {
     instance.MouseEventEmulationProtectHelper.onClick();
    };
    this.onHandleMouseDown = function(e, isVertical) {
     if(!ASPx.TouchUIHelper.ScrollExtender.activeHandlerDragging) {
      ASPx.TouchUIHelper.ScrollExtender.activeHandlerDragging = instance;
      instance.startHandleDrag(e, isVertical);
     }
    };
    this.onMouseMove = function(e) {
     if(instance.HandlerDraggingActive(e))
      instance.dragHandle(e);
    };
    this.onMouseUp = function(e) {
     if(instance.HandlerDraggingActive(e)) {
      instance.scrollLeft = instance.element.scrollLeft;
      instance.scrollTop = instance.element.scrollTop;
      instance.stopHandleDrag();
      instance.ReleaseHandlerDragging();
     }
    };
    this.onMouseOver = function() {
     if(!instance.scrollUpdateLocked) {
      instance.updateInitData();
      instance.showScrollBars();
      instance.updateScrollHandles();
     }
    };
    this.onMouseOut = function(e) {
     if(!instance.HandlerDraggingActive(e))
      instance.hideScrollBars();
    };
    this.onMouseWheel = function(e) {
     if(e.ctrlKey && !instance.options.allowMouseWheelOnCtrl) return;
     instance.showScrollBars();
     instance.updateScrollHandles();
     instance.offset(e.deltaX, e.deltaY);
     instance.updateScrollHandles();
     ASPx.Evt.PreventEventAndBubble(e);
    };
   },
   createScrollHandlers: function() {
    if(this.options.showHorizontalScrollbar) {
     this.hScrollHandleElement = document.createElement("DIV");
     this.hScrollHandleElement.className = this.options.hScrollClassName;
     this.element.appendChild(this.hScrollHandleElement);
     this.hEndMargin = this.options.showVerticalScrollbar ? ASPx.PxToInt(ASPx.GetCurrentStyle(this.hScrollHandleElement).marginRight) : 0;
    }
    if(this.options.showVerticalScrollbar) {
     this.vScrollHandleElement = document.createElement("DIV");
     this.vScrollHandleElement.className = this.options.vScrollClassName;
     this.element.appendChild(this.vScrollHandleElement);
     this.vEndMargin = this.options.showHorizontalScrollbar ? ASPx.PxToInt(ASPx.GetCurrentStyle(this.vScrollHandleElement).marginBottom) : 0;
    }
   },
   destroyScrollHandlers: function() {
    if(this.hScrollHandleElement && this.hScrollHandleElement.parentNode)
     this.hScrollHandleElement.parentNode.removeChild(this.hScrollHandleElement);
    if(this.vScrollHandleElement && this.vScrollHandleElement.parentNode)
     this.vScrollHandleElement.parentNode.removeChild(this.vScrollHandleElement);
    this.hScrollHandleElement = null;
    this.vScrollHandleElement = null;
   },
   attachEventHandlers: function() {
    if(ASPx.Browser.WebKitTouchUI) {
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "touchstart", this.onTouchStart, true);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "touchend", this.onTouchEnd, true);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "touchmove", this.onTouchMove, true);
    } else if(ASPx.Browser.IE && ASPx.Browser.WindowsPhonePlatform) {
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerDownEventName, this.onTouchStart, true);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, 'MSGestureEnd', this.onTouchEnd, true);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerUpEventName, this.onTouchEnd, true);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerCancelEventName, this.onTouchEnd, true);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerMoveEventName, this.onTouchMove, true);
    } else if(this.options.forceOnDesktop) {
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "mouseover", this.onMouseOver);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "mouseout", this.onMouseOut);
     ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "wheel", this.onMouseWheel);
     if(this.vScrollHandleElement)
      ASPx.Evt.AttachEventToElement(this.vScrollHandleElement, "mousedown", function(e) { this.onHandleMouseDown(e, true); }.bind(this));
     if(this.hScrollHandleElement)
      ASPx.Evt.AttachEventToElement(this.hScrollHandleElement, "mousedown", function(e) { this.onHandleMouseDown(e, false); }.bind(this));
     ASPx.Evt.AttachEventToDocument("mousemove", this.onMouseMove);
     ASPx.Evt.AttachEventToDocument("mouseup", this.onMouseUp);
    }
    ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "scroll", this.onScroll, true);
    ASPx.Evt.AttachEventToElement(this.touchEventHandlersElement, "click", this.onClick, true);
   },
   detachEventHandlers: function() {
    if(ASPx.Browser.WebKitTouchUI) {
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, "touchstart", this.onTouchStart, true);
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, "touchend", this.onTouchEnd, true);
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, "touchmove", this.onTouchMove, true);
    } else if(ASPx.Browser.IE) {
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerDownEventName, this.onTouchStart, true);
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, 'MSGestureEnd', this.onTouchEnd, true);
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerUpEventName, this.onTouchEnd, true);
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerCancelEventName, this.onTouchEnd, true);
     ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, ASPx.TouchUIHelper.pointerMoveEventName, this.onTouchMove, true);
    }
    ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, "scroll", this.onScroll, true);
    ASPx.Evt.DetachEventFromElement(this.touchEventHandlersElement, "click", this.onClick, true);
   },
   updateInitData: function() {
    window.clearTimeout(this.inertialStopTimerId);
    this.initScrollLeft = this.element.scrollLeft;
    this.initScrollTop = this.element.scrollTop;
    this.scrollLeft = this.initScrollLeft;
    this.scrollTop = this.initScrollTop;
    this.initElementX = ASPx.GetAbsoluteX(this.element);
    this.initElementY = ASPx.GetAbsoluteY(this.element);
    this.scrollTime = new Date();
    this.vx = 0;
    this.vy = 0;
    this.vxs = [];
    this.vys = [];
   },
   ScrollingActive: function(e) {
    return (!e || !e.ASPxTouchUIScrollOff) && ASPx.TouchUIHelper.ScrollExtender.activeScrolling == this;
   },
   ReleaseScrolling: function() {
    if(this.ScrollingActive())
     ASPx.TouchUIHelper.ScrollExtender.activeScrolling = null;
   },
   HandlerDraggingActive: function(e) {
    return (!e || !e.ASPxTouchUIScrollOff) && ASPx.TouchUIHelper.ScrollExtender.activeHandlerDragging == this;
   },
   ReleaseHandlerDragging: function() {
    if(this.HandlerDraggingActive())
     ASPx.TouchUIHelper.ScrollExtender.activeHandlerDragging = null;
   },
   startHandleDrag: function(e, isVertical) {
    this.startScroll(e, { x: ASPx.Evt.GetEventX(e), y: ASPx.Evt.GetEventY(e) });
    this.isVerticalHandle = isVertical;
   },
   dragHandle: function(e) {
    var x = ASPx.Evt.GetEventX(e),
     y = ASPx.Evt.GetEventY(e),
     opts = this.options,
     el = this.element,
     vert = this.isVerticalHandle;
    var deltaY = y - this.initTouchY,
     deltaX = x - this.initTouchX;
    var applyScrollX = opts.showHorizontalScrollbar;
    var applyScrollY = opts.showVerticalScrollbar;
    if(applyScrollY && vert && this.vScrollHandleElement) {
     var vScrollHandler = this.calcScrollHandles(el.scrollHeight, el.clientHeight,
      opts.minScrollbarSize, 1, this.vEndMargin);
     var newY = this.initScrollTop + deltaY / vScrollHandler.pos;
     this.scrollTop = newY;
     el.scrollTop = newY;
    }
    if(applyScrollX && !vert && this.hScrollHandleElement) {
     var hScrollHandler = this.calcScrollHandles(el.scrollWidth, el.clientWidth,
      opts.minScrollbarSize, 1, this.hEndMargin);
     var newX = this.initScrollLeft + deltaX / hScrollHandler.pos;
     this.scrollLeft = newX;
     el.scrollLeft = newX;
    }
    this.updateScrollHandles();
   },
   stopHandleDrag: function() {
    this.isVerticalHandle = null;
   },
   startScroll: function(e, point) {
    this.initTouchX = point ? point.x : ASPx.TouchUIHelper.getEventX(e);
    this.initTouchY = point ? point.y : ASPx.TouchUIHelper.getEventY(e);
    this.lastTouchX = this.initTouchX;
    this.lastTouchY = this.initTouchY;
    this.updateInitData();
    this.updateScrollHandles();
    this.showScrollBars();
   },
   scroll: function(e) {
    var el = this.element;
    var opts = this.options;
    var currentTouchX = ASPx.TouchUIHelper.getEventX(e);
    var currentTouchY = ASPx.TouchUIHelper.getEventY(e);
    var newX = this.initScrollLeft + (this.initTouchX - currentTouchX);
    var newY = this.initScrollTop + (this.initTouchY - currentTouchY);
    var dt = (new Date() - this.scrollTime);
    if(dt < 1) dt = 1;
    var dx = this.lastTouchX - currentTouchX;
    var dy = this.lastTouchY - currentTouchY;
    this.lastTouchX = currentTouchX;
    this.lastTouchY = currentTouchY;
    this.vx = dx / dt;
    this.vy = dy / dt;
    this.vxs.push(this.vx);
    this.vys.push(this.vy);
    var applyScrollX = opts.showHorizontalScrollbar;
    var applyScrollY = opts.showVerticalScrollbar;
    var stuck = false;
    if(opts.scrollPageIfCannotScrollDiv) {
     var sensitivity = 5;
     var dxSignificant = Math.abs(dx) > sensitivity;
     var dySignificant = Math.abs(dy) > sensitivity;
     var xStuck = !applyScrollX;
     var yStuck = !applyScrollY;
     xStuck = xStuck || (this.scrollLeft == 0 && dx < 0);
     xStuck = xStuck || (this.scrollLeft == el.scrollWidth - el.clientWidth && dx > 0);
     xStuck = xStuck && dxSignificant && Math.abs(dx) > Math.abs(dy);
     yStuck = yStuck || (this.scrollTop == 0 && dy < 0);
     yStuck = yStuck || (this.scrollTop == el.scrollHeight - el.clientHeight && dy > 0);
     yStuck = yStuck && dySignificant && Math.abs(dy) > Math.abs(dx);
     stuck = xStuck || yStuck;
     applyScrollX = !stuck;
     applyScrollY = !stuck;
    }
    if(applyScrollX) {
     this.scrollLeft = newX;
     el.scrollLeft = newX;
    }
    if(applyScrollY) {
     this.scrollTop = newY;
     el.scrollTop = newY;
    }
    if(stuck) {
     this.scrollLeft = el.scrollLeft;
     this.scrollTop = el.scrollTop;
    }
    this.updateScrollHandles();
    this.scrollTime = new Date();
    var scrolled = applyScrollX || applyScrollY;
    return scrolled;
   },
   stopScroll: function() {
    var instance = this;
    var element = this.element;
    var acceleration = this.options.acceleration;
    var timeStep = this.options.timeStep;
    if(this.vxs && this.vxs.length === 0) return;
    if(this.vxs) {
     var countToSmooth = 3;
     var lenToSlice = Math.max(this.vxs.length - countToSmooth, 0);
     this.vxs = this.vxs.slice(lenToSlice);
     this.vys = this.vys.slice(lenToSlice);
     this.vx = Math.min.apply(null, this.vxs);
     if(this.vx < 0)
      this.vx = Math.max.apply(null, this.vxs);
     this.vy = Math.min.apply(null, this.vys);
     if(this.vy < 0)
      this.vy = Math.max.apply(null, this.vys);
     delete this.vxs;
     delete this.vys;
    }
    this.inertialStopTimerId = window.setTimeout(function() {
     instance.vx *= acceleration;
     instance.vy *= acceleration;
     if(Math.abs(instance.vx) < 0.1)
      instance.vx = 0;
     if(Math.abs(instance.vy) < 0.1)
      instance.vy = 0;
     if(instance.vx == 0 && instance.vy == 0) {
      instance.hideScrollBars();
      return;
     }
     var dx = Math.ceil(instance.vx * timeStep);
     var dy = Math.ceil(instance.vy * timeStep);
     if(instance.options.showHorizontalScrollbar) {
      instance.scrollLeft += dx;
      element.scrollLeft = instance.scrollLeft;
     }
     if(instance.options.showVerticalScrollbar) {
      instance.scrollTop += dy;
      element.scrollTop = instance.scrollTop;
     }
     if(element.scrollLeft + element.clientWidth >= element.scrollWidth || element.scrollLeft <= 0)
      instance.vx = 0;
     if(element.scrollTop + element.clientHeight >= element.scrollHeight || element.scrollTop <= 0)
      instance.vy = 0;
     instance.updateScrollHandles();
     instance.stopScroll();
    }, timeStep);
   },
   offset: function(deltaX, deltaY) {
    var el = this.element;
    var opts = this.options;
    var applyScrollX = opts.showHorizontalScrollbar;
    var applyScrollY = opts.showVerticalScrollbar;
    if(applyScrollX) {
     el.scrollLeft += deltaX;
     this.scrollLeft = el.scrollLeft;
    }
    if(applyScrollY) {
     el.scrollTop += deltaY;
     this.scrollTop = el.scrollTop;
    }
    this.updateScrollHandles();
   },
   updateScrollHandles: function() {
    if(this.hScrollHandleElement) {
     var scrollHandler = this.calcScrollHandles(this.element.scrollWidth, this.element.clientWidth,
      this.options.minScrollbarSize, this.element.scrollLeft, this.hEndMargin);
     this.hScrollHandleElement.style.width = scrollHandler.size + "px";
     ASPx.SetAbsoluteX(this.hScrollHandleElement, this.initElementX + scrollHandler.pos);
     ASPx.SetAbsoluteY(this.hScrollHandleElement, this.initElementY + this.element.clientHeight -
      this.hScrollHandleElement.offsetHeight);
    }
    if(this.vScrollHandleElement) {
     var scrollHandler = this.calcScrollHandles(this.element.scrollHeight, this.element.clientHeight,
      this.options.minScrollbarSize, this.element.scrollTop, this.vEndMargin);
     this.vScrollHandleElement.style.height = scrollHandler.size + "px";
     ASPx.SetAbsoluteX(this.vScrollHandleElement, this.initElementX + this.element.clientWidth - this.vScrollHandleElement.offsetWidth);
     ASPx.SetAbsoluteY(this.vScrollHandleElement, this.initElementY + scrollHandler.pos);
    }
   },
   calcScrollHandles: function(scrollSize, clientSize, scrollBarMinSize, scrollPos, endMargin) {
    var scrollBarMaxSize = clientSize - endMargin;
    var scrollBarSize = clientSize * clientSize / scrollSize;
    scrollBarSize = Math.min(scrollBarMaxSize, Math.max(scrollBarMinSize, scrollBarSize));
    var k = (scrollSize == clientSize) ? 0 :
     (clientSize - scrollBarSize - endMargin) / (scrollSize - clientSize);
    return { size: scrollBarSize, pos: scrollPos * k };
   },
   showScrollBars: function() {
    var needVScrollHandle = this.element.scrollHeight > this.element.clientHeight;
    var needHScrollHandle = this.element.scrollWidth > this.element.clientWidth;
    if(this.vScrollHandleElement && needVScrollHandle)
     this.vScrollHandleElement.className = this.options.vScrollClassNameShown;
    if(this.hScrollHandleElement && needHScrollHandle)
     this.hScrollHandleElement.className = this.options.hScrollClassNameShown;
    this.scrollBarsShown = needVScrollHandle || needHScrollHandle;
   },
   hideScrollBars: function() {
    if(this.vScrollHandleElement)
     this.vScrollHandleElement.className = this.options.vScrollClassName;
    if(this.hScrollHandleElement)
     this.hScrollHandleElement.className = this.options.hScrollClassName;
    this.scrollBarsShown = false;
   },
   MouseEventEmulationProtectHelper: {
    onTouchEnd: function(initTouchX, initTouchY, e) {
     var difX = initTouchX - ASPx.TouchUIHelper.getEventX(e);
     var difY = initTouchY - ASPx.TouchUIHelper.getEventY(e);
     if(Math.abs(difX) > ASPx.TouchUIHelper.clickSensetivity || Math.abs(difY) > ASPx.TouchUIHelper.clickSensetivity) {
      ASPx.TouchUIHelper.isMouseEventFromScrolling = true;
      window.setTimeout(function() { ASPx.TouchUIHelper.isMouseEventFromScrolling = false; }, 100);
     }
    },
    onClick: function() {
     if(ASPx.TouchUIHelper.isMouseEventFromScrolling) {
      window.setTimeout(function() { ASPx.TouchUIHelper.isMouseEventFromScrolling = false; }, 0);
     }
    }
   }
  };
  ASPx.TouchUIHelper.FastTapHelper = (function() {
   var actions = [];
   var DISTANCE_LIMIT = 10;
   var startX;
   var startY;
   var preventCommonClickEvents = false;
   var invokeActions = function(actions) {
    for(var i = 0; i < actions.length; i++)
     actions[i]();
   };
   var onTouchStart = function(e) {
    if(preventCommonClickEvents)
     e.stopPropagation();
    if(actions.length > 1)
     return;
    startX = e.touches[0].clientX;
    startY = e.touches[0].clientY;
    if(ASPx.Browser.AndroidDefaultBrowser)
     ASPx.Evt.AttachEventToElement(e.currentTarget, "click", onClick, true);
    else
     ASPx.Evt.AttachEventToElement(e.currentTarget, "touchend", onTouchEnd, true);
   };
   if(ASPx.Browser.AndroidDefaultBrowser) {
    var onClick = function(e) {
     invokeActions(actions);
     actions = [];
     ASPx.Evt.DetachEventFromElement(e.currentTarget, "click", onClick, true);
    };
   } else {
    var onTouchEnd = function(e) {
     if(preventCommonClickEvents)
      ASPx.Evt.PreventEventAndBubble(e);
     var stopX = e.changedTouches[0].clientX;
     var stopY = e.changedTouches[0].clientY;
     var distanceX = Math.abs(startX - stopX);
     var distanceY = Math.abs(startY - stopY);
     var allowClick = distanceX < DISTANCE_LIMIT && distanceY < DISTANCE_LIMIT;
     if(allowClick) {
      var actionsToInvoke = actions;
      setTimeout(function() { invokeActions(actionsToInvoke); }, 0);
     }
     actions = [];
     ASPx.Evt.DetachEventFromElement(e.currentTarget, "touchend", onTouchEnd, true);
    };
   }
   return {
    HandleFastTap: function(e, tapAction, preventClickEvents) {
     if(e.touches.length > 1)
      return;
     preventCommonClickEvents = preventClickEvents;
     actions.push(tapAction);
     onTouchStart(e);
    }
   };
  })();
  ASPx.TouchUIHelper.doubleTapEventName = "dxDoubleTap";
  ASPx.TouchUIHelper.allowDoubleTapProcessing = function(e) {
   var DOUBLE_TAP_DELAY = 600;
   var DISTANCE_LIMIT = 10;
   var currentTapTime = e.timeStamp;
   var currentX = e.changedTouches[0].clientX;
   var currentY = e.changedTouches[0].clientY;
   var lastTapTime = this["lastTap"] || currentTapTime;
   var lastX = this["lastX"] || currentX;
   var lastY = this["lastY"] || currentY;
   this["lastTap"] = currentTapTime;
   this["lastX"] = currentX;
   this["lastY"] = currentY;
   var delay = currentTapTime - lastTapTime;
   return delay && delay <= DOUBLE_TAP_DELAY && e.touches.length === 1 &&
    Math.abs(currentX - lastX) <= DISTANCE_LIMIT &&
    Math.abs(currentY - lastY) <= DISTANCE_LIMIT;
  };
  ASPx.TouchUIHelper.AttachDoubleTapEventToElement = function(element, action) {
   var onTouchEnd = function(e) {
    ASPx.Evt.DetachEventFromElement(e.currentTarget, "touchend", onTouchEnd, true);
    e[ASPx.TouchUIHelper.doubleTapEventName] = true;
    var startActionAfterFastTap = function() {
     window.setTimeout(function() { action(e); }, 0);
    };
    startActionAfterFastTap();
   };
   var onTouchStart = function(e) {
    if(ASPx.TouchUIHelper.allowDoubleTapProcessing(e)) {
     var preventZoom = function() { ASPx.Evt.PreventEvent(e); };
     preventZoom();
     ASPx.Evt.AttachEventToElement(e.currentTarget, "touchend", onTouchEnd, true);
    }
   };
   ASPx.Evt.AttachEventToElement(element, "touchstart", onTouchStart, true);
  };
  ASPx.TouchUIHelper.HasCustomizedNativeScrollBarClass = function(element) {
   return element && ASPx.ElementHasCssClass(element, SCROLLBAR_CLASSNAMES.CUSTOMIZED_NATIVE);
  };
  ASPx.TouchUIHelper.IsMultiTouchEvent = function(e) {
   return e.touches && e.touches.length > 1;
  };
  window.ASPxClientTouchUI = {};
  window.ASPxClientTouchUI.MakeScrollable = ASPx.TouchUIHelper.MakeScrollable;
  window.ASPxClientTouchUI.ScrollExtender = ASPx.TouchUIHelper.ScrollExtender;
 };
 ASPx.InitializeMobileScripts = InitializeMobileScripts;
 var isMacOSOrIPadSafari = ASPx.Browser.MacOSPlatform && !ASPx.Browser.MacOSMobilePlatform && ASPx.Browser.Safari && ASPx.Browser.MajorVersion >= 13; 
 if(!isMacOSOrIPadSafari) 
  InitializeMobileScripts();
})(ASPx || (ASPx = {}));
(function() {
var RelatedControlManager = {
 storage: { },
 GetRelatedCollection: function(masterName) {
  if(!this.storage[masterName])
   this.storage[masterName] = [ ];
  return this.storage[masterName];
 },
 RegisterRelatedControl: function(masterName, name) {
  this.GetRelatedCollection(masterName)[name] = name;
 },
 RegisterRelatedControls: function(masterName, names) {
  var relatedCollection = this.GetRelatedCollection(masterName);
  var name;
  for(var i = 0; i < names.length; i++) {
   name = names[i];
   relatedCollection[name] = name;
  }
 },
 GetLinkedControls: function(masterControl) {
  var result = [masterControl];
  var collection = this.GetRelatedCollection(masterControl.name); 
  for(var name in collection) {
   if(collection.hasOwnProperty(name)) {
    var control = ASPx.GetControlCollection().Get(name);
    if(control)
     result.push(control);
   }
  }
  return result;
 },
 coverCache: { },
 panelCache: { },
 timers: { },
 Shade: function(masterControl) {  
  this.ShadeCore(masterControl, true);
  this.timers[masterControl.name] = window.setTimeout(function() { ASPx.RelatedControlManager.ShadeTransition(masterControl.name); }, 750);
 },
 ShadeCore: function(masterControl, isTransparent) {
  if(!isTransparent) {
   this.panelCache[masterControl.name] = masterControl.ShowLoadingPanel();
  } 
  var controls = this.GetLinkedControls(masterControl);
  for(var i = 0; i < controls.length; i++) {
   var control = controls[i];
   var cover = control.CreateLoadingDiv(document.body, control.GetMainElement());
   if(ASPx.IsExistsElement(cover)) {
    if(isTransparent) {
     cover.className = "";
     cover.style.background = "white";         
     if(ASPx.Browser.IE)
      cover.style.filter = "alpha(opacity=1)";
     else
      cover.style.opacity = "0.01";
    }
    this.coverCache[control.name] = cover;
   }
  }  
 },
 ShadeTransition: function(masterName) {
  var obj = ASPx.GetControlCollection().Get(masterName);
  if(obj) {
   this.Unshade(obj);
   this.ShadeCore(obj, false);
  }
 },
 Unshade: function(masterControl) {
  var masterName = masterControl.name;
  ASPx.Timer.ClearTimer(this.timers[masterName]);
  delete this.timers[masterName];
  var panel = this.panelCache[masterName];
  if(ASPx.IsExistsElement(panel))
   ASPx.RemoveElement(panel);
  delete this.panelCache[masterName];
  var controls = this.GetLinkedControls(masterControl);
  for(var i = 0; i < controls.length; i++) {
   var control = controls[i];
   var cover = this.coverCache[control.name];
   if(ASPx.IsExistsElement(cover))
    ASPx.RemoveElement(cover);    
   delete this.coverCache[control.name];
  }
 },
 CreateInfo: function() {
  return { 
   clientObjectName:   "",
   elementId:    "",
   innerHtml:    "",
   parameters:   ""
  }; 
 },
 ProcessInfo: function(info) {
  var control = ASPx.GetControlCollection().Get(info.clientObjectName);  
  if(!control || !ASPx.IsFunction(control.ProcessCallbackResult))
   this.ProcessCallbackResultDefault(info.elementId, info.innerHtml, info.parameters);
  else
   control.ProcessCallbackResult(info.elementId, info.innerHtml, info.parameters);
 },
 ProcessCallbackResultDefault: function(elementId, innerHtml, parameters) {
  var element = ASPx.GetElementById(elementId);
  if(ASPx.IsExistsElement(element))
   element.innerHTML = innerHtml;  
 },
 ParseResult: function(result) {
  if(!result)
   return;
  result.forEach(function(controlResult) {
   var info = this.CreateInfo();
   info.clientObjectName = controlResult[0];
   info.elementId = controlResult[1];
   info.innerHtml = controlResult[2];
   info.parameters = controlResult[3];
   this.ProcessInfo(info);
  }, this);
 }
};
ASPx.RelatedControlManager = RelatedControlManager;
})();
(function () {
var PopupUtils = {
 NotSetAlignIndicator: "NotSet",
 InnerAlignIndicator: "Sides",
 OutsideLeftAlignIndicator: "OutsideLeft",
 LeftSidesAlignIndicator: "LeftSides",
 RightSidesAlignIndicator: "RightSides",
 OutsideRightAlignIndicator: "OutsideRight",
 CenterAlignIndicator: "Center",
 AboveAlignIndicator: "Above",
 TopSidesAlignIndicator: "TopSides",
 MiddleAlignIndicator: "Middle",
 BottomSidesAlignIndicator: "BottomSides",
 BelowAlignIndicator: "Below",
 WindowCenterAlignIndicator: "WindowCenter",
 LeftAlignIndicator: "Left",
 RightAlignIndicator: "Right",
 TopAlignIndicator: "Top",
 BottomAlignIndicator: "Bottom",
 WindowLeftAlignIndicator: "WindowLeft",
 WindowRightAlignIndicator: "WindowRight",
 WindowTopAlignIndicator: "WindowTop",
 WindowBottomAlignIndicator: "WindowBottom",
 IsAlignNotSet: function (align) {
  return align == PopupUtils.NotSetAlignIndicator;
 },
 IsInnerAlign: function (align) {
  return align.indexOf(PopupUtils.InnerAlignIndicator) != -1;
 },
 IsRightSidesAlign: function(align) {
  return align == PopupUtils.RightSidesAlignIndicator;
 },
 IsOutsideRightAlign: function(align) {
  return align == PopupUtils.OutsideRightAlignIndicator;
 },
 IsCenterAlign: function(align) {
  return align == PopupUtils.CenterAlignIndicator;
 },
 FindPopupElementById: function (id) {
  if(id == "")
   return null; 
  var popupElement = ASPx.GetElementById(id);
  if(!ASPx.IsExistsElement(popupElement)) {
   var idParts = id.split("_");
   var uniqueId = idParts.join("$");
   popupElement = ASPx.GetElementById(uniqueId);
  }
  return popupElement;
 },
 FindEventSourceParentByTestFunc: function (evt, testFunc) {
  return ASPx.GetParent(ASPx.Evt.GetEventSource(evt), testFunc);
 },
 PreventContextMenu: function (evt) {
  ASPx.Evt.PreventEventAndBubble(evt);
  if(ASPx.Browser.WebKitFamily)
   evt.returnValue = false;
 },
 GetDocumentClientWidthForPopup: function() {
  return ASPx.Browser.WebKitTouchUI ? document.body.offsetWidth : ASPx.GetDocumentClientWidth();
 },
 GetDocumentClientHeightForPopup: function() {
  return ASPx.Browser.WebKitTouchUI ? document.body.offsetHeight : ASPx.GetDocumentClientHeight();
 },
 AdjustPositionToClientScreen: function (element, pos, rtl, isX) {
  var min = isX ? ASPx.GetDocumentScrollLeft() : ASPx.GetDocumentScrollTop(),
   max = min + (isX ? ASPx.GetDocumentClientWidth() : ASPx.GetDocumentClientHeight());
  max -= (isX ? element.offsetWidth : element.offsetHeight);
  if(rtl && isX) {
   if(pos < min) pos = min;
   if(pos > max) pos = max;
  } else {
   if(pos > max) pos = max;
   if(pos < min) pos = min;
  }
  return pos;
 },
 GetPopupAbsoluteX: function(element, popupElement, hAlign, hOffset, x, left, rtl, isPopupFullCorrectionOn, showPopupInsideScreenBounds) {
  return PopupUtils.getPopupAbsolutePos(element, popupElement, hAlign, hOffset, x, left, rtl, isPopupFullCorrectionOn, false, false, true, showPopupInsideScreenBounds);
 },
 GetPopupAbsoluteY: function(element, popupElement, vAlign, vOffset, y, top, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, showPopupInsideScreenBounds) {
  return PopupUtils.getPopupAbsolutePos(element, popupElement, vAlign, vOffset, y, top, false, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, false, showPopupInsideScreenBounds);
 },
 getPopupAbsolutePos: function(element, popupElement, align, offset, startPos, startPosInit, rtl, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, isHorizontal, showPopupInsideScreenBounds) {
  var calculator = getPositionCalculator();
  calculator.applyParams(element, popupElement, align, offset, startPos, startPosInit, rtl, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, isHorizontal, showPopupInsideScreenBounds);
  var position = calculator.getPopupAbsolutePos();
  calculator.disposeState();
  return position;
 },
 RemoveFocus: function (parent) {
  var div = document.createElement('div');
  div.tabIndex = "-1";
  PopupUtils.ConcealDivElement(div);
  parent.appendChild(div);
  if(ASPx.IsFocusable(div))
   div.focus();
  ASPx.RemoveElement(div);
 },
 ConcealDivElement: function (div) {
  div.style.position = "absolute";
  div.style.left = 0;
  div.style.top = 0;
  if(ASPx.Browser.WebKitFamily) {
   div.style.opacity = 0;
   div.style.width = 1;
   div.style.height = 1;
  } else {
   div.style.border = 0;
   div.style.width = 0;
   div.style.height = 0;
  }
 },
 InitAnimationProperties: function(element, onAnimStopCallString) {
  element.popuping = true;
  element.onAnimStopCallString = onAnimStopCallString;
 },
 InitAnimationDiv: function (element, x, y, onAnimStopCallString, skipSizeInit) {
  PopupUtils.InitAnimationProperties(element, onAnimStopCallString);
  PopupUtils.InitAnimationDivCore(element);
  if(!skipSizeInit) {
   ASPx.SetStyles(element, { width: "", height: "" });
   ASPx.SetStyles(element, { width: element.offsetWidth, height: element.offsetHeight });
  }
  ASPx.SetStyles(element, { left: x, top: y });
 },
 InitAnimationDivCore: function (element) {
  ASPx.SetStyles(element, {
   overflow: "hidden",
   position: "absolute"
  });
 },
 StartSlideAnimation: function (animationDivElement, element, iframeElement, duration, preventChangingWidth, preventChangingHeight) {
  if(iframeElement) {
   var endLeft = ASPx.PxToInt(iframeElement.style.left);
   var endTop = ASPx.PxToInt(iframeElement.style.top);
   var startLeft = ASPx.PxToInt(element.style.left) < 0 ? endLeft : animationDivElement.offsetLeft + animationDivElement.offsetWidth;
   var startTop = ASPx.PxToInt(element.style.top) < 0 ? endTop : animationDivElement.offsetTop + animationDivElement.offsetHeight;
   var properties = {
    left: { from: startLeft, to: endLeft, unit: "px" },
    top: { from: startTop, to: endTop, unit: "px" }
   };
   if(!preventChangingWidth)
    properties.width = { to: element.offsetWidth, unit: "px" };
   if(!preventChangingHeight)
    properties.height = { to: element.offsetHeight, unit: "px" };
   ASPx.AnimationHelper.createMultipleAnimationTransition(iframeElement, {
    duration: duration
   }).Start(properties);
  }
  ASPx.AnimationHelper.createMultipleAnimationTransition(element, {
   duration: duration,
   onComplete: function () { PopupUtils.AnimationFinished(animationDivElement, element); }
  }).Start({
   left: { to: 0, unit: "px" },
   top: { to: 0, unit: "px" }
  });
 },
 AnimationFinished: function (animationDivElement, element) {
  if(PopupUtils.StopAnimation(animationDivElement, element) && ASPx.IsExists(animationDivElement.onAnimStopCallString) &&
   animationDivElement.onAnimStopCallString !== "") {
   window.setTimeout(animationDivElement.onAnimStopCallString, 0);
  }
 },
 StopAnimation: function (animationDivElement, element) {
  if(animationDivElement.popuping) {
   ASPx.AnimationHelper.cancelAnimation(element);
   animationDivElement.popuping = false;
   animationDivElement.style.overflow = "visible";
   return true;
  }
  return false;
 },
 GetAnimationHorizontalDirection: function (popupPosition, horizontalAlign, verticalAlign, rtl) {
  if(PopupUtils.IsInnerAlign(horizontalAlign)
   && !PopupUtils.IsInnerAlign(verticalAlign)
   && !PopupUtils.IsAlignNotSet(verticalAlign))
   return 0;
  var toTheLeft = (horizontalAlign == PopupUtils.OutsideLeftAlignIndicator || horizontalAlign == PopupUtils.RightSidesAlignIndicator || (horizontalAlign == PopupUtils.NotSetAlignIndicator && rtl)) ^ popupPosition.isInverted;
  return toTheLeft ? 1 : -1;
 },
 GetAnimationVerticalDirection: function (popupPosition, horizontalAlign, verticalAlign) {
  if(PopupUtils.IsInnerAlign(verticalAlign)
   && !PopupUtils.IsInnerAlign(horizontalAlign)
   && !PopupUtils.IsAlignNotSet(horizontalAlign))
   return 0;
  var toTheTop = (verticalAlign == PopupUtils.AboveAlignIndicator || verticalAlign == PopupUtils.BottomSidesAlignIndicator) ^ popupPosition.isInverted;
  return toTheTop ? 1 : -1;
 },
 IsVerticalScrollExists: function () {
  var scrollIsNotHidden = ASPx.GetCurrentStyle(document.body).overflowY !== "hidden" && ASPx.GetCurrentStyle(document.documentElement).overflowY !== "hidden";
  return (scrollIsNotHidden && ASPx.GetDocumentHeight() > ASPx.GetDocumentClientHeight());
 },
 CoordinatesInDocumentRect: function (x, y) {
  var docScrollLeft = ASPx.GetDocumentScrollLeft();
  var docScrollTop = ASPx.GetDocumentScrollTop();
  return (x > docScrollLeft && y > docScrollTop &&
   x < ASPx.GetDocumentClientWidth() + docScrollLeft &&
   y < ASPx.GetDocumentClientHeight() + docScrollTop);
 },
 GetElementZIndexArray: function (element) {
  var currentElement = element;
  var zIndexesArray = [0];
  while(currentElement && currentElement.tagName != "BODY") {
   if(currentElement.style) {
    if(typeof (currentElement.style.zIndex) != "undefined" && currentElement.style.zIndex != "")
     zIndexesArray.unshift(currentElement.style.zIndex);
   }
   currentElement = currentElement.parentNode;
  }
  return zIndexesArray;
 },
 IsHigher: function (higherZIndexArrat, zIndexArray) {
  if(zIndexArray == null) return true;
  var count = (higherZIndexArrat.length >= zIndexArray.length) ? higherZIndexArrat.length : zIndexArray.length;
  for(var i = 0; i < count; i++)
   if(typeof (higherZIndexArrat[i]) != "undefined" && typeof (zIndexArray[i]) != "undefined") {
    var higherZIndexArrayCurrentElement = parseInt(higherZIndexArrat[i].toString());
    var zIndexArrayCurrentElement = parseInt(zIndexArray[i].toString());
    if(higherZIndexArrayCurrentElement != zIndexArrayCurrentElement)
     return higherZIndexArrayCurrentElement > zIndexArrayCurrentElement;
   } else return typeof (zIndexArray[i]) == "undefined";
  return true;
 },
 TestIsPopupElement: function (element) {
  return !!element.DXPopupElementControl;
 },
 adjustViewportScrollWrapper: function(wrapper, wrapperScroll, windowElement) {
  var document = wrapper.ownerDocument;
  var window = document.defaultView || document.parentWindow;
  var isWindowElementDisplayed = ASPx.IsElementDisplayed(windowElement);
  if(!isWindowElementDisplayed) {
   wrapper.style.cssText = "";
   wrapperScroll.style.cssText = "";
   return; 
  }
  var windowRect = windowElement.getBoundingClientRect();
  var yAxis = this.calculateViewPortScrollDataByAxis(wrapper.style.top, windowRect.top, windowElement.offsetHeight, window.innerHeight, wrapper.scrollTop);
  var xAxis = this.calculateViewPortScrollDataByAxis(wrapper.style.left, windowRect.left, windowElement.offsetWidth, window.innerWidth, wrapper.scrollLeft);
  this.prepareViewPortScrollData(xAxis, yAxis);
  ASPx.SetStyles(windowElement, {
   top: yAxis.windowOffset,
   left: xAxis.windowOffset
  });
  ASPx.SetStyles(wrapper, {
   width: xAxis.wrapperSize,
   height: yAxis.wrapperSize,
   position: "absolute",
   overflow: ASPx.Browser.MobileUI ? "scroll" : "auto",
   zIndex: windowElement.style.zIndex
  });
  ASPx.SetAbsoluteX(wrapper, ASPx.GetDocumentScrollLeft());
  ASPx.SetAbsoluteY(wrapper, ASPx.GetDocumentScrollTop());
  ASPx.SetStyles(wrapperScroll, {
   width: xAxis.wrapperScrollSize,
   height: yAxis.wrapperScrollSize,
   position: "absolute",
   overflow: "hidden"
  });
  wrapper.scrollLeft = xAxis.scrollSize;
  wrapper.scrollTop = yAxis.scrollSize;
 },
 calculateViewPortScrollDataByAxis: function(wrapperOffsetStyle, windowOffset, windowSize, viewPortSize, scrollSize) {
  var isWindowOffsetNegative = windowOffset < 0;
  windowOffset = isWindowOffsetNegative ? 0 : windowOffset;
  var wrapperScrollSize = Math.max(viewPortSize + Math.abs(Math.min(0, windowOffset)), windowSize + Math.abs(windowOffset));
  return { 
   windowOffset: isWindowOffsetNegative ? 0 : windowOffset,
   wrapperSize: viewPortSize,
   wrapperScrollSize: wrapperScrollSize,
   scrollSize: isWindowOffsetNegative ? scrollSize + Math.abs(windowOffset) : 0,
   hasScroll: wrapperScrollSize > viewPortSize
  };
 },
 prepareViewPortScrollData: function(xAxis, yAxis) {
  var scrollBarSize = ASPx.GetVerticalScrollBarWidth();
  if(yAxis.hasScroll && !xAxis.hasScroll) {
   xAxis.wrapperScrollSize = Math.min(xAxis.wrapperSize - scrollBarSize, xAxis.wrapperScrollSize);
  } else if(xAxis.hasScroll && !yAxis.hasScroll) {
   yAxis.wrapperScrollSize = Math.min(yAxis.wrapperSize - scrollBarSize, yAxis.wrapperScrollSize);
  } else if(yAxis.hasScroll && xAxis.hasScroll) {
   yAxis.wrapperScrollSize -= scrollBarSize;
   xAxis.wrapperScrollSize -= scrollBarSize;
  }
 }
};
PopupUtils.OverControl = {
 GetPopupElementByEvt: function (evt) {
  return PopupUtils.FindEventSourceParentByTestFunc(evt, PopupUtils.TestIsPopupElement);
 },
 OnMouseEvent: function (evt, mouseOver) {
  var popupElement = PopupUtils.OverControl.GetPopupElementByEvt(evt);
  if(mouseOver)
   popupElement.DXPopupElementControl.OnPopupElementMouseOver(evt, popupElement);
  else
   popupElement.DXPopupElementControl.OnPopupElementMouseOut(evt, popupElement);
 },
 OnMouseOut: function (evt) {
  PopupUtils.OverControl.OnMouseEvent(evt, false);
 },
 OnMouseOver: function (evt) {
  PopupUtils.OverControl.OnMouseEvent(evt, true);
 }
};
PopupUtils.BodyScrollHelper = (function () {
 var windowScrollLock = {},
  windowScroll = {},
  hideScrollbarsClassName = "dxpc-hideScrollbars",
  savedHtmlOverflow = "";
 function lockWindowScroll(windowId) {
  windowScrollLock[windowId] = true;
 }
 function unlockWindowScroll(windowId) {
  delete windowScrollLock[windowId];
 }
 function isLocked(windowId) {
  return !!windowScrollLock[windowId];
 }
 function isAnyWindowScrollLocked() {
  for(var key in windowScrollLock) 
   if (windowScrollLock.hasOwnProperty(key) && windowScrollLock[key] === true)
    return true;
  return false;
 }
 function replaceVerticalScrollByPadding() {
  var currentBodyStyle = ASPx.GetCurrentStyle(document.body),
   paddingWidth = ASPx.GetVerticalScrollBarWidth() + ASPx.PxToInt(currentBodyStyle.paddingRight);
  ASPx.Attr.ChangeStyleAttribute(document.body, "padding-right", paddingWidth + "px");
 }
 function needToChangeOverflowUsingStyle() {
  return ASPx.Browser.IE && ASPx.Browser.Version >= 11;
 }
 function changeOverflow() {
  if(needToChangeOverflowUsingStyle()) { 
   savedHtmlOverflow = document.documentElement.style.overflow;
   document.documentElement.style.overflow = "hidden";
  }
  else
   ASPx.Attr.ChangeStyleAttribute(document.documentElement, "overflow", "hidden");
  if(ASPx.GetCurrentStyle(document.body).overflowY === "scroll")
   ASPx.Attr.ChangeStyleAttribute(document.body, "overflow", "hidden");
  resetOverflowCache();
 }
 function restoreOverflow() {
  if(needToChangeOverflowUsingStyle()) { 
   document.documentElement.style.overflow = savedHtmlOverflow;
   savedHtmlOverflow = "";
  }
  else
   ASPx.Attr.RestoreStyleAttribute(document.documentElement, "overflow");
  ASPx.Attr.RestoreStyleAttribute(document.body, "overflow");
  resetOverflowCache();
 }
 function resetOverflowCache() {
  ASPx.verticalScrollIsNotHidden = null;
  ASPx.horizontalScrollIsNotHidden = null;
 }
 function saveScrollPosition(windowId) {
  windowScroll[windowId] = {
   x: window.pageXOffset,
   y: window.pageYOffset
  };
 }
 function restoreScrollPosition(windowId) {
  var currentWindowScroll = windowScroll[windowId];
  if(!!currentWindowScroll)
   window.scrollTo(currentWindowScroll.x, currentWindowScroll.y);
 }
 function restoreBodyScroll(windowId) {
  unlockWindowScroll(windowId);
  if(isAnyWindowScrollLocked())
   return;
  if(ASPx.Browser.IE) {
   ASPx.Attr.RestoreAttribute(document.body, "scroll");
   restoreOverflow();
   restoreScrollPosition(windowId);
  } else if(ASPx.Browser.WebKitTouchUI) {
   ASPx.Attr.RestoreStyleAttribute(document.body, "position");
   ASPx.Attr.RestoreStyleAttribute(document.body, "height");
   ASPx.Attr.RestoreStyleAttribute(document.body, "margin");
   ASPx.RemoveClassNameFromElement(document.documentElement, hideScrollbarsClassName);
   ASPx.Attr.RestoreStyleAttribute(document.body, "overflow");
   restoreScrollPosition(windowId);
  } else {
   restoreOverflow();
   restoreScrollPosition(windowId);
  }
  if(ASPx.Browser.Chrome)
   var dummy = document.documentElement.scrollTop; 
  ASPx.Attr.RestoreStyleAttribute(document.body, "padding-right");
  ASPx.Attr.RestoreStyleAttribute(document.body, "height");
  ASPx.Attr.RestoreStyleAttribute(document.body, "width");
 }
 return {
  RestoreIfLocked: function(windowId) {
   if(isLocked(windowId))
    restoreBodyScroll(windowId);
  },
  HideBodyScroll: function(windowId) {
   if(isAnyWindowScrollLocked()) { 
    lockWindowScroll(windowId);
    return;
   }
   lockWindowScroll(windowId);
   if(PopupUtils.IsVerticalScrollExists())
    replaceVerticalScrollByPadding();
   if(ASPx.Browser.IE) {
    saveScrollPosition(windowId);
    ASPx.Attr.ChangeAttribute(document.body, "scroll", "no");
    changeOverflow();
   } else if(ASPx.Browser.WebKitTouchUI) {
    saveScrollPosition(windowId);
    ASPx.Attr.ChangeStyleAttribute(document.body, "overflow", "hidden");
    ASPx.Attr.ChangeStyleAttribute(document.body, "position", "relative");
    ASPx.Attr.ChangeStyleAttribute(document.body, "height", "100%");
    ASPx.Attr.ChangeStyleAttribute(document.body, "margin", "0");
    ASPx.AddClassNameToElement(document.documentElement, hideScrollbarsClassName);
   } else {
    saveScrollPosition(windowId);
    changeOverflow();
    var documentHeight = ASPx.GetDocumentHeight();
    var documentWidth = ASPx.GetDocumentWidth();
    if(window.pageYOffset > 0 && ASPx.PxToInt(window.getComputedStyle(document.body, null)) != documentHeight)
     ASPx.Attr.ChangeStyleAttribute(document.body, "height", documentHeight + "px");
    if(window.pageXOffset > 0 && ASPx.PxToInt(window.getComputedStyle(document.body, null)) != documentWidth)
     ASPx.Attr.ChangeStyleAttribute(document.body, "width", documentWidth + "px");
   }
  },
  RestoreBodyScroll: restoreBodyScroll
 };
})();
var PositionAlignConsts = {
 NOT_SET: 0,
 OUTSIDE_START: 1,
 NEAR_BOUND_START: 2,
 INNER_START: 3,
 CENTER: 4,
 INNER_END: 5,
 NEAR_BOUND_END: 6,
 OUTSIDE_END: 7,
 WINDOW_CENTER: 8,
 WINDOW_START: 9,
 WINDOW_END: 10
};
var AlignIndicatorTable = {};
var PositionCalculator = ASPx.CreateClass(null, {
 constructor: function() {
  this.element = null;
  this.popupElement = null;
  this.align = 0;
  this.offset = 0;
  this.startPos = 0;
  this.startPosInit = 0;
  this.rtl = false;
  this.isPopupFullCorrectionOn = false;
  this.isHorizontal = true;
  this.size = 0;
  this.bodySize = 0;
  this.actualBodySize = 0;
  this.elementStartPos = 0;
  this.scrollStartPos = 0;
  this.isInverted = false;
  this.popupElementSize = 0;
  this.boundStartPos = 0;
  this.boundEndPos = 0;
  this.innerBoundStartPos = 0;
  this.innerBoundEndPos = 0;
  this.isMoreFreeSpaceLeft = false;
  this.nearBoundOverlapRate = 0.25;
  this.functionsTable = {};
  this.initializeFunctionsTable();
 },
 applyParams: function(element, popupElement, align, offset, startPos, startPosInit, rtl, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, isHorizontal, showPopupInsideScreenBounds) {
  this.isHorizontal = isHorizontal;
  this.element = element;
  this.popupElement = popupElement;
  this.align = this.getAlignValueFromIndicator(align);
  this.offset = offset;
  this.startPos = startPos;
  this.startPosInit = startPosInit;
  this.rtl = rtl;
  this.isPopupFullCorrectionOn = isPopupFullCorrectionOn;
  this.ignoreAlignWithoutScrollReserve = ignoreAlignWithoutScrollReserve;
  this.ignorePopupElementBorders = ignorePopupElementBorders;
  this.showPopupInsideScreenBounds = showPopupInsideScreenBounds;
  this.calculateParams();
 },
 disposeState: function() {
  this.element = null;
  this.popupElement = null;
 },
 getPopupAbsolutePos: function() {
  if(this.isWindowAlign()) {
   var showAtPos = this.startPos != ASPx.InvalidPosition && !this.popupElement;
   if(showAtPos)
    this.align = PositionAlignConsts.NOT_SET;
   else
    return this.getWindowAlignPos();
  }
  if(this.popupElement)
   this.calculatePopupElement();
  else
   this.align = PositionAlignConsts.NOT_SET;
  return this.getPopupAbsolutePosCore();
 },
 initializeFunctionsTable: function() {
  var table = this.functionsTable;
  table[PositionAlignConsts.NOT_SET] = this.calculateNotSet;
  table[PositionAlignConsts.OUTSIDE_START] = this.calculateOutsideStart;
  table[PositionAlignConsts.INNER_START] = this.calculateInnerStart;
  table[PositionAlignConsts.CENTER] = this.calculateCenter;
  table[PositionAlignConsts.INNER_END] = this.calculateInnerEnd;
  table[PositionAlignConsts.OUTSIDE_END] = this.calculateOutsideEnd;
  table[PositionAlignConsts.NEAR_BOUND_START] = this.calculateNearBoundStart;
  table[PositionAlignConsts.NEAR_BOUND_END] = this.calculateNearBoundEnd;
  table[PositionAlignConsts.WINDOW_CENTER] = this.calculateWindowCenter;
  table[PositionAlignConsts.WINDOW_START] = this.calculateWindowStart;
  table[PositionAlignConsts.WINDOW_END] = this.calculateWindowEnd;
 },
 calculateParams: function() {
  this.size = this.getElementSize();
  if(this.isHorizontal) {
   this.bodySize = ASPx.GetDocumentClientWidth();
   this.elementStartPos = ASPx.GetAbsoluteX(this.popupElement) + this.getBorderCorrection();
   this.scrollStartPos = ASPx.GetDocumentScrollLeft();
  }
  else {
   this.bodySize = ASPx.GetDocumentClientHeight();
   this.elementStartPos = ASPx.GetAbsoluteY(this.popupElement) + this.getBorderCorrection();
   this.scrollStartPos = ASPx.GetDocumentScrollTop();
  }
 },
 getBorderCorrection: function() {
  if(!this.ignorePopupElementBorders)
   return 0;
  var style = getComputedStyle(this.popupElement);
  return ASPx.PxToInt(this.isHorizontal ? style.borderLeftWidth : style.borderTopWidth);
 },
 isWindowAlign: function() {
  return this.align == PositionAlignConsts.WINDOW_CENTER || this.align == PositionAlignConsts.WINDOW_START ||
   this.align == PositionAlignConsts.WINDOW_END;
 },
 getWindowAlignPos: function() {
  this.actualBodySize = ASPx.Browser.WebKitTouchUI ? this.getWindowInnerSize() : this.bodySize;
  return this.getPopupAbsolutePosCore();
 },
 getPopupAbsolutePosCore: function() {
  var calculationFunc = this.functionsTable[this.align];
  calculationFunc.call(this);
  return new ASPx.PopupPosition(this.startPos, this.isInverted);
 },
 calculateWindowCenter: function() {
  this.startPos = Math.max(Math.ceil(this.actualBodySize / 2 - this.size / 2), 0) + this.scrollStartPos + this.offset;
 },
 calculateWindowStart: function() {
  this.startPos = this.scrollStartPos + this.offset;
 },
 calculateWindowEnd: function() {
  this.startPos = this.scrollStartPos + this.actualBodySize - this.size + this.offset;
 },
 calculatePopupElement: function() {
  this.popupElementSize = this.getPopupElementSize();
  this.boundStartPos = this.elementStartPos - this.size;
  this.boundEndPos = this.elementStartPos + this.popupElementSize;
  this.innerBoundStartPos = this.elementStartPos;
  this.innerBoundEndPos = this.elementStartPos + this.popupElementSize - this.size;
  var hasLeftScrollReserve = this.boundStartPos >= 0;
  this.isMoreFreeSpaceLeft = (this.bodySize - (this.boundEndPos + this.size) < this.boundStartPos - 2 * this.scrollStartPos) && (!this.ignoreAlignWithoutScrollReserve || hasLeftScrollReserve);
 },
 calculateOutsideStart: function() {
  this.isInverted = this.isPopupFullCorrectionOn && (!(this.boundStartPos - this.scrollStartPos > 0 || this.isMoreFreeSpaceLeft));
  if(this.isInverted)
   this.startPos = this.boundEndPos - this.offset;
  else
   this.startPos = this.boundStartPos + this.offset;
 },
 calculateInnerStart: function() {
  this.startPos = this.innerBoundStartPos + this.offset;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 calculateCenter: function() {
  this.startPos = this.elementStartPos + Math.round((this.popupElementSize - this.size) / 2) + this.offset;
  if(this.showPopupInsideScreenBounds) {
   if(this.startPos < 0)
    this.startPos = 0;
   if(this.startPos + this.size > this.bodySize)
    this.startPos = this.bodySize - this.size;
  }
 },
 calculateInnerEnd: function() {
  this.startPos = this.innerBoundEndPos + this.offset;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 calculateOutsideEnd: function() {
  this.isInverted = this.isPopupFullCorrectionOn && (!(this.boundEndPos + this.size < this.bodySize + this.scrollStartPos || !this.isMoreFreeSpaceLeft));
  if(this.isInverted)
   this.startPos = this.boundStartPos - this.offset;
  else
   this.startPos = this.boundEndPos + this.offset;
 },
 calculateNotSet: function() {
  if(this.rtl)
   this.calculateNotSetRightToLeft();
  else
   this.calculateNotSetLeftToRight();
 },
 calculateNotSetLeftToRight: function() {
  if(!ASPx.IsValidPosition(this.startPos)) {
   if(this.popupElement)
    this.startPos = this.elementStartPos;
   else if(this.offset)
    this.startPos = 0;
   else
    this.startPos = this.startPosInit;
  }
  this.isInverted = this.isPopupFullCorrectionOn && (this.startPos - this.scrollStartPos + this.size > this.bodySize && this.startPos - this.scrollStartPos > this.bodySize / 2);
  if(this.isInverted)
   this.startPos = this.startPos - this.size - this.offset;
  else
   this.startPos = this.startPos + this.offset;
 },
 calculateNotSetRightToLeft: function() {
  if(!ASPx.IsValidPosition(this.startPos)) {
   if(this.popupElement)
    this.startPos = this.innerBoundEndPos;
   else if(this.offset)
    this.startPos = 0;
   else
    this.startPos = this.startPosInit;
  }
  else
   this.startPos -= this.size;
  this.isInverted = this.isPopupFullCorrectionOn && (this.startPos < this.scrollStartPos && this.startPos - this.scrollStartPos < this.bodySize / 2);
  if(this.isInverted)
   this.startPos = this.startPos + this.size + this.offset;
  else
   this.startPos = this.startPos - this.offset;
 },
 calculateNearBoundStart: function() {
  this.startPos = this.boundStartPos + this.offset + this.size * this.nearBoundOverlapRate;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 calculateNearBoundEnd: function() {
  this.startPos = this.boundEndPos + this.offset - this.size * this.nearBoundOverlapRate;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 getAlignValueFromIndicator: function(alignIndicator) {
  var alignValue = AlignIndicatorTable[alignIndicator];
  if(alignValue === undefined)
   throw "Incorrect align indicator.";
  return alignValue;
 },
 getElementSize: function() {
  return this.getCustomElementSize(this.element, false);
 },
 getPopupElementSize: function() {
  return this.getCustomElementSize(this.popupElement, this.ignorePopupElementBorders);
 },
 getCustomElementSize: function(customElement, ignoreBorders) {
  if(ignoreBorders) {
   return this.isHorizontal ? ASPx.GetClearClientWidth(customElement) : ASPx.GetClearClientHeight(customElement);
  }
  return this.isHorizontal ? ASPx.GetElementOffsetWidth(customElement) : ASPx.GetElementOffsetHeight(customElement);
 },
 getWindowInnerSize: function() {
  return this.isHorizontal ? window.innerWidth : window.innerHeight;
 }
});
var positionCalculator = null;
function getPositionCalculator() {
 if(positionCalculator == null)
  positionCalculator = new PositionCalculator();
 return positionCalculator;
}
function initializeAlignIndicatorTable() {
 AlignIndicatorTable[PopupUtils.NotSetAlignIndicator] = PositionAlignConsts.NOT_SET;
 AlignIndicatorTable[PopupUtils.OutsideLeftAlignIndicator] = PositionAlignConsts.OUTSIDE_START;
 AlignIndicatorTable[PopupUtils.AboveAlignIndicator] = PositionAlignConsts.OUTSIDE_START;
 AlignIndicatorTable[PopupUtils.LeftAlignIndicator] = PositionAlignConsts.NEAR_BOUND_START;
 AlignIndicatorTable[PopupUtils.TopAlignIndicator] = PositionAlignConsts.NEAR_BOUND_START;
 AlignIndicatorTable[PopupUtils.LeftSidesAlignIndicator] = PositionAlignConsts.INNER_START;
 AlignIndicatorTable[PopupUtils.TopSidesAlignIndicator] = PositionAlignConsts.INNER_START;
 AlignIndicatorTable[PopupUtils.CenterAlignIndicator] = PositionAlignConsts.CENTER;
 AlignIndicatorTable[PopupUtils.MiddleAlignIndicator] = PositionAlignConsts.CENTER;
 AlignIndicatorTable[PopupUtils.RightSidesAlignIndicator] = PositionAlignConsts.INNER_END;
 AlignIndicatorTable[PopupUtils.BottomSidesAlignIndicator] = PositionAlignConsts.INNER_END;
 AlignIndicatorTable[PopupUtils.RightAlignIndicator] = PositionAlignConsts.NEAR_BOUND_END;
 AlignIndicatorTable[PopupUtils.BottomAlignIndicator] = PositionAlignConsts.NEAR_BOUND_END;
 AlignIndicatorTable[PopupUtils.OutsideRightAlignIndicator] = PositionAlignConsts.OUTSIDE_END;
 AlignIndicatorTable[PopupUtils.BelowAlignIndicator] = PositionAlignConsts.OUTSIDE_END;
 AlignIndicatorTable[PopupUtils.WindowCenterAlignIndicator] = PositionAlignConsts.WINDOW_CENTER;
 AlignIndicatorTable[PopupUtils.WindowLeftAlignIndicator] = PositionAlignConsts.WINDOW_START;
 AlignIndicatorTable[PopupUtils.WindowTopAlignIndicator] = PositionAlignConsts.WINDOW_START;
 AlignIndicatorTable[PopupUtils.WindowRightAlignIndicator] = PositionAlignConsts.WINDOW_END;
 AlignIndicatorTable[PopupUtils.WindowBottomAlignIndicator] = PositionAlignConsts.WINDOW_END;
}
initializeAlignIndicatorTable();
ASPx.PopupPosition = function(position, isInverted) {
 this.position = position;
 this.isInverted = isInverted;
};
ASPx.PopupSize = function(width, height) {
 this.width = width;
 this.height = height;
};
ASPx.PopupUtils = PopupUtils;
ASPx.PositionCalculator = PositionCalculator;
})();
(function() {
ASPx.PCWIdSuffix = "_PW";
var popupControlZIndex = 11998;
var defaultZIndexFromServer = "10000";
var ModalAlign = {
 WindowLeft: "WindowLeft",
 WindowCenter: "WindowCenter",
 WindowRight: "WindowRight",
 WindowTop: "WindowTop",
 WindowBottom: "WindowBottom"
};
function PCResizeCursorInfo(horizontalDirection, verticalDirection, horizontalOffset, verticalOffset) {
 this.horizontalDirection = horizontalDirection;
 this.verticalDirection = verticalDirection;
 this.horizontalOffset = horizontalOffset;
 this.verticalOffset = verticalOffset;
 this.course = verticalDirection + horizontalDirection;
}
var PopupControlCssClasses = {};
PopupControlCssClasses.Prefix = "dxpc-";
PopupControlCssClasses.SizeGripLiteCssClassName = PopupControlCssClasses.Prefix + "sizeGrip";
PopupControlCssClasses.LinkCssClassName = PopupControlCssClasses.Prefix + "link";
PopupControlCssClasses.ShadowLiteCssClassName = PopupControlCssClasses.Prefix + "shadow";
PopupControlCssClasses.MainDivLiteCssClass = PopupControlCssClasses.Prefix + "mainDiv";
PopupControlCssClasses.ContentWrapperCssClassName = PopupControlCssClasses.Prefix + "contentWrapper";
PopupControlCssClasses.ContentCssClassName = PopupControlCssClasses.Prefix + "content";
PopupControlCssClasses.HeaderContentCssClassName = PopupControlCssClasses.Prefix + "headerContent";
PopupControlCssClasses.FooterContentCssClassName = PopupControlCssClasses.Prefix + "footerContent";
PopupControlCssClasses.WindowWrapperCssClassName = PopupControlCssClasses.Prefix + "win-wrapper";
PopupControlCssClasses.WindowWrapperScrollCssClassName = PopupControlCssClasses.WindowWrapperCssClassName + "-scroll";
PopupControlCssClasses.HeaderCssClassName = "dxpc-header";
var LoadContentViaCallback = {
 Default: "Default",
 OnFirstShow: "OnFirstShow",
 OnPageLoad: "OnPageLoad"
};
var constants = {
 DEFAULT_WINDOW_WIDTH: 200,
 DEFAULT_WINDOW_HEIGHT: 0
};
var ASPxClientPopupControlBase = ASPx.CreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.leadingAfterInitCall = ASPxClientControl.LeadingAfterInitCallConsts.Direct; 
  this.adjustInnerControlsSizeOnShow = true;
  this.shadowVisible = true;
  this.cookieName = "";
  this.popupAnimationType = "none";
  this.closeAnimationType = "none";
  this.closeAction = "OuterMouseClick";
  this.isPopupFullCorrectionOn = true;
  this.forceAdjustPositionToClientScreen = false;
  this.usedInDropDown = false; 
  this.popupHorizontalOffset = 0;
  this.popupVerticalOffset = 0;
  this.popupHorizontalAlign = ASPx.PopupUtils.NotSetAlignIndicator;
  this.popupVerticalAlign = ASPx.PopupUtils.NotSetAlignIndicator;
  this.contentLoadingMode = LoadContentViaCallback.Default;
  this.slideAnimationDuration = 80;
  this.fadeAnimationDuration = 400;
  this.enableAnimation = true;
  this.showOnPageLoad = false;
  this.isDragged = false;
  this.closeOnEscape = false;
  this.savedCallbackWindowIndex = null;
  this.animationLockCount = 0;
  this.windowRequestCount = [];
  this.lpTimers = [];
  this.callbackAnimationProcessings = [];
  this.isCallbackFinishedStates = [];
  this.savedCallbackResults = [];
  this.loadingPanels = [];
  this.loadingDivs = [];
  this.left = 0;
  this.top = 0;
  this.height = constants.DEFAULT_WINDOW_HEIGHT;
  this.width = constants.DEFAULT_WINDOW_WIDTH;
  this.minHeight = null;
  this.minWidth = null;
  this.maxHeight = null;
  this.maxWidth = null;
  this.isResized = false;
  this.cachedSize = null;
  this.enableContentScrolling = false;
  this.contentOverflowX = "None";
  this.contentOverflowY = "None";
  this.contentUrl = "";
  this.contentUrlIFrameTitle = "";
  this.iframeLoading = false;
  this.iframeAdjustingPostponed = false;
  this.isPopupPositionCorrectionOn = true;
  this.resizeSessionCache = {};
  this.ResizeBorderSize = ASPx.Browser.TouchUI ? 10 : 6;
  this.ResizeCornerBorderSize = 20;
  this.isLiveResizingMode = true;
  this.allowResize = false;
  this.allowDragging = false;
  this.allowDraggingInAdaptiveMode = false;
  this.isWindowDragging = false;
  this.prohibitClearSelectionOnMouseDown = false;
  this.windowElements = {};
  this.windowContentElements = {};
  this.zIndex = -1;
  this.appearAfter = 300;
  this.disappearAfter = 500;
  this.popupAction = "LeftMouseClick";
  this.autoUpdatePosition = false;
  this.defaultIsPopuped = false;
  this.defaultLastUsedPopupElementInfo = {};
  this.defaultWindowPopupElementList = [];
  this.defaultWindowPopupElementIDList = [];
  this.firstFocusableElement = null;
  this.lastFocusableElement = null;
  this.focusLastElementHandler = function(e) { this.loopFocusHandler(e, false); }.aspxBind(this);
  this.focusFirstElementHandler = function(e) { this.loopFocusHandler(e, true); }.aspxBind(this);
  this.setFocusOnCallback = true;
  this.accessibleFocusElement = null;
  this.preventAccessibilityFocus = false;
  this.CloseButtonClick = new ASPxClientEvent();
  this.CloseUp = new ASPxClientEvent();
  this.Closing = new ASPxClientEvent();
  this.PopUp = new ASPxClientEvent();
  this.Shown = new ASPxClientEvent();
  this.Resize = new ASPxClientEvent();
  this.Dragged = new ASPxClientEvent(); 
  this.BeforeDrag = new ASPxClientEvent(); 
  this.BeforeResizing = new ASPxClientEvent();
  this.AfterResizing = new ASPxClientEvent();
  aspxGetPopupControlCollection().Add(this);
 },
 WindowElementIDAssignmentMap: [
  { cssClass: PopupControlCssClasses.HeaderCssClassName, prefix: "_PWH" },
  { cssClass: "dxpc-headerText", prefix: "_PWH", postfix: "T" },
  { cssClass: "dxpc-headerImg", prefix: "_PWH", postfix: "I" },
  { cssClass: "dxpc-closeBtn", prefix: "_HCB" },
  { cssClass: "dxpc-pinBtn", prefix: "_HPB" },
  { cssClass: "dxpc-refreshBtn", prefix: "_HRB" },
  { cssClass: "dxpc-collapseBtn", prefix: "_HMNB" },
  { cssClass: "dxpc-maximizeBtn", prefix: "_HMXB" },
  { cssClass: "dxpc-content", prefix: "_PWC" },
  { cssClass: "dxpc-iFrame", prefix: "_CIF" },
  { cssClass: "dxpc-footer", prefix: "_PWF" },
  { cssClass: "dxpc-footerText", prefix: "_PWF", postfix: "T" },
  { cssClass: "dxpc-footerImg", prefix: "_PWF", postfix: "I" }
 ],
 Initialize: function() {
  this.InitializeBeforeAnyShow();
  ASPxClientControl.prototype.Initialize.call(this);
  if(this.accessibilityCompliant)
   this.InitializeAccessibleNavigation();
 },
 InitializeWindow: function(index) {
  ASPx.PopupUtils.BodyScrollHelper.RestoreIfLocked(this.GetWindowElementId(index));
  this.RemoveWindowAllPopupElements(index);
  this.PopulatePopupElements(index);
  var element = this.GetWindowElement(index);
  if(element != null) {
   this.AssignWindowElementsID(index, element);
   this.AssignWindowElementsEvents(index, element);
   element.DXPopupWindowElement = true;
   this.AttachOnDragStartEventToWindowImages(index);
   this.EnsureWindowContentUrl(index);
   element.isHiding = false;
   element.isPopupPositionCorrectionOn = this.isPopupPositionCorrectionOn || !this.GetShowOnPageLoad(index);
   if(this.GetShowOnPageLoad(index) && this.GetZIndex(index) > 0) {
    this.FirstShowWindow(index, false);
    this.SetWindowElementZIndex(element, this.GetZIndex(index));
    element.isPopupPositionCorrectionOn = true;
   }
   this.InitializeWindowEscKeyHandler(element, index);
   if(this.GetCanScrollViewPort(index))
    ensureViewPortSizeInterval();
   var headerImageElement = this.GetWindowHeaderImageCell(index);
   if(headerImageElement != null) {
    var headerImageHandler = function() {
     this.CorrectHeaderContentElementHeight(index);
    }.aspxBind(this);
    headerImageElement.addEventListener("load", headerImageHandler);
    headerImageElement.addEventListener("error", headerImageHandler);
   }
   var footerImageElement = this.GetWindowFooterImageCell(index);
   if(footerImageElement != null) {
    var footerImageHandler = function() {
     this.CorrectWindowSizeGripPositionLite(index);
     this.CorrectFooterTextElementWidth(index);
    }.aspxBind(this);
    footerImageElement.addEventListener("load", footerImageHandler);
    footerImageElement.addEventListener("error", footerImageHandler);
   }
  }
 },
 InitializeBeforeAnyShow: function() {
  this.InitializeEnableContentScrolling();
 },
 InitializeEnableContentScrolling: function() {
  this.enableContentScrolling = this.contentOverflowX != "None" || this.contentOverflowY != "None";
 },
 InitializeWindowEscKeyHandler: function(element, index) {
  if(!this.GetEnableCloseByEsc(index)) return;
  this.AddKeyDownHandler("ESC", this.OnEscKeyDown.aspxBind(this));
 },
 AfterInitialize: function() {
  if(this.HasDefaultWindow())
   this.AfterInitializeWindow(-1);
  for(var i = 0; i < this.GetWindowCount(); i++)
   this.AfterInitializeWindow(i);
  ASPxClientControl.prototype.AfterInitialize.call(this);
 },
 AfterInitializeWindow: function(index) {
  if(this.GetShowOnPageLoad(index) && this.GetZIndex(index) < 0) {
   this.FirstShowWindow(index, true);
   var element = this.GetWindowElement(index);
   if(element != null)
    element.isPopupPositionCorrectionOn = true;
  }
  this.EnsureContent(index, true);
 },
 AssignWindowElementsID: function(index, windowElement) {
  for(var i = 0; i < this.WindowElementIDAssignmentMap.length; i++) {
   var elementClass = this.WindowElementIDAssignmentMap[i].cssClass;
   var elements = ASPx.GetNodesByClassName(windowElement, elementClass);
   for(var j = 0; j < elements.length; j++) {
    var element = elements[j];
    if(this.GetFirstParentWindow(element) === windowElement)
     this.AssignElementID(element, index, this.WindowElementIDAssignmentMap[i].prefix, this.WindowElementIDAssignmentMap[i].postfix);
   }
  }
 },
 AssignElementID: function(element, index, prefix, postfix) {
  element.id = this.name + prefix + index + (postfix ? postfix : "");
 },
 AssignWindowElementsEvents: function(index, element) {
  var header = this.GetWindowHeaderElement(index);
  if(header && this.allowDragging && !this.isWindowDragging)
   ASPx.Evt.AttachEventToElement(header, ASPx.TouchUIHelper.touchMouseDownEventName, this.GetWindowHeaderElementMouseDownEventHandler(index), true);
  this.AssignHeaderButtonsEvents(index);
  var mdEventName = ASPx.TouchUIHelper.touchMouseDownEventName;
  ASPx.Evt.AttachEventToElement(element, mdEventName, this.GetWindowElementMouseDownEventHandler(index));
  if(this.IsResizeAllowed(index)) {
   var mmEventName = ASPx.TouchUIHelper.touchMouseMoveEventName;
   ASPx.Evt.AttachEventToElement(element, mmEventName, this.GetWindowElementMouseMoveEventHandler(index));
  }
  var sizeGrip = this.GetWindowSizeGripElement(index);
  if(sizeGrip) {
   var instance = this;
   ASPx.Evt.AttachEventToElement(sizeGrip, mdEventName, function(evt) {
    ASPx.PWGripMDown(evt, instance.name, index);
    ASPx.Evt.PreventEvent(evt);
   });
  }
 },
 AssignHeaderButtonsEvents: function(index) {
  this.AttachClickToHeaderButton(index, this.GetWindowCloseButton(index), "ASPx.PWCBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowRefreshButton(index), "ASPx.PWRBClick");
 },
 AttachClickToHeaderButton: function(index, headerButton, eventFuncName) {
  var instance = this;
  if(headerButton) {
   ASPx.Evt.AttachEventToElement(headerButton, "click", function(evt) {
    eval(eventFuncName)(evt, instance.name, index);
   });
  }
 },
 AttachOnDragStartEventToWindowImages: function(index) {
  this.AttachChildImagesPreventDragStartEvent(this.GetWindowHeaderElement(index));
  this.AttachChildImagesPreventDragStartEvent(this.GetWindowFooterElement(index));
 },
 AttachChildImagesPreventDragStartEvent: function(parentElem) {
  var images = parentElem == null ? null : ASPx.GetNodesByTagName(parentElem, "img");
  if(images != null) {
   for(var i = 0; i < images.length; i++)
    ASPx.Evt.AttachEventToElement(images[i], "dragstart", ASPx.Evt.PreventEventAndBubble);
  }
 },
 GetPropertyValue: function(index, propName) {
  return this[propName];
 },
 SetPropertyValue: function(index, propName, value) {
  this[propName] = value;
 },
 GetStretchVerticallyByIndex: function(index) {
  return this.GetPropertyValue(index, "stretchVertically");
 },
 GetModalMaxWidth: function(index) {
  return this.GetPropertyValue(index, "modalMaxWidth");
 },
 SetAdaptiveMaxWidthByIndex: function(index, value) {
  value = this.ConvertDimensionValueToString(value);
  this.SetPropertyValue(index, "modalMaxWidth", value);
  this.GetWindowElement(index).style["maxWidth"] = value;
  if(value.indexOf("px") > 0)
   this.EnsureMaxWidthClassName(index, ASPx.PxToInt(value));
 },
 EnsureMaxWidthClassName: function(index, maxWidth) {
  var defaultPaddingsWidth = 20;
  ASPx.ToggleClassNameToElement(this.GetModalWrapperElement(index), "dxmodalMaxWidth", maxWidth < ASPx.MaxMobileWindowWidth - defaultPaddingsWidth);
 },
 GetModalMinWidth: function(index) {
  return this.GetPropertyValue(index, "modalMinWidth");
 },
 SetAdaptiveMinWidthByIndex: function(index, value) {
  value = this.ConvertDimensionValueToString(value);
  this.SetPropertyValue(index, "modalMinWidth", value);
  this.GetWindowElement(index).style["minWidth"] = value;
 },
 GetModalMinHeight: function(index) {
  return this.GetPropertyValue(index, "modalMinHeight");
 },
 SetContentElementsAdaptiveDisplayStyle: function(index) {
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  ASPx.ToggleClassNameToElement(contentWrapper, "dxmodalTableSys", !this.GetWindowContentIFrameElement(index) && !this.HasAnyScrollBars(index));
 },
 SetContentWrapperAdaptiveHeight: function(index, adaptiveHeight) {  
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  contentWrapper.style.height = adaptiveHeight;  
 },
 SetAdaptiveMinHeightByIndex: function(index, value) {  
  this.StretchVerticallyByIndex(index, false);
  this.SetPropertyValue(index, "modalMinHeight", value);
  this.SetAdaptiveHeightDimension(index, "minHeight", value);
 },
 GetModalMaxHeight: function(index) {
  return this.GetPropertyValue(index, "modalMaxHeight");
 },
 SetAdaptiveMaxHeightByIndex: function(index, value) {
  this.SetPropertyValue(index, "modalMaxHeight", value);
  this.SetAdaptiveHeightDimension(index, "maxHeight", value);
 },
 GetFixedHeader: function(index) {
  return this.GetPropertyValue(index, "fixedHeader");
 },
 GetFixedFooter: function(index) {
  return this.GetPropertyValue(index, "fixedFooter");
 },
 GetWindowWidthInternal: function(index) {
  return this.GetPropertyValue(index, "width");
 },
 GetWindowHeightInternal: function(index) {
  return this.GetPropertyValue(index, "height");
 },
 SetWindowHeight: function(index, height) {
  this.SetPropertyValue(index, "height", height);
 },
 SetWindowWidth: function(index, width) {
  this.SetPropertyValue(index, "width", width);
 },
 GetWindowMinWidth: function(index) {
  return this.GetPropertyValue(index, "minWidth");
 },
 GetWindowMaxWidth: function(index) {
  return this.GetPropertyValue(index, "maxWidth");
 },
 GetWindowMinHeight: function(index) {
  return this.GetPropertyValue(index, "minHeight");
 },
 GetWindowMaxHeight: function(index) {
  return this.GetPropertyValue(index, "maxHeight");
 },
 SetWindowMaxHeight: function(index, maxHeight) {
  this.SetPropertyValue(index, "maxHeight", maxHeight);
 },
 SetWindowCachedSize: function(index, width, height) {
  this.SetPropertyValue(index, "cachedSize", new ASPx.PopupSize(width, height));
 },
 GetWindowCachedSize: function(index) {
  return this.GetPropertyValue(index, "cachedSize");
 },
 ResetWindowCachedSize: function(index) {
  this.SetPropertyValue(index, "cachedSize", null);
 },
 GetPosition: function(index, isLeft) {
  return this.GetPropertyValue(index, isLeft ? "left" : "top");
 },
 GetWindowTop: function(index) {
  return this.GetPropertyValue(index, "top");
 },
 SetWindowTop: function(index, top) {
  this.SetPropertyValue(index, "top", top);
 },
 GetWindowLeft: function(index) {
  return this.GetPropertyValue(index, "left");
 },
 SetWindowLeft: function(index, left) {
  this.SetPropertyValue(index, "left", left);
 },
 GetEnableCloseByEsc: function(index) {
  return this.GetPropertyValue(index, "closeOnEscape");
 },
 GetIsDragged: function(index) {
  return this.GetPropertyValue(index, "isDragged");
 },
 GetWindowContentIFrameUrl: function(index) {
  return this.GetPropertyValue(index, "contentUrl");
 },
 GetWindowContentIFrameTitle: function(index) {
  return this.GetPropertyValue(index, "contentUrlIFrameTitle");
 },
 GetWindowCloseAction: function(index) {
  return this.GetPropertyValue(index, "closeAction");
 },
 GetShowOnPageLoad: function(index) {
  return this.GetPropertyValue(index, "showOnPageLoad");
 },
 GetZIndex: function(index) {
  return this.GetPropertyValue(index, "zIndex");
 },
 GetIframeLoading: function(index) {
  return this.GetPropertyValue(index, "iframeLoading");
 },
 SetIframeLoading: function(index, value) {
  this.SetPropertyValue(index, "iframeLoading", value);
 },
 SetIsDragged: function(index, value) {
  this.SetPropertyValue(index, "isDragged", value);
 },
 GetIsResized: function(index) {
  return this.GetPropertyValue(index, "isResized");
 },
 SetIsResized: function(index, value) {
  this.SetPropertyValue(index, "isResized", value);
 },
 SetIframeAdjustingPostponed: function(index, value) {
  this.SetPropertyValue(index, "iframeAdjustingPostponed", value);
 },
 GetIframeAdjustingPostponed: function(index) {
  return this.GetPropertyValue(index, "iframeAdjustingPostponed");
 },
 GetWindowPopupAction: function(index) {
  return this.GetPropertyValue(index, "popupAction");
 },
 GetWindowElementMouseMoveEventHandler: function(index) {
  var instance = this;
  return function(evt) { ASPx.PWMMove(evt, instance.name, index); };
 },
 GetWindowElementMouseDownEventHandler: function(index) {
  var instance = this;
  return function(evt) {
   if(instance.AllowMouseDown(evt, index))
    ASPx.PWMDown(evt, instance.name, index, instance.isWindowDragging);
  };
 },
 GetWindowHeaderElementMouseDownEventHandler: function(index) {
  var instance = this;
  return function(evt) {
   if(instance.AllowMouseDown(evt, index))
    ASPx.PWDGMDown(evt, instance.name, index);
  };
 },
 AllowMouseDown: function(evt, index) {
  return !this.PreventHeaderButtonMouseDownBubbling(evt, this.GetWindowCloseButton(index)) &&
   !this.PreventHeaderButtonMouseDownBubbling(evt, this.GetWindowRefreshButton(index));
 },
 PreventHeaderButtonMouseDownBubbling: function(evt, hdrButton) {
  if(hdrButton) {
   var source = ASPx.Evt.GetEventSource(evt);
   if(ASPx.GetIsParent(hdrButton, source)) {
    ASPx.PWHMDown(evt);
    return true;
   }
  }
  return false;
 },
 PrepareToAdjustContentOnShow: function(index) {
  if(this.adjustInnerControlsSizeOnShow) {
   var windowContent = this.GetContentContainer(index),
    collection = ASPx.GetControlCollection();
   collection.CollapseControls(windowContent);
  }
 },
 AdjustContentOnShow: function(index) {
  if(this.adjustInnerControlsSizeOnShow) {
   var windowElement = this.GetWindowElement(index);
   ASPx.GetControlCollection().AdjustControls(windowElement, false);
  }
 },
 AdjustSize: function() {
  if(this.enableContentScrolling)
   return;
  this.SetSize(0, 0);
 },
 GetFirstParentWindow: function(el) {
  while(el && el.tagName != "BODY") {
   if(el.nodeType == 1 && el.className.indexOf("dxpclW") > -1 && !isNaN(this.GetWindowIndex(el)))
    return el;
   el = el.parentNode;
  }
 },
 getParentPopupControl: function(index) {
  var parentPopupWindowElement = this.GetFirstParentWindow(this.GetWindowElement(index).parentNode);
  if(parentPopupWindowElement)
   return aspxGetPopupControlCollection().GetPopupWindowFromID(parentPopupWindowElement.id);
 },
 registerAndActivateWindow: function(windowElement, index, allowChangeZIndex) {
  aspxGetPopupControlCollection().RegisterVisibleWindow(windowElement, this, index);
  if(allowChangeZIndex)
   aspxGetPopupControlCollection().ActivateWindowElement(windowElement, undefined, this.GetPopupType(), this.GetDefaultZIndexFromServer(), this.GetPopupControlZIndex());
 },
 HasCloseAnimation: function() {
  return this.closeAnimationType != ASPxClientPopupControlBase.AnimationType.None;
 },
 AddKeyDownHandler: function(shortcutString, handler) {
  if(typeof(this.keyDownHandlers) === "undefined")
   this.keyDownHandlers = [];
  this.keyDownHandlers[ASPx.ParseShortcutString(shortcutString)] = handler;
 },
 InternalIsWindowDisplayed: function(index) {
  var element = this.GetWindowElement(index);
  return (element != null) ? ASPx.GetElementDisplay(element) : false;
 },
 InternalIsWindowVisible: function(index) {
  var element = this.GetWindowElement(index);
  if(!element)
   return false;
  if(this.HasCloseAnimation() && !element.closeAnimationCompleted)
   return false;
  return ASPx.GetElementVisibility(element) && ASPx.GetElementDisplay(element);
 },
 IsWindowVisible: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.InternalIsWindowVisible(index);
 },
 IsVisible: function() {
  return this.InternalIsWindowVisible(-1);
 },
 UpdateWindowsStateCookie: function() {
  if(this.cookieName == "") return;
  ASPx.Cookie.DelCookie(this.cookieName);
  ASPx.Cookie.SetCookie(this.cookieName, this.GetWindowsState());
 },
 SetWindowElementZIndex: function(element, zIndex) {
  element.style.zIndex = zIndex;
  var iFrame = element.overflowElement;
  if(iFrame)
   iFrame.style.zIndex = zIndex - 1;
  var modalElement = element.modalElement;
  if(modalElement)
   modalElement.style.zIndex = zIndex - 1;
  this.UpdateWindowsStateCookie();
 },
 SetWindowContentHtmlCore: function(index, html, useAnimation) {
  var element = this.GetContentContainer(index);
  if(element != null) {
   ASPx.SetInnerHtml(element, html);
   this.AfterSetWindowContentHtml(index, element, useAnimation);
  }
 },
 SetContentHtml: function(html, useAnimation) {
  this.SetWindowContentHtml(null, html, useAnimation);
  if(html && this.accessibilityCompliant)
   ASPx.GetControlCollection().ControlsInitialized.AddHandler(this.OnControlsInitialized, this);
 },
 SetWindowContentHtml: function(window, html, useAnimation) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowContentHtmlCore(index, html, useAnimation);
 },
 GetContentHtml: function() {
  return this.GetWindowContentHtml(null);
 },
 AfterSetWindowContentHtml: function(index, contentContainer, useAnimation) {
  if(useAnimation && typeof (ASPx.AnimationHelper) != "undefined")
   ASPx.AnimationHelper.fadeIn(contentContainer, function() { this.ResizeWindowIFrame(index); }.aspxBind(this));
  else
   this.ResizeWindowIFrame(index);
 },
 ResizeWindowIFrame: function(index) {
  if(!this.renderIFrameForPopupElements || !this.InternalIsWindowVisible(index)) return;
  var iFrame = this.GetWindowIFrame(index);
  if(iFrame) {
   var cell = this.GetWindowMainCell(this.GetWindowElement(index));
   ASPx.SetStyles(iFrame, { width: cell.offsetWidth, height: cell.offsetHeight });
  }
 },
 DoHideWindow: function(index, dontRaiseClosing, closeReason) {
  if(!this.InternalIsWindowVisible(index)) return;
  var cancel = !dontRaiseClosing && this.RaiseClosing(index, closeReason);
  if(!cancel) {
   if(this.HasCloseAnimation() && this.IsAnimationAllowed())
    this.DoHideWindowCoreWithAnimation(index, closeReason);
   else {
    this.DoHideWindowCore(index, closeReason);
    this.RaiseCloseUp(index, closeReason);
   }
  }
  return cancel;
 },
 HasAnyScrollBars: function(index) {
  var contentElement = this.GetWindowContentElement(index);
  var hasBothScrollBars = contentElement.style.overflow == "scroll" || contentElement.style.overflow == "auto";
  return hasBothScrollBars || contentElement.style.overflowX == "scroll" ||
   contentElement.style.overflowY == "scroll" || contentElement.style.overflowX == "auto" ||
   contentElement.style.overflowY == "auto";
 },
 DoHideWindowModalElement: function(element, closeReason) {
  var modalElement = element.modalElement;
  if(modalElement && ASPx.GetElementVisibility(modalElement, true)) {
   var closeModalElement = function () {
    ASPx.SetStyles(modalElement, { width: 1, height: 1, zIndex: defaultZIndexFromServer - 1 });
    ASPx.SetElementVisibility(modalElement, false);
    ASPx.SetElementDisplay(modalElement, false);
   };
   aspxGetPopupControlCollection().UnregisterVisibleModalElement(modalElement);
   if(this.GetHideBodyScrollWhenModal(this.GetWindowIndex(element))) {
    if(ASPx.Browser.WebKitFamily)
     aspxGetPopupControlCollection().LockScrollEvent();
    if(!ASPx.Browser.WebKitTouchUI)
     ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
    if(ASPx.Browser.WebKitFamily)
     aspxGetPopupControlCollection().UnlockScrollEvent();
   }
   if(closeReason == ASPxClientPopupControlCloseReason.OuterMouseClick) {     
    ASPx.SetStyles(modalElement, { opacity: 0 });
    if(!modalElement.mouseHandler) {
     modalElement.mouseHandler = function() {
      ASPx.SetStyles(modalElement, { opacity: "" });
      closeModalElement();
      ASPx.Evt.DetachEventFromElement(modalElement, "mouseup", modalElement.mouseHandler);
      ASPx.Evt.DetachEventFromElement(modalElement, "mouseout", modalElement.mouseHandler);
     };
    }
    ASPx.Evt.AttachEventToElement(modalElement, "mouseup", modalElement.mouseHandler);
    ASPx.Evt.AttachEventToElement(modalElement, "mouseout", modalElement.mouseHandler);
   } else
    closeModalElement();
  }
 },
 IncreaseWindowRequestCount: function (index) {
  if(!this.windowRequestCount[index])
   this.windowRequestCount[index] = 1;
  else
   this.windowRequestCount[index]++;
 },
 DecreaseWindowRequestCount: function(index) {
  this.windowRequestCount[index]--;
 },
 IsLoadingContainerVisible: function() {
  return true;
 },
 ShouldHideExistingLoadingElements: function() {
  return false;
 },
 GetModalElementEndAnimationOpacity: function(index) {
  if(typeof (this.modalElementOpacity) == "undefined")
   this.modalElementOpacity = [];
  if(typeof (this.modalElementOpacity[index]) == "undefined")
   this.modalElementOpacity[index] = ASPx.GetElementOpacity(this.GetWindowModalElement(index));
  return this.modalElementOpacity[index];
 },
 SetModalElementVisibilityWithAnimation: function(modalElement, index) {
  if(this.AllowModalElementAnimation(index)) {
   var endOpacity = this.GetModalElementEndAnimationOpacity(index);
   ASPx.AnimationHelper.setOpacity(modalElement, 0);
   ASPx.SetElementVisibility(modalElement, true);
   ASPx.AnimationHelper.fadeTo(modalElement, { to: endOpacity });
  } else
   ASPx.SetElementVisibility(modalElement, true);
 },
 AllowModalElementAnimation: function(index) {
  return this.popupAnimationType === ASPxClientPopupControlBase.AnimationType.Fade;
 },
 SetVisibleWithAnimation: function(element, isMoving, index, horizontalPopupPosition, verticalPopupPosition) {
  var isAnimationNeed = this.IsAnimationAllowed() && !isMoving;
  if(isAnimationNeed && this.popupAnimationType !== "none") {
   switch(this.popupAnimationType) {
    case ASPxClientPopupControlBase.AnimationType.Slide:
     this.StartSlideAnimation(element, index, horizontalPopupPosition, verticalPopupPosition);
     break;
    case ASPxClientPopupControlBase.AnimationType.Fade:
     this.StartFadeAnimation(element, index);
     break;
    case ASPxClientPopupControlBase.AnimationType.Auto:
     this.StartAutoAnimation(element, index, horizontalPopupPosition, verticalPopupPosition);
     break;
   }
  }
  else
   ASPx.SetElementVisibility(element, true);
 },
 StartAutoAnimation: function(element, index, horizontalPopupPosition, verticalPopupPosition) {
  ASPx.SetElementVisibility(element, true);
 },
 StartFadeAnimation: function(element, index) {
  ASPx.AnimationHelper.setOpacity(element, 0);
  ASPx.SetElementVisibility(element, true);
  var callback = function() {
   this.OnAnimationStop(index);
  }.aspxBind(this);
  ASPx.AnimationHelper.fadeIn(element, callback, this.fadeAnimationDuration);
 },
 StartSlideAnimation: function (animationDivElement, index, horizontalPopupPosition, verticalPopupPosition) {
  var element = this.GetWindowMainCell(animationDivElement);
  var clientX = horizontalPopupPosition.position;
  var clientY = verticalPopupPosition.position;
  var args = "(\"" + this.name + "\", " + index + ")";
  var onAnimStopCallString = "ASPx.PCAStop" + args;
  this.InitDivPosForShowSlideAnimation(index, animationDivElement, clientX, clientY, onAnimStopCallString);
  var horizontalDirection = this.GetAnimationHorizontalDirection(index, horizontalPopupPosition);
  var verticalDirection = this.GetAnimationVerticalDirection(index, verticalPopupPosition);
  var offsetCoefficient = this.GetSlideOffsetCoefficient(index);
  var xPos = horizontalDirection * animationDivElement.offsetWidth * offsetCoefficient;
  var yPos = verticalDirection * animationDivElement.offsetHeight * offsetCoefficient;
  neddToForceAnimation = xPos === 0 && yPos === 0;
  if(neddToForceAnimation) 
   yPos = 1;
  ASPx.SetStyles(element, { left: xPos, top: yPos });
  ASPx.SetElementVisibility(animationDivElement, true);
  this.DoShowWindowIFrame(index, clientX, clientY, 0, 0);
  ASPx.PopupUtils.StartSlideAnimation(animationDivElement, element, this.GetWindowIFrame(index), this.GetSlideAnimationDuration(index));
 },
 GetSlideAnimationDuration: function(index) {
  return this.slideAnimationDuration;
 },
 GetSlideOffsetCoefficient: function(index) {
  return 1;
 },
 InitDivPosForShowSlideAnimation: function(index, animationDivElement, clientX, clientY, onAnimStopCallString) {
  ASPx.PopupUtils.InitAnimationDiv(animationDivElement, clientX, clientY, onAnimStopCallString, true);
 },
 InitDivPosForHideSlideAnimation: function(animationDivElement) {
 },
 StopShowAnimation: function(index) {
  if(this.popupAnimationType != "none") {
   var windowElement = this.GetWindowElement(index);
   if(this.popupAnimationType === 'slide')
    ASPx.PopupUtils.StopAnimation(windowElement, this.GetWindowMainCell(windowElement));
   else
    ASPx.AnimationHelper.cancelAnimation(windowElement);
  }
 },
 StopCloseAnimation: function(index) {
  var element = this.GetWindowElement(index);
  if(this.HasCloseAnimation() && !element.closeAnimationCompleted) {
   ASPx.AnimationHelper.cancelAnimation(element);
   this.DoHideWindowCore(index);
  }
 },
 IsFadeCloseAnimation: function(index) {
  return this.closeAnimationType === ASPxClientPopupControlBase.AnimationType.Fade;
 },
 PrepareElementAfterCloseAnimation: function(index, element) {
  element.closeAnimationCompleted = true;
  if(this.IsFadeCloseAnimation(index))
   ASPx.SetStyles(element, { opacity: 1 });
  else
   ASPx.SetStyles(this.GetWindowMainCell(element), {
    left: 0,
    top: 0
   });
 },
 DoHideWindowCoreWithAnimation: function(index, closeReason) {
  this.StopShowAnimation(index);
  var element = this.GetWindowElement(index);
  element.closeAnimationCompleted = false;
  if(this.AllowModalElementAnimation(index) && this.CanManipulateWithModalElement(index))
   ASPx.AnimationHelper.fadeOut(element.modalElement, null, this.fadeAnimationDuration);
  switch(this.closeAnimationType) {
   case ASPxClientPopupControlBase.AnimationType.Slide:
    this.DoHideWindowWithSlideAnimation(index, closeReason);
    break;
   case ASPxClientPopupControlBase.AnimationType.Fade:
    this.DoHideWindowWithFadeAnimation(index, element, closeReason);
    break;
   case ASPxClientPopupControlBase.AnimationType.Auto:
    this.DoHideWindowWithAutoAnimation(index, element, closeReason);
    break;
  }
 },
 DoHideWindowWithAutoAnimation: function(index, element, closeReason) {
 },
 DoHideWindowWithFadeAnimation: function(index, element, closeReason) {
  ASPx.AnimationHelper.fadeOut(element, function() {
   this.DoHideWindowCore(index);
   this.RaiseCloseUp(index, closeReason);
  }.aspxBind(this), this.fadeAnimationDuration);
 },
 DoHideWindowWithSlideAnimation: function(index, closeReason) {
  var element = this.GetWindowElement(index);
  var horizontalPopupPosition = this.GetSlideAnimationPosition(element, true);
  var verticalPopupPosition = this.GetSlideAnimationPosition(element, false);
  var horizontalDirection = this.GetAnimationHorizontalDirection(index, horizontalPopupPosition);
  var verticalDirection = this.GetAnimationVerticalDirection(index, verticalPopupPosition);
  this.InitDivPosForHideSlideAnimation(element);
  var offsetCoefficient = this.GetSlideOffsetCoefficient(index);
  ASPx.AnimationHelper.createMultipleAnimationTransition(this.GetWindowMainCell(element), {
   duration: this.GetSlideAnimationDuration(index),
   onComplete: function(element) {
    this.DoHideWindowCore(index);
    this.RaiseCloseUp(index, closeReason);
   }.aspxBind(this)
  }).Start({
   left: { to: horizontalDirection * element.offsetWidth * offsetCoefficient, unit: "px" },
   top: { to: verticalDirection * element.offsetHeight * offsetCoefficient, unit: "px" }
  });
 },
 GetSlideAnimationPosition: function(element, isX) {
  return this.GetClientPopupPos(element, null, ASPx.InvalidPosition, isX, true);
 },
 GetAnimationHorizontalDirection: function(index, horizontalPopupPosition) {
  return ASPx.PopupUtils.GetAnimationHorizontalDirection(horizontalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign, this.rtl);
 },
 GetAnimationVerticalDirection: function(index, verticalPopupPosition) {
  return ASPx.PopupUtils.GetAnimationVerticalDirection(verticalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign);
 },
 OnAnimationStop: function(index) {
  this.OnWindowShown(index);
 },
 PerformCallback: function(parameter, onSuccess) {
  this.PerformWindowCallback(null, parameter, onSuccess);
 },
 PerformWindowCallback: function(window, parameter, onSuccess) {
  parameter = ASPx.IsExists(parameter) ? parameter.toString() : "";
  var index = (window != null) ? window.index : -1;
  if(!this.InWindowCallback(index)) {
   var windowCallbackArguments = index + ";" + parameter;
   this.CreateWindowCallback(index, windowCallbackArguments, onSuccess);
  }
 },
 InWindowCallback: function(windowIndex) {
  return this.windowRequestCount[windowIndex] > 0;
 },
 CreateWindowCallback: function(windowIndex, argument, handler) {
  this.IncreaseWindowRequestCount(windowIndex);
  var element = this.GetWindowElement(windowIndex);
  if(this.contentLoadingMode != LoadContentViaCallback.OnPageLoad || !element.loading || this.GetShowOnPageLoad(windowIndex))
   this.ShowWindowLoadingElements(windowIndex);
  this.CreateCallback(argument, null, handler);
 },
 OnCallback: function(result) {
  this.OnCallbackInternal(result.html, result.index, false);
 },
 OnCallbackError: function(result, data) {
  this.OnCallbackInternal(result, ASPx.IsExists(data) ? data : -1, true);
 },
 OnCallbackErrorAfterUserHandle: function(result, data) {
  this.DecreaseWindowRequestCount(data);
 },
 OnCallbackInternal: function(html, windowIndex, isError) {
  var element = this.GetWindowElement(windowIndex);
  element.loaded = !isError;
  element.loading = false;
  this.DecreaseWindowRequestCount(windowIndex);
  this.HideWindowLoadingPanel(windowIndex);
  this.SetWindowContentHtmlCore(windowIndex, html);
  this.UpdatePositionAfterCallback(windowIndex);
  this.savedCallbackWindowIndex = windowIndex;
  this.UpdateWindowsStateCookie();
 },
 RaiseCallbackError: function(message) {
  var result = ASPxClientControl.prototype.RaiseCallbackError.call(this, message);
  if(result.isHandled)
   this.HideAllLoadingPanels();
  return result;
 },
 StartWindowBeginCallbackAnimation: function(windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = true;
  this.isCallbackFinishedStates[windowIndex] = false;
  ASPx.AnimationHelper.fadeOut(this.GetWindowContentElement(windowIndex), function() { this.FinishWindowBeginCallbackAnimation(windowIndex); }.aspxBind(this));
 },
 FinishWindowBeginCallbackAnimation: function(windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = false;
  if(!this.isCallbackFinishedStates[windowIndex])
   this.ShowWindowLoadingElementsInternal(windowIndex);
  else
   this.DoCallback(this.savedCallbackResults[windowIndex]);
 },
 CheckBeginCallbackAnimationInProgress: function(callbackResult) {
  var result;
  try {
   result = this.EvalCallbackResult(callbackResult).result;
  } catch(e) {
   return false;
  }
  var windowIndex = result.index;
  if(this.enableCallbackAnimation && this.callbackAnimationProcessings[windowIndex]) {
   this.savedCallbackResults[windowIndex] = callbackResult;
   this.isCallbackFinishedStates[windowIndex] = true;
   return true;
  }
  return false;
 },
 StartWindowEndCallbackAnimation: function(windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = true;
  ASPx.AnimationHelper.fadeIn(this.GetWindowContentElement(windowIndex), function() { this.FinishWindowEndCallbackAnimation(windowIndex); }.aspxBind(this));
 },
 FinishWindowEndCallbackAnimation: function(windowIndex) {
  this.DoEndCallback();
  this.callbackAnimationProcessings[windowIndex] = false;
 },
 CheckEndCallbackAnimationNeeded: function() {
  var windowIndex = this.savedCallbackWindowIndex;
  this.savedCallbackWindowIndex = null;
  if(windowIndex !== null && !this.callbackAnimationProcessings[windowIndex]) {
   this.StartWindowEndCallbackAnimation(windowIndex);
   return true;
  }
  return false;
 },
 EnsureContent: function(windowIndex, isInit) {
  var element = this.GetWindowElement(windowIndex);
  if(element && !element.loaded && !element.loading) {
   var shouldLoad = this.contentLoadingMode == LoadContentViaCallback.OnPageLoad || this.contentLoadingMode == LoadContentViaCallback.OnFirstShow && !isInit;
   if(shouldLoad) {
    element.loading = true;
    this.CreateWindowCallback(windowIndex, windowIndex);
   } else if(this.contentLoadingMode == LoadContentViaCallback.Default)
    element.loaded = true;
  }
 },
 HideAllLoadingPanels: function() {
  if(this.HasDefaultWindow())
   this.HideWindowLoadingPanel(-1);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.HideWindowLoadingPanel(i);
 },
 HideWindowLoadingPanel: function(windowIndex) {
  this.ClearWindowLoadingPanelTimer(windowIndex);
  if(this.loadingDivs[windowIndex]) {
   ASPx.RemoveElement(this.loadingDivs[windowIndex]);
   this.loadingDivs[windowIndex] = null;
  }
  if(this.loadingPanels[windowIndex]) {
   ASPx.RemoveElement(this.loadingPanels[windowIndex]);
   this.loadingPanels[windowIndex] = null;
  }
 },
 ShowWindowLoadingElements: function(windowIndex) {
  if(this.lpTimers[windowIndex] && this.lpTimers[windowIndex] > -1) return;
  if(this.enableCallbackAnimation)
   this.StartWindowBeginCallbackAnimation(windowIndex);
  else
   this.ShowWindowLoadingElementsInternal(windowIndex);
 },
 ShowWindowLoadingPanelOnTimer: function(windowIndex) {
  this.ClearWindowLoadingPanelTimer(windowIndex);
  this.ShowWindowLoadingPanel(windowIndex);
 },
 ClearWindowLoadingPanelTimer: function(windowIndex) {
  this.lpTimers[windowIndex] = ASPx.Timer.ClearTimer(this.lpTimers[windowIndex]);
 },
 ShowWindowLoadingElementsInternal: function(windowIndex) {
  if(this.lpDelay > 1 && !this.enableCallbackAnimation) {
   var _this = this;
   this.lpTimers[windowIndex] = window.setTimeout(function() { _this.ShowWindowLoadingPanelOnTimer(windowIndex); }, this.lpDelay);
  }
  else
   this.ShowWindowLoadingPanel(windowIndex);
 },
 ShowWindowLoadingPanel: function(windowIndex) {
  if(!this.IsExistLoadingPanel())
   return;
  if(!this.loadingPanels[windowIndex] && this.InternalIsWindowVisible(windowIndex)) {
   var parentElement = this.GetWindowElement(windowIndex).parentNode;
   var offsetElement = this.GetLoadingPanelOffsetElement(windowIndex);
   this.loadingDivs[windowIndex] = this.CreateLoadingDiv(parentElement, offsetElement, windowIndex);
   this.loadingPanels[windowIndex] = this.CreateLoadingPanelWithAbsolutePosition(parentElement, offsetElement, windowIndex);
  }
 },
 GetLoadingPanelOffsetElement: function(windowIndex) {
  return this.GetWindowContentWrapperElement(windowIndex);
 },
 IsExistLoadingPanel: function() {
  return !!this.GetLoadingDiv();
 },
 LockAnimation: function() {
  this.animationLockCount++;
 },
 UnlockAnimation: function() {
  this.animationLockCount--;
 },
 IsAnimationLocked: function() {
  return this.animationLockCount > 0;
 },
 IsAnimationAllowed: function() {
  return this.enableAnimation && !this.IsAnimationLocked();
 },
 SetWindowSizeByIndexCore: function(index, width, height, isWindowCollapsed) {
  this.SetClientWindowSizeLite(index, width, height, isWindowCollapsed);
  var iFrame = this.GetWindowIFrame(index);
  if(iFrame && !isWindowCollapsed) {
   var winElememnt = this.GetWindowElement(index);
   var realWidth = winElememnt.offsetWidth;
   var realHeight = winElememnt.offsetHeight;
   ASPx.SetStyles(iFrame, { width: realWidth, height: realHeight });
  }
  this.UpdateWindowsStateCookie();
 },
 SetWindowSizeByIndex: function(index, width, height) {
  var minWidth = this.GetWindowMinWidth(index);
  var minHeight = this.GetWindowMinHeight(index);
  var maxWidth = this.GetWindowMaxWidth(index);
  var maxHeight = this.GetWindowMaxHeight(index);
  if(minWidth)
   width = Math.max(width, minWidth);
  if(minHeight)
   height = Math.max(height, minHeight);
  if(maxWidth)
   width = Math.min(width, maxWidth);
  if(maxHeight)
   height = Math.min(height, maxHeight);
  var isWindowMaximized = this.GetIsMaximized(index);
  var isWindowCollapsed = this.GetIsCollapsed(index);
  var isWindowMaximizedAndCollapsed = (isWindowMaximized && isWindowCollapsed);
  if(this.SizeCanBeSet(index, isWindowMaximizedAndCollapsed)) {
   if(!this.CollapseExecuting() && !this.MaximizationExecuting() && !this.ResizingForMaxWindowLocked()) {
    this.SetWindowCachedSize(index, width, height);
    this.SetIsResized(index, true);
   }
   if(isWindowCollapsed && !this.MaximizationExecuting() && !this.ResizingForMaxWindowLocked()) {
    this.SetWindowCachedSize(index, width, height);
    this.UpdateRestoredWindowSize(index, width, height);
    height = 0;
   }
   if(isWindowMaximized && !this.CollapseExecuting() && !this.ResizingForMaxWindowLocked()) {
    this.SetWindowCachedSize(index, width, height);
    this.UpdateRestoredWindowSize(index, width, height);
   } else {
    this.SetWindowSizeByIndexCore(index, width, height, isWindowCollapsed);
   }
  } else
   this.SetWindowCachedSize(index, width, height);
 },
 SizeCanBeSet: function(index, isWindowMaximizedAndCollapsed) {
  return this.InternalIsWindowDisplayed(index) && this.IsWindowElementsIDAssigned(index) && (!isWindowMaximizedAndCollapsed || this.ResizingForMaxWindowLocked());
 },
 RestoreWindowSizeFromCache: function(index) {
  var cachedSize = this.GetWindowCachedSize(index);
  if(cachedSize != null) {
   if(cachedSize.width !== this.GetClientWindowWidth(index, true, true) ||
      cachedSize.height !== this.GetClientWindowHeight(index, true, true))
    this.SetWindowSizeByIndex(index, cachedSize.width, cachedSize.height);
   this.ResetWindowCachedSize(index);
  }
 },
 CollapseExecuting: function() {
  return false;
 },
 MaximizationExecuting: function() {
  return false;
 },
 ResizingForMaxWindowLocked: function() {
  return false;
 },
 IsResizeAllowed: function(index) {
  return this.allowResize;
 },
 GetWindowDimensionByIndex: function(index, isWidth, forceFromCache) {
  var cachedSize = this.GetWindowCachedSize(index);
  var dimensionValue = null;
  if(forceFromCache == undefined && !this.GetWindowElement(index))
   forceFromCache = true;
  if(cachedSize && forceFromCache)
   dimensionValue = isWidth ? cachedSize.width : cachedSize.height;
  if(dimensionValue)
   return dimensionValue;
  else {
   var element = this.GetWindowElement(index);
   var sizeFromDOM = 0;
   if(this.GetIsCollapsed(index)) {
    var headerCell = this.GetWindowHeaderElement(index);
    sizeFromDOM = isWidth ? headerCell.offsetWidth : headerCell.offsetHeight;
   }
   else {
    var mainCell = this.GetWindowMainCell(element);
    sizeFromDOM = isWidth ? mainCell.offsetWidth : mainCell.offsetHeight;
   }
   if(sizeFromDOM === 0 && cachedSize)
    sizeFromDOM = isWidth ? cachedSize.width : cachedSize.height;
   return sizeFromDOM;
  }
 },
 SetWindowSize: function(window, width, height) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowSizeByIndex(index, width, height);
 },
 SetSize: function(width, height) {
  this.SetWindowSize(null, width, height);
 },
 SetWidth: function(width) {
  var height = this.GetHeight();
  this.SetSize(width, height);
 },
 SetHeight: function(height) {
  var width = this.GetWidth();
  this.SetSize(width, height);
 },
 GetHeight: function() {
  return this.GetWindowDimensionByIndex(-1, false, false);
 },
 GetWidth: function() {
  return this.GetWindowDimensionByIndex(-1, true, false);
 },
 CanBeClosedByClickOnElement: function(index, srcElement, posX, id) {
  return srcElement === null || ASPx.GetParentById(srcElement, id) === null;
 },
 OnMouseDown: function(evt, index, isDraggingAllowed, pointOnScrollBar) {
  if(ASPx.Evt.IsLeftButtonPressed(evt)) {
   if((this.IsResizeAllowed(index) || isDraggingAllowed) && !this.prohibitClearSelectionOnMouseDown) 
    ASPx.Selection.Clear();
   var isResizing = this.ProcessResizeOnMouseDown(evt, index);
   var clickedOnScroll = pointOnScrollBar && this.GetEnableContentScrolling(index);
   if(isDraggingAllowed && !isResizing && !clickedOnScroll && !this.GetIsPinned(index) && !this.GetIsMaximized(index) && !ASPx.Ident.IsFocusableElementRegardlessTabIndex(evt.target))
    this.OnDragStart(evt, index);
  }
 },
 OnMouseMove: function(evt, index) {
  if(this.allowResize && !this.GetIsCollapsed(index) && !this.GetIsMaximized(index))
   this.CreateResizeCursorInfo(evt, index);
 },
 CreateResizeCursorInfo: function(evt, index) {
  var element = this.GetWindowElement(index);
  var mainCell = this.GetWindowMainCell(element);
  var clientWindow = this.GetWindowClientTable(index);
  var headerElement = this.GetWindowHeaderElement(index);
  var left = ASPx.GetAbsoluteX(mainCell);
  var top = ASPx.GetAbsoluteY(mainCell);
  var x = ASPx.Evt.GetEventX(evt);
  var y = ASPx.Evt.GetEventY(evt);
  var mainCellWidth = mainCell.offsetWidth;
  var mainCellHeight = mainCell.offsetHeight;
  var leftOffset = Math.abs(x - left);
  var rightOffset = Math.abs(x - left - mainCellWidth);
  var topOffset = Math.abs(y - top);
  var bottomOffset = Math.abs(y - top - mainCellHeight);
  var cursorInfo = this.CreateResizeBorderCursorInfo(index, leftOffset, rightOffset, topOffset, bottomOffset);
  var grip = this.GetWindowSizeGripElement(index);
  if(grip) {
   var gripCursorInfo = this.CreateGripCursorInfo(index, mainCell, grip, leftOffset, rightOffset, bottomOffset);
   if(gripCursorInfo)
    cursorInfo = gripCursorInfo;
  }
  this.UpdateResizeCursor(index, clientWindow, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  this.UpdateResizeCursor(index, mainCell, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  if(headerElement)
   this.UpdateResizeCursor(index, headerElement, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  return cursorInfo;
 },
 UpdateResizeCursor: function(index, element, verticalDirection, horizontalDirection) {
  var cursor = verticalDirection + horizontalDirection;
  if(cursor == "")
   this.HideTemporaryCursor(element);
  else {
   cursor += "-resize";
   this.ShowTemporaryCursor(element, cursor);
  }
 },
 CreateGripCursorInfo: function(index, mainCell, grip, leftOffset, rightOffset, bottomOffset) {
  var gripWidth = this.rtl
   ? ASPx.GetAbsoluteX(grip) - ASPx.GetAbsoluteX(mainCell) + grip.offsetWidth
   : mainCell.offsetWidth - (ASPx.GetAbsoluteX(grip) - ASPx.GetAbsoluteX(mainCell));
  var gripHeight = mainCell.offsetHeight - (ASPx.GetAbsoluteY(grip) - ASPx.GetAbsoluteY(mainCell));
  if(gripHeight > bottomOffset) {
   if(this.rtl && gripWidth > leftOffset)
    return new PCResizeCursorInfo("w", "s", leftOffset, bottomOffset);
   if(gripWidth > rightOffset)
    return new PCResizeCursorInfo("e", "s", rightOffset, bottomOffset);
  }
  return null;
 },
 CreateResizeBorderCursorInfo: function(index, leftOffset, rightOffset, topOffset, bottomOffset) {
  var ResizeBorderSize = this.ResizeBorderSize;
  var verticalDirection = this.GetResizeVerticalCourse(ResizeBorderSize, topOffset, bottomOffset);
  ResizeBorderSize = verticalDirection != "" ? this.ResizeCornerBorderSize : this.ResizeBorderSize;
  var horizontalDirection = this.GetResizeHorizontalCourse(ResizeBorderSize, leftOffset, rightOffset);
  if(verticalDirection == "" && horizontalDirection != "")
   verticalDirection = this.GetResizeVerticalCourse(this.ResizeCornerBorderSize, topOffset, bottomOffset);
  var horizontalOffset = leftOffset < rightOffset ? leftOffset : rightOffset;
  var verticalOffset = topOffset < bottomOffset ? topOffset : bottomOffset;
  return new PCResizeCursorInfo(horizontalDirection, verticalDirection, horizontalOffset, verticalOffset);
 },
 GetResizeVerticalCourse: function(ResizeBorderSize, topOffset, bottomOffset) {
  if(ResizeBorderSize > topOffset) return "n";
  if(ResizeBorderSize > bottomOffset) return "s";
  return "";
 },
 GetResizeHorizontalCourse: function(ResizeBorderSize, leftOffset, rightOffset) {
  if(ResizeBorderSize > leftOffset) return "w";
  if(ResizeBorderSize > rightOffset) return "e";
  return "";
 },
 ProcessResizeOnMouseDown: function(evt, index) {
  var isResizing = false;
  if(this.IsResizeAllowed(index) && !this.GetIsCollapsed(index) && !this.GetIsMaximized(index)) {
   var eventSourceControl = ASPx.Evt.GetEventSource(evt);
   var eventFromPopupContainer = ASPx.ElementHasCssClass(eventSourceControl, PopupControlCssClasses.ContentCssClassName) ||
    !ASPx.GetParentByClassName(eventSourceControl, PopupControlCssClasses.ContentCssClassName) ||
    this.eventFromOwnPopupContent(eventSourceControl);
   if(eventFromPopupContainer && getComputedStyle(evt.target).cursor !== "pointer")
    isResizing = this.OnResizeStart(evt, index);
  }
  if(isResizing && ASPx.Browser.WebKitTouchUI)
   aspxGetPopupControlCollection().OverStop();
  return isResizing;
 },
 eventFromOwnPopupContent: function(element) {
  while(element != null) {
   if(element.tagName == "BODY")
    return false;
   if(element.style.position == "absolute") {
    var windowIndex = this.GetWindowIndex(element);
    var isPopupWindow = !isNaN(windowIndex);
    if(isPopupWindow) {
     if(this.GetWindowElementId(windowIndex) == element.id)
      return true;
     return false;
    } else {
     var elementIsOtherPopup = element.style.zIndex >= this.GetPopupControlZIndex(); 
     if(elementIsOtherPopup)
      return false;
    }
   }
   element = element.parentNode;
  }
  return false;
 },
 OnResizeStart: function(evt, index) {
  if(!aspxGetPopupControlCollection().IsResizeInint()) {
   var cursor = this.CreateResizeCursorInfo(evt, index);
   if(cursor.course != "") {
    aspxGetPopupControlCollection().setIframesMouseMoveEnabled(false);
    this.EnsureWindowCoverDiv(index);
    this.SetIsResized(index, true);
    var resizePanel = this.CreateResizePanel(index);
    this.UpdateResizeCursor(index, resizePanel, cursor.verticalDirection, cursor.horizontalDirection);
    aspxGetPopupControlCollection().InitResizeObject(this, index, cursor, resizePanel);
    this.OnResize(evt, index, cursor, resizePanel);
   }
  }
  return aspxGetPopupControlCollection().IsResizeInint();
 },
 OnResizeStop: function(evt, index, cursor, resizePanel) {
  if(this.IsResizeAllowed(index)) {
   aspxGetPopupControlCollection().setIframesMouseMoveEnabled(true);
   this.RemoveWindowCoverDiv();
   var windowElement;
   if(!this.isLiveResizingMode) {
    windowElement = this.GetWindowElement(index);
    ASPx.GetControlCollection().CollapseControls(windowElement);
    this.OnResizeWindow(index, cursor, resizePanel);
   }
   this.CreateResizeCursorInfo(evt, index);
   this.UpdateWindowsStateCookie();
   this.RaiseResize(index);
   if(!this.isLiveResizingMode)
    ASPx.GetControlCollection().AdjustControls(windowElement, true);
  }
  this.ResetResizeSessionCache();
 },
 OnResizeWindow: function(index, cursor, resizePanel) {
  var windowElement = this.GetWindowElement(index);
  var resizePanelDimensions = this.GetResizePanelDimensions();
  var left = resizePanelDimensions.left;
  var top = resizePanelDimensions.top;
  this.SetClientWindowSizeLite(index, resizePanelDimensions.offsetWidth, resizePanelDimensions.offsetHeight);
  if(this.fixedBottom)
   top = this.fixedBottom - windowElement.offsetHeight;
  if(this.fixedRight)
   left = this.fixedRight - windowElement.offsetWidth;
  this.fixedBottom = null;
  this.fixedRight = null;
  if(cursor.verticalDirection === "n")
   this.ChangePosOnResizeWindow(top, windowElement, false);
  if(cursor.horizontalDirection === "w")
   this.ChangePosOnResizeWindow(left, windowElement, true);
  if(this.InternalIsWindowVisible(index)) 
   this.DoShowWindowIFrame(index, left, top, ASPx.InvalidDimension, ASPx.InvalidDimension);
 },
 ChangePosOnResizeWindow: function(pos, windowElement, isX) {
  if(ASPx.Browser.IE && ASPx.Browser.Version >= 10)
   pos = Math.round(pos);
  windowElement.style[isX ? "left" : "top"] = pos + "px";
 },
 SetClientWindowSizeLite: function(index, width, height, isWindowCollapsed) {
  this.RaiseBeforeResizing(index);
  this.SetClientWindowSizeCoreLite(index, width, height, isWindowCollapsed);
  if(!this.IsRaiseAfterResizingLocked())
   this.RaiseAfterResizing(index);
 },
 SetClientWindowSizeCoreLite: function(index, width, height, isWindowCollapsed) {
  var contentUrl = this.GetWindowContentIFrameUrl(index);
  var needToHideContent = !contentUrl;
  var element = this.GetWindowElement(index);
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  var contentElement = this.GetWindowContentElement(index);
  var scrollTop = null,
   scrollLeft = null;
  if(ASPx.Browser.IE && this.GetEnableContentScrolling(index)) {
   scrollTop = contentElement.scrollTop;
   scrollLeft = contentElement.scrollLeft;
  }
  var contentIframeElement = this.GetWindowContentIFrameElement(index);
  var iframeHeightCorrectionOnFirstShow = height > 0;
  if(contentIframeElement && (this.GetWindowIsShown(index) || iframeHeightCorrectionOnFirstShow))
   contentIframeElement.style.height = "0px";
  contentWrapper.style.height = "";
  contentWrapper.style.width = "";
  contentElement.style.height = "";
  contentElement.style.width = "";
  var hasAnyScrollBars = this.HasAnyScrollBars(index);
  var expectedHeight = (!ASPx.IsExists(height) && hasAnyScrollBars) ? this.GetExpectedHeight(index) : null;
  var contentElementChildrenScroll = null,
   contentElementChildren = null;
  if(needToHideContent) {
   if(ASPx.Browser.IE) {
    var contentElementChildren = this.GetContentElementChildren(index, contentElement),
     contentElementChildrenScroll = this.GetContentElementChildrenScroll(index, contentElementChildren);
   }
   contentElement.style.display = "none";
  }
  var elementsDisplayValue = this.GetWindowElementDisplayValue(hasAnyScrollBars, height);
  element.style.display = elementsDisplayValue;
  if(!this.GetIsCollapsed(index))
   contentWrapper.style.display = elementsDisplayValue;
  if(ASPx.IsExists(width)) {
   var actualWidth = width - this.GetElementBordersAndPaddings(index, element, true);
   if(actualWidth <= 0)
    actualWidth = ASPx.Browser.WebKitFamily ? 1 : 0; 
   element.style.width = actualWidth + "px";
  }
  var actualHeight;
  if(ASPx.IsExists(height)) {
   actualHeight = height - this.GetElementBordersAndPaddings(index, element, false);
   if(actualHeight < 0)
    actualHeight = 0;
   element.style.height = actualHeight + "px";
  } else {
   if(ASPx.IsExists(expectedHeight)) {
    actualHeight = expectedHeight;
    element.style.height = actualHeight + "px";
   }
  }
  this.CorrectWindowSizeGripPositionLite(index);
  this.CorrectWindowHeaderText(index);
  this.SetContentWrapperHeightLite(index, actualHeight, element, contentWrapper);
  var correctContentElementSize = hasAnyScrollBars || contentElement.style.overflow == "hidden" || contentElement.style.overflowX == "hidden" || contentElement.style.overflowY == "hidden";
  if((correctContentElementSize || contentUrl) && (height || expectedHeight)) {
   if(contentElement !== contentWrapper) {
    var contentHeight = ASPx.GetClearClientHeight(contentWrapper);
    if(contentHeight < 0)
     contentHeight = 0;
    contentElement.style.height = contentHeight + "px";
   }
  }
  if(correctContentElementSize && width && contentElement !== contentWrapper)
   contentElement.style.width = ASPx.GetClearClientWidth(contentWrapper) + "px";
  contentElement.style.display = this.getContentElementDisplay(correctContentElementSize, contentUrl);
  if(ASPx.IsExists(contentElementChildrenScroll) && contentElementChildrenScroll.length > 0) {
   for(var i = 0; i < contentElementChildrenScroll.length; i++) {
    var childScroll = contentElementChildrenScroll[i],
     childIndex = childScroll[0],
     childScrollLeft = childScroll[1],
     childScrollTop = childScroll[2];
    if(!!childScrollLeft)
     contentElementChildren[childIndex].scrollLeft = childScrollLeft;
    if(!!childScrollTop)
     contentElementChildren[childIndex].scrollTop = childScrollTop;
   }
  }
  if(ASPx.Browser.IE && this.GetEnableContentScrolling(index)) {
   contentElement.scrollTop = scrollTop;
   contentElement.scrollLeft = scrollLeft;
  }
  if(contentIframeElement)
   contentIframeElement.style.height = "100%";
  this.SetWindowWidth(index, width);
  this.SetWindowHeight(index, height);
  if(isWindowCollapsed)
   this.ResetWindowHeight(index);
 },
 GetExpectedHeight: function(index) {
  var height = this.GetWindowHeightInternal(index) || 0;
  height = Math.max(height, this.GetWindowMinHeight(index));
  if(this.HasAnyScrollBars(index)) {
   var windowHeight = this.GetWindowContentElement(index).offsetHeight + this.GetWindowHeightWithoutContent(index);
   height = Math.max(height, windowHeight);
  }
  var maxHeight = this.GetWindowMaxHeight(index);
  if(maxHeight)
   height = Math.min(height, maxHeight);
  return height;
 },
 IsRaiseAfterResizingLocked: function() {
  return false;
 },
 CreateResizePanel: function(index) {
  var element = this.GetWindowElement(index);
  var resizePanel = document.createElement("DIV");
  element.parentNode.appendChild(resizePanel);
  resizePanel.style.overflow = "hidden";
  resizePanel.style.position = "absolute";
  resizePanel.style.zIndex = this.GetPopupControlZIndex() + aspxGetPopupControlCollection().visiblePopupWindowIds.length * 2 + 2;
  if(!this.isLiveResizingMode)
   resizePanel.style.border = "black 1px dotted";
  return resizePanel;
 },
 OnResize: function(evt, index, cursor, resizePanel) {
  this.OnResizePanelLite(evt, index, cursor, resizePanel);
  if(this.isLiveResizingMode)
   this.OnResizeWindow(index, cursor, resizePanel);
  ASPx.Selection.Clear();
  if(ASPx.Browser.WebKitTouchUI)
   ASPx.Evt.PreventEvent(evt);
  if(this.GetIsPinned(index))
   this.HoldPosition(index, true, resizePanel);
 },
 OnResizePanelLite: function(evt, index, cursor, resizePanel) {
  var x = ASPx.Evt.GetEventX(evt);
  var y = ASPx.Evt.GetEventY(evt);
  var element = this.GetWindowElement(index);
  if(ASPx.Browser.IE && ASPx.Browser.Version >= 10) {
   x = Math.round(x);
   y = Math.round(y);
  }
  var elementTop = ASPx.GetAbsoluteY(element);
  var elementLeft = ASPx.GetAbsoluteX(element);
  var newLeft = ASPx.PxToInt(element.style.left);
  var newTop = ASPx.PxToInt(element.style.top);
  var newWidth = element.offsetWidth;
  var newHeight = element.offsetHeight;
  if(cursor.verticalDirection == "n") {
   if(!this.fixedBottom)
    this.fixedBottom = newTop + newHeight;
   newHeight += elementTop - y + cursor.verticalOffset;
   newTop = ASPx.PrepareClientPosForElement(y - cursor.verticalOffset, element, false);
  }
  if(cursor.verticalDirection == "s") {
   newHeight = y - elementTop + cursor.verticalOffset;
   this.fixedBottom = null;
  }
  if(cursor.horizontalDirection == "w") {
   if(!this.fixedRight)
    this.fixedRight = newLeft + newWidth;
   newWidth += elementLeft - x + cursor.horizontalOffset;
   newLeft = ASPx.PrepareClientPosForElement(x - cursor.horizontalOffset, element, true);
  }
  if(cursor.horizontalDirection == "e") {
   newWidth = x - elementLeft + cursor.horizontalOffset;
   this.fixedRight = null;
  }
  if(newWidth > 0 && newHeight > 0) {
   var minWidth = this.GetWindowMinWidth(index);
   var maxWidth = this.GetWindowMaxWidth(index);
   if(minWidth && newWidth < minWidth)
    newWidth = minWidth;
   if(maxWidth && newWidth > maxWidth)
    newWidth = maxWidth;
   var minHeight = this.GetWindowMinHeight(index);
   var maxHeight = this.GetWindowMaxHeight(index);
   if(minHeight && newHeight < minHeight)
    newHeight = minHeight;
   if(maxHeight && newHeight > maxHeight)
    newHeight = maxHeight;
   if(ASPx.Browser.IE && ASPx.Browser.Version >= 10) {
    newLeft = Math.round(newLeft);
    newTop = Math.round(newTop);
    newHeight = Math.round(newHeight);
    newWidth = Math.round(newWidth);
   }
   this.SetResizePanelDimensions(newLeft, newTop, newWidth, newHeight);
   var widthWithoutBorders = newWidth - this.getLeftRightBordersAndPaddingsSummaryValue(resizePanel);
   var heightWithoutBorders = newHeight - this.getTopBottomBordersAndPaddingsSummaryValue(resizePanel);
   ASPx.SetStyles(resizePanel, {
    left: newLeft, top: newTop,
    width: widthWithoutBorders, height: heightWithoutBorders
   });
   this.SetWindowLeft(index, elementLeft);
   this.SetWindowTop(index, elementTop);
  }
 },
 SetResizePanelDimensions: function(left, top, offsetWidth, offsetHeight) {
  var cache = this.GetResizeSessionCache();
  cache.resizePanelDimensions = {
   left: left,
   top: top,
   offsetWidth: offsetWidth,
   offsetHeight: offsetHeight
  };
 },
 GetResizePanelDimensions: function() {
  var cache = this.GetResizeSessionCache();
  return cache.resizePanelDimensions;
 },
 ResetResizeSessionCache: function() {
  this.resizeSessionCache = {};
 },
 GetResizeSessionCache: function() {
  return aspxGetPopupControlCollection().IsResizeInint() ? this.resizeSessionCache : {};
 },
 EnsureWindowCoverDiv: function(index) {
  this.windowCoverDiv = this.CreateCoverDiv(index);
  var windowElement = this.GetWindowElement(index);
  windowElement.parentNode.appendChild(this.windowCoverDiv);
 },
 CreateCoverDiv: function(index) {
  var coverDiv = document.createElement("DIV");
  ASPx.SetStyles(coverDiv, {
   position: "fixed",
   left: 0,
   top: 0,
   width: "100%",
   height: "100%"
  });
  return coverDiv;
 },
 RemoveWindowCoverDiv: function() {
  if(!!this.windowCoverDiv) {
   this.windowCoverDiv.parentNode.removeChild(this.windowCoverDiv);
   this.windowCoverDiv = null;
  }
 },
 OnDrag: function(index, x, y, xClientCorrection, yClientCorrection) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   ASPx.SetStyles(element, { left: x, top: y });
   xClientCorrection = typeof (xClientCorrection) != "undefined" ? xClientCorrection : 0;
   yClientCorrection = typeof (yClientCorrection) != "undefined" ? yClientCorrection : 0;
   this.SetWindowLeft(index, x + xClientCorrection);
   this.SetWindowTop(index, y + yClientCorrection);
   var iFrame = element.overflowElement;
   if(iFrame)
    ASPx.SetStyles(iFrame, { left: x, top: y });
   if(ASPx.Browser.Opera)
    ASPx.Selection.Clear();
  }
 },
 OnDragStop: function(index) {
  this.HideDragCursor(index);
  this.UpdateWindowsStateCookie();
  if(this.GetWindowContentIFrameElement(index))
   this.SetIframeVisibleForDragging(index, true);
  this.RaiseDragged(index);
 },
 OnDragStart: function(evt, index) {
  this.RaiseBeforeDrag(index);
  this.SetIsDragged(index, true);
  this.ShowDragCursor(index);
  if(this.GetWindowContentIFrameElement(index))
   this.SetIframeVisibleForDragging(index, false);
  this.InitDragInfo(index, evt);
 },
 HideIframeElementBeforeDragging: function() {
 },
 InitDragInfo: function(index, evt) {
  var element = this.GetWindowElement(index);
  var gragXOffset = ASPx.GetAbsoluteX(element) - ASPx.Evt.GetEventX(evt);
  var gragYOffset = ASPx.GetAbsoluteY(element) - ASPx.Evt.GetEventY(evt);
  var xClientCorrection = this.GetDragCorrection(index, element, true);
  var yClientCorrection = this.GetDragCorrection(index, element, false);
  gragXOffset -= xClientCorrection;
  gragYOffset -= yClientCorrection;
  aspxGetPopupControlCollection().InitDragObject(this, index, gragXOffset, gragYOffset, xClientCorrection, yClientCorrection);
 },
 GetDragCorrection: function(index, element, isX) {
  return ASPx.GetPositionElementOffset(element, isX);
 },
 ShowDragCursor: function(index) {
  var dragElement = this.GetDragElement(index);
  if(dragElement)
   this.ShowTemporaryCursor(dragElement, "move");
 },
 ShowTemporaryCursor: function(element, cursor) {
  ASPx.Attr.ChangeStyleAttribute(element, "cursor", cursor);
 },
 HideDragCursor: function(index) {
  var dragElement = this.GetDragElement(index);
  if(dragElement != null)
   this.HideTemporaryCursor(dragElement);
 },
 GetDragElement: function(index) {
  var headerElement = this.GetWindowHeaderElement(index);
  var element = this.GetWindowElement(index);
  if(element != null)
   return (headerElement != null ? headerElement : this.GetWindowMainCell(element));
  return null;
 },
 HideTemporaryCursor: function(element) {
  ASPx.Attr.RestoreStyleAttribute(element, "cursor");
 },
 OnDocumentKeyDown: function(evt, popupWindow) {
  var handler = this.keyDownHandlers && this.keyDownHandlers[ASPx.GetShortcutCode(evt.keyCode, evt.ctrlKey, evt.shiftKey, evt.altKey)];
  if(handler)
   handler(this.GetWindowIndex(popupWindow));
 },
 OnEscKeyDown: function(index) {
  if(this.GetEnableCloseByEsc(index))
   this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.Escape);
 },
 OnRefreshButtonClick: function(index) {
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  if(contentIFrame)
   this.RefreshWindowContentUrl(this.GetWindow(index));
  else
   this.PerformWindowCallback(this.GetWindow(index));
 },
 OnCloseButtonClick: function(index) {
  this.RaiseCloseButtonClick(index);
  if(this.GetWindowCloseAction(index) != "None")
   this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.CloseButton);
 },
 Show: function(popupElementIndex) {
  this.ShowWindowByIndex(-1, popupElementIndex);
 },
 Hide: function() {
  this.HideWindow(null);
 },
 HideWindow: function(window) {
  var index = (window != null) ? window.index : -1;
  this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.API);
 },
 RaiseEventByIndex: function(index, event, argsName) {
  if(!event.IsEmpty()) {
   var window = index < 0 ? null : this.GetWindow(index),
    args = new argsName(window);
   event.FireEvent(this, args);
  }
 },
 RaiseCloseButtonClick: function(index) {
  this.RaiseEventByIndex(index, this.CloseButtonClick, ASPxClientPopupWindowEventArgs);
 },
 RaiseShown: function(index) {
  this.RaiseEventByIndex(index, this.Shown, ASPxClientPopupWindowEventArgs);
 },
 RaisePopUp: function(index) {
  this.RaiseEventByIndex(index, this.PopUp, ASPxClientPopupWindowEventArgs);
 },
 RaiseBeforeResizing: function(index) {
  this.RaiseEventByIndex(index, this.BeforeResizing, ASPxClientPopupWindowEventArgs);
 },
 RaiseAfterResizing: function(index) {
  this.RaiseEventByIndex(index, this.AfterResizing, ASPxClientPopupWindowEventArgs);
 },
 RaiseDragged: function(index) {
  this.RaiseEventByIndex(index, this.Dragged, ASPxClientPopupWindowEventArgs);
 },
 RaiseBeforeDrag: function(index) {
  this.RaiseEventByIndex(index, this.BeforeDrag, ASPxClientPopupWindowEventArgs);
 },
 RaiseClosing: function(index, closeReason) {
  var window = index < 0 ? null : this.GetWindow(index);
  var cancel = false;
  if(!this.Closing.IsEmpty()) {
   var args = new ASPxClientPopupWindowCancelEventArgs(window, closeReason);
   this.Closing.FireEvent(this, args);
   cancel = args.cancel;
  }
  return cancel;
 },
 RaiseCloseUp: function(index, closeReason) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.CloseUp.IsEmpty()) {
   var args = new ASPxClientPopupWindowCloseUpEventArgs(window, closeReason);
   this.CloseUp.FireEvent(this, args);
  }
 },
 RaiseResize: function(index, resizeState) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.Resize.IsEmpty()) {
   if(!resizeState)
    resizeState = ASPxClientPopupControlResizeState.Resized;
   var args = new ASPxClientPopupWindowResizeEventArgs(window, resizeState);
   this.Resize.FireEvent(this, args);
  }
 },
 RaisePopupOnShow: function(isMoving, index) {
  if(!isMoving) {
   this.RaisePopUp(index);
   if(!this.IsAnimationAllowed())
    this.OnWindowShown(index);
  }
 },
 OnActivate: function(index, evt) {
  var element = this.GetWindowElement(index);
  if(element != null)
   aspxGetPopupControlCollection().ActivateWindowElement(element, evt, this.GetPopupType(), this.GetDefaultZIndexFromServer(), this.GetPopupControlZIndex());
 },
 OnPWHBClickCore: function(evt, index, method) {
  this.OnActivate(index, evt);
  if(ASPx.TouchUIHelper.handleFastTapIfRequired(evt,
   function() { this[method](index); }.aspxBind(this), true)) {
   return;
  }
  if(ASPx.Browser.Opera)
   ASPx.Evt.EmulateDocumentOnMouseDown(evt);
  this[method](index);
 },
 OnScroll: function(evt, index) {
  if(this.HasIframeOnIos(index))
   this.ResetWebkitScrolling(this.getTouchScrollerElement(index), 0);
  if(!this.GetIsPinned(index) || (this.lockScroll > 0)) return;
  this.AdjustPinPositionWhileScroll(index);
 },
 ResetWebkitScrolling: function(scrollElement, timeout) {
  if(scrollElement.scrollTop === 0) {
   var styleName = "-webkit-overflow-scrolling";
   scrollElement.style[styleName] = "auto";
   window.setTimeout(function() {
    scrollElement.style[styleName] = "touch";
   }.aspxBind(this), timeout);
  }
 },
 HaveSpecialDivForAnimation: function() {
  return this.enableAnimation;
 },
 HasIframeOnIos: function(index) {
  return ASPx.Browser.MacOSMobilePlatform && !!this.GetWindowContentIFrameElement(index);
 },
 WindowIsModal: function(index) {
  return this.GetPropertyValue(index, "modal");
 },
 GetIsPopuped: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsIsPopupedList[index];
  return this.defaultIsPopuped;
 },
 SetIsPopuped: function(index, isPopuped) {
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsIsPopupedList[index] = isPopuped;
  this.defaultIsPopuped = isPopuped;
 },
 GetIsMaximized: function(index) {
  return false;
 },
 GetIsMaximizedInit: function(index) {
  return false;
 },
 GetCurrentLeft: function(index) {
  return this.GetPosition(index, true);
 },
 GetCurrentTop: function(index) {
  return this.GetPosition(index, false);
 },
 GetIsPinned: function(index) {
  return false;
 },
 GetIsCollapsed: function(index) {
  return false;
 }, 
 needToHidePinnedOutFromViewPort: function(index) {
  return false;
 },
 GetHideBodyScrollWhenModal: function(index) {
  return false;
 },
 GetCanScrollViewPort: function(index) {
  return false;
 },
 GetEnableContentScrolling: function(index) {
  return false;
 },
 AutoUpdateElementsPosition: function() {
 },
 GetWindowChild: function(index, idPostfix) {
  var elem = this.GetWindowElement(index);
  if(elem)
   return ASPx.GetChildById(elem, this.name + idPostfix);
  return null;
 },
 GetWindowIndex: function(element) {
  var id = element.id;
  var pos = id.lastIndexOf(ASPx.PCWIdSuffix);
  return parseInt(id.substr(pos + ASPx.PCWIdSuffix.length));
 },
 GetWindow: function(index) {
  return (0 <= index && index < this.windows.length) ? this.windows[index] : null;
 },
 DoShowWindowIFrame: function(index, x, y, width, height) {
  if(!this.renderIFrameForPopupElements) return;
  var element = this.GetWindowElement(index);
  var iFrame = this.GetWindowIFrame(index);
  if(element && iFrame) {
   var cell = this.GetWindowMainCell(element);
   if(width < 0)
    width = cell.offsetWidth;
   if(height < 0)
    height = cell.offsetHeight;
   ASPx.SetStyles(iFrame, { width: width, height: height });
   if(this.IsValidPosition(x) && this.IsValidPosition(y))
    ASPx.SetStyles(iFrame, { left: x, top: y });
   if(ASPx.Browser.IE || ASPx.Browser.Firefox)
    this.ClearWindowIframeBodyInnerHtml(iFrame);
   ASPx.SetElementDisplay(iFrame, true);
  }
 },
 IsValidPosition: function(pos) {
  return pos !== ASPx.InvalidPosition;
 },
 DoHideWindowIFrame: function(element) {
  if(!this.renderIFrameForPopupElements) return;
  var iFrame = element.overflowElement;
  if(iFrame)
   ASPx.SetElementDisplay(iFrame, false);
 },
 GetIframeBody: function(iFrame) {
  var document = iFrame.contentDocument || iFrame.contentWindow.document;
  if(document)
   return document.getElementsByTagName('body')[0];
 },
 ClearWindowIframeBodyInnerHtml: function(iFrame) {
  var iFrameBody = this.GetIframeBody(iFrame);
  if(iFrameBody)
   iFrameBody.innerHTML = "";
 },
 FindWindowIFrame: function(index) {
  return ASPx.GetElementById(this.name + "_DXPWIF" + index);
 },
 GetWindowIFrame: function(index) {
  var element = this.GetWindowElement(index);
  var iFrame = element.overflowElement;
  if(!iFrame) {
   iFrame = this.FindWindowIFrame(index);
   element.overflowElement = iFrame;
  }
  return iFrame;
 },
 CreateFakeDivForIframe: function(iframe) {
  var fakeDiv = document.createElement("div");
  ASPx.SetStyles(fakeDiv, { width: iframe.offsetWidth, height: iframe.offsetHeight });
  return fakeDiv;
 },
 CreateIframeCoverDiv: function(iframe, index) {
  if(!this.iframeCoverDiv)
   this.iframeCoverDiv = [];
  if(!this.iframeCoverDiv[index])
   this.iframeCoverDiv[index] = this.CreateFakeDivForIframe(iframe);
  this.iframeCoverDiv[index].style.position = "absolute";
  iframe.parentElement.appendChild(this.iframeCoverDiv[index]);
  ASPx.SetAbsoluteX(this.iframeCoverDiv[index], ASPx.GetAbsoluteX(iframe));
  ASPx.SetAbsoluteY(this.iframeCoverDiv[index], ASPx.GetAbsoluteY(iframe));
 },
 RemoveIframeCoverDiv: function(iframe, index) {
  iframe.parentElement.removeChild(this.iframeCoverDiv[index]);
  this.iframeCoverDiv[index] = null;
 },
 GetWindowBorderOwnerElement: function(windowElement) {
  if(ASPx.ElementHasCssClass(windowElement, PopupControlCssClasses.MainDivLiteCssClass))
   return windowElement;
  else
   return ASPx.GetNodeByClassName(windowElement, PopupControlCssClasses.MainDivLiteCssClass);
 },
 GetWindowContentIFrameElement: function(index) {
  return this.GetWindowChild(index, "_CIF" + index);
 },
 GetWindowContentElement: function(index) {
  return this.GetWindowChild(index, "_PWC" + index);
 },
 GetWindowContentIFrameElementId: function(index) {
  return this.name + "_CIF" + index;
 },
 GetContentContainer: function(index) {
  return this.GetWindowContentElement(index);
 },
 getTouchScrollerElement: function(index) {
  return this.GetContentContainer(index);
 },
 GetWindowHeaderElement: function(index) {
  return this.GetWindowChild(index, "_PWH" + index);
 },
 GetWindowFooterElement: function(index) {
  return this.GetWindowChild(index, "_PWF" + index);
 },
 GetWindowSizeGripElement: function(index) {
  var footer = this.GetWindowFooterElement(index);
  if(!footer)
   return null;
  var descendants = ASPx.GetNodesByClassName(footer, PopupControlCssClasses.SizeGripLiteCssClassName);
  return descendants.length > 0 ? descendants[0] : null;
 },
 GetWindowContentWrapperElement: function(index) {
  if(!ASPx.IsExistsElement(this.windowContentElements[index])) {
   var windowElem = this.GetWindowElement(index);
   var contentWrapperParent = this.GetWindowMainCell(windowElem);
   this.windowContentElements[index] = ASPx.GetChildByClassName(contentWrapperParent, PopupControlCssClasses.ContentWrapperCssClassName);
  }
  return this.windowContentElements[index];
 },
 GetWindowMainCell: function(element) {
  return this.HaveSpecialDivForAnimation() ? ASPx.GetNodeByTagName(element, "DIV", 0) : element;
 },
 GetWindowModalElement: function(index) {
  var element = this.GetWindowElement(index);
  if(!element) return;
  var modalElement = element.modalElement;
  if(!modalElement) {
   modalElement = this.FindWindowModalElement(index);
   element.modalElement = modalElement;
   if(modalElement) {
    modalElement.DXModalPopupControl = this;
    modalElement.DXModalPopupWindowIndex = index;
   }
  }
  return modalElement;
 },
 CanManipulateWithModalElement: function(index) {
  return this.WindowIsModal(index);
 },
 GetCurrentZIndex: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(element.style.zIndex != "" && element.style.zIndex != this.GetDefaultZIndexFromServer())
    return element.style.zIndex;
   return this.GetZIndex(index);
  }
 },
 GetWindowsState: function() {
  var state = "";
  if(this.HasDefaultWindow()) {
   state += this.GetWindowState(-1);
  }
  return state;
 },
 GetWindowState: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   var visibleFlag = (!this.InternalIsWindowVisible(index) || element.isHiding) ? "0" : "1";
   var isDraggedFlag = this.GetIsDragged(index) ? "1" : "0";
   var zIndex = this.GetCurrentZIndex(index);
   var isResized = this.GetIsResized(index);
   var isResizedFlag = isResized ? "1" : "0";
   var width = null, height=null;
   if(isResized) {
    width = this.GetWindowWidthInternal(index);
    height = this.GetIsCollapsed(index) ? this.GetWindowDimensionByIndex(index, false, true) : this.GetWindowHeightInternal(index);
   } else {
    width = ASPx.InvalidDimension;
    height = ASPx.InvalidDimension;
   }
   var contentWasLoaded = element.loaded ? "1" : "0";
   var left, top;
   var isMaximized = this.GetIsMaximized(index);
   if(isMaximized && !this.MaximizationExecuting()) {
    var restoredWindowData = this.GetRestoredWindowData(index);
    left = restoredWindowData.left;
    top = restoredWindowData.top;
   } else {
    left = this.GetCurrentLeft(index);
    top = this.GetCurrentTop(index);
   }
   var isPinned = this.GetIsPinned(index);
   if(isPinned) {
    left -= ASPx.GetDocumentScrollLeft();
    top -= ASPx.GetDocumentScrollTop();
   }
   left = Math.ceil(left);
   top = Math.ceil(top);
   var pinFlag = isPinned ? "1" : "0";
   var minFlag = this.GetIsCollapsed(index) ? "1" : "0";
   var maxFlag = isMaximized || this.GetIsMaximizedInit(index) ? "1" : "0";
   return [visibleFlag, isDraggedFlag, zIndex, left, top, isResizedFlag, width, height, contentWasLoaded, pinFlag, minFlag, maxFlag].join(":");
  }
  return "";
 },
 UpdateStateObject: function(){
  this.UpdateStateObjectWithObject({ windowsState: this.GetWindowsState() });
 },
 GetStateHiddenFieldOrigin: function() {
  return this.GetWindowElement(this.GetWindowCountCore() - 1);
 },
 GetPopupType: function() {
  return "aspxpopup";
 },
 GetDefaultZIndexFromServer: function() {
  return defaultZIndexFromServer;
 },
 GetPopupControlZIndex: function() {
  return popupControlZIndex;
 },
 FindWindowModalElement: function(index) {
  return ASPx.GetElementById(this.name + "_DXPWMB" + index);
 },
 GetWindowCloseButton: function(index) {
  return ASPx.GetElementById(this.name + "_HCB" + index);
 },
 GetWindowRefreshButton: function(index) {
  return ASPx.GetElementById(this.name + "_HRB" + index);
 },
 FirstShowWindow: function(index, allowChangeZIndex) {
  var popupHorizontalOffsetBackup = -1;
  var popupVerticalOffsetBackup = -1;
  var isFreeWindow = this.GetIsDragged(index);
  var x = ASPx.InvalidPosition;
  var y = ASPx.InvalidPosition;
  if(isFreeWindow) {
   x = this.GetWindowLeft(index);
   y = this.GetWindowTop(index);
   popupHorizontalOffsetBackup = this.popupHorizontalOffset;
   popupVerticalOffsetBackup = this.popupVerticalOffset;
   this.popupHorizontalOffset = 0;
   this.popupVerticalOffset = 0;
  }
  this.LockAnimation();
  this.DoShowWindowCore(index, x, y, isFreeWindow ? -1 : 0, false, allowChangeZIndex);
  this.UnlockAnimation();
  if(isFreeWindow) {
   this.popupHorizontalOffset = popupHorizontalOffsetBackup;
   this.popupVerticalOffset = popupVerticalOffsetBackup;
  }
  this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index));
  this.CorrectFooterTextElementWidth(index);
 },
 HasDefaultWindow: function() {
  return true;
 },
 GetWindowCount: function() {
  return 0;
 },
 GetWindowContentHtml: function(window) {
  var index = (window != null) ? window.index : -1;
  var element = this.GetContentContainer(index);
  return (element != null) ? element.innerHTML : "";
 },
 GetWindowElementId: function(index) {
  return this.name + ASPx.PCWIdSuffix + index;
 },
 GetWindowElement: function(index) {
  if(!ASPx.IsExistsElement(this.windowElements[index]))
   this.windowElements[index] = ASPx.GetElementById(this.GetWindowElementId(index));
  return this.windowElements[index];
 },
 GetWindowClientTable: function(index) {
  return this.GetWindowElement(index);
 },
 GetCurrentWindowElement: function() {
  return this.GetWindowElement(-1);
 },
 getActualMainElement: function() { return this.GetCurrentWindowElement(); },
 ShowWindowContentUrl: function(index) {
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  this.LoadWindowContentUrl(index);
  if(contentIFrame && contentIFrame.DXReloadAfterShowRequired) {
   this.RefreshWindowContentUrl(this.GetWindow(index));
   contentIFrame.DXReloadAfterShowRequired = false;
  }
 },
 RefreshWindowContentUrl: function(window) {
  var index = (window != null) ? window.index : -1;
  if(ASPx.Browser.IE)
   this.RefreshWindowContentUrlIE(index, window);
  else
   this.RefreshWindowContentUrlCommon(window);
 },
 RefreshContentUrl: function() {
  this.RefreshWindowContentUrl(null);
 },
 RefreshWindowContentUrlIE: function(index, window) {
  var windowVisible = this.InternalIsWindowVisible(index);
  if(windowVisible)
   this.RefreshWindowContentUrlIECore(index, window);
  else {
   var iframe = this.GetWindowContentIFrameElement(index);
   if(iframe)
    iframe.DXReloadAfterShowRequired = true;
  }
 },
 RefreshWindowContentUrlIECore: function(index, window) {
  try {
   if(!this.GetIframeLoading(index)) {
    var iframe = this.GetWindowContentIFrameElement(index);
    if(iframe)
     iframe.contentWindow.location.reload();
   }
  } catch (e) {
   this.RefreshWindowContentUrlCommon(window);
  }
 },
 RefreshWindowContentUrlCommon: function(window) {
  this.SetWindowContentUrl(window, this.GetWindowContentUrl(window));
 },
 GetContentUrl: function() {
  return this.GetWindowContentUrl(null);
 },
 GetWindowContentUrl: function(window) {
  var index = (window != null) ? window.index : -1;
  if(!this.IsWindowVisible(window))
   return this.GetWindowContentIFrameUrl(index);
  var element = this.GetWindowContentIFrameElement(index);
  return (element != null) ? element.src : "";
 },
 GetContentIFrame: function(window) {
  return this.GetWindowContentIFrame(null);
 },
 GetWindowContentIFrame: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowContentIFrameElement(index);
 },
 GetContentIFrameWindow: function() {
  var iframeElement = this.GetContentIFrame();
  return iframeElement.contentWindow;
 },
 SetContentUrl: function(url) {
  this.SetWindowContentUrl(null, url);
 },
 SetWindowContentUrl: function(window, url) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowContentUrlInternal(index, url);
 },
 LoadWindowContentUrl: function(index) {
  var url = this.GetWindowContentIFrameUrl(index);
  this.LoadWindowContentFromUrl(index, url);
 },
 LoadWindowContentFromUrl: function(index, url) {
  var element = this.GetWindowContentIFrameElement(index);
  if(element && element.src != url && element.DXSrcRaw != url) {
   this.SetSrcToIframeElement(index, element, url);
   this.SetWindowContentIFrameUrl(index, element.src); 
  }
 },
 SetWindowContentIFrameUrl: function(index, url) {
  this.SetPropertyValue(index, "contentUrl", url);
 },
 SetWindowContentUrlInternal: function(index, url) {
  var element = this.GetWindowContentIFrameElement(index);
  var windowVisible = this.InternalIsWindowVisible(index);
  if(windowVisible && element != null)
   this.SetIframeVisibleForDragging(index, true);
  this.SetWindowContentIFrameUrl(index, url);
  var src = windowVisible ? url : ASPx.Browser.WebKitFamily && ASPx.Browser.Version >= 75 ? "about:blank" : ASPx.SSLSecureBlankUrl;
  if(element == null) {
   this.CreateWindowContentIFrameElement(index, src);
   this.RefreshDimensionsAfterCreateIframe(index);
  }
  else
   this.SetSrcToIframeElement(index, element, src);
  this.ReinitScrollForIframe(index);
 },
 ReinitScrollForIframe: function(index) {
  if(this.HasIframeOnIos(index)) {
   var scrollElement = this.getTouchScrollerElement(index);
   if(scrollElement) {
    var options = this.GetWindowTouchScrollOptions(index);
    ASPx.TouchUIHelper.InitNativeScrolling(scrollElement, options);
    if(!!this.touchUIScrollers[index]) {
     this.touchUIScrollers[index].Destroy();
     this.touchUIScrollers[index] = null;
    }
   }
  }
 },
 EnsureWindowContentUrl: function(index) {
  var contentUrl = this.GetWindowContentIFrameUrl(index);
  if(contentUrl != "")
   this.SetWindowContentUrlInternal(index, contentUrl);
 },
 CreateWindowContentIFrameElement: function(index, src) {
  var content = this.GetContentContainer(index);
  var iframeParent = content;
  content.innerHTML = "";
  content.style.display = "block";
  var iframe = this.CreateContentIFrameElement(index, src);
  this.RequireIFrameHeightAdjusting(index, iframe);
  iframeParent.appendChild(iframe);
  this.InitIFrame(index);
  return iframe;
 },
 InitIFrame: function(index) {
  var contentIFrameElement = this.GetWindowContentIFrameElement(index);
  if(contentIFrameElement) {
   contentIFrameElement.popupControlName = this.name;
   contentIFrameElement.pcWndIndex = index;
   ASPx.Evt.AttachEventToElement(contentIFrameElement, "load", ASPx.PCIframeLoad);
  }
 },
 OnIFrameLoad: function(index) {
  this.SetIframeLoading(index, false);
 },
 RequireIFrameHeightAdjusting: function(index, iframe) {
  if(this.InternalIsWindowVisible(index))
   this.AdjustIFrameHeight(index, iframe);
  else
   this.PostponeIframeAdjusting(index);
 },
 PostponeIframeAdjusting: function(index) {
  this.SetIframeAdjustingPostponed(index, true);
 },
 EnsureIFrameHeightAdjusted: function(index) {
  if(this.GetIframeAdjustingPostponed(index)) {
   var iframe = this.GetWindowContentIFrameElement(index);
   this.AdjustIFrameHeight(index, iframe);
  }
 },
 AdjustIFrameHeight: function(index, iframe) {
 },
 CreateContentIFrameElement: function(index, src) {
  var iframe = document.createElement("IFRAME");
  iframe.id = this.GetWindowContentIFrameElementId(index);
  iframe.scrolling = "auto";
  iframe.frameBorder = 0;
  iframe.style.width = "100%";
  iframe.style.height = "100%";
  iframe.style.overflow = "auto";
  if(ASPx.Browser.Chrome) iframe.style.webkitBackfaceVisibility = "hidden";
  if(ASPx.Browser.IE || ASPx.Browser.Edge)
   iframe.style["-ms-user-select"] = "text";
  var titleText = this.GetWindowContentIFrameTitle(index);
  if(!!titleText)
   iframe.title = titleText;
  this.SetSrcToIframeElement(index, iframe, src);
  return iframe;
 },
 SetSrcToIframeElement: function(index, iframeElement, src) {
  this.SetIframeLoading(index, true);
  iframeElement.src = src;
  if(ASPx.Browser.Chrome && src.indexOf("#"))
   this.PreventScrollingAfterIframeLoaded(iframeElement);
  iframeElement.DXSrcRaw = src;
 },
 PreventScrollingAfterIframeLoaded: function(iframeElement) {
  var docScrollTop = ASPx.GetDocumentScrollTop();
  var onIframeLoadedHandler = function() {
   window.setTimeout(function() {
    ASPx.SetDocumentScrollTop(docScrollTop);
    ASPx.Evt.DetachEventFromElement(iframeElement, "load", onIframeLoadedHandler);
   }, 0);
  };
  ASPx.Evt.AttachEventToElement(iframeElement, "load", onIframeLoadedHandler);
 },
 GetWindowHeaderTextCell: function(index) {
  return this.GetWindowChild(index, "_PWH" + index + "T");
 },
 GetWindowHeaderTextElement: function(index) {
  var element = this.GetWindowHeaderTextCell(index);
  if(element != null) {
   var link = ASPx.GetNodeByTagName(element, "A", 0);
   return link || element;
  }
  return null;
 },
 GetWindowHeaderLinkElement: function(index) {
  var element = this.GetWindowHeaderElement(index);
  return element ? ASPx.GetNodeByClassName(element, PopupControlCssClasses.LinkCssClassName) : null;
 },
 GetWindowHeaderImageCell: function(index) {
  return this.GetWindowChild(index, "_PWH" + index + "I");
 },
 GetWindowFooterTextCell: function(index) {
  return this.GetWindowChild(index, "_PWF" + index + "T");
 },
 GetWindowFooterTextElement: function(index) {
  var element = this.GetWindowFooterTextCell(index);
  if(element != null) {
   var link = ASPx.GetNodeByTagName(element, "A", 0);
   return link || element;
  }
  return null;
 },
 GetWindowFooterLinkElement: function(index) {
  var element = this.GetWindowFooterElement(index);
  return element ? ASPx.GetNodeByClassName(element, PopupControlCssClasses.LinkCssClassName) : null;
 },
 GetWindowFooterImageCell: function(index) {
  return this.GetWindowChild(index, "_PWF" + index + "I");
 },
 GetWindowHeaderImageUrl: function(index) {
  var element = this.GetWindowHeaderImageCell(index);
  return element ? element.src : "";
 },
 SetWindowHeaderImageUrl: function(index, url) {
  var element = this.GetWindowHeaderImageCell(index);
  if(element != null) {
   element.src = url;
  }
 },
 GetWindowFooterImageUrl: function(index) {
  var element = this.GetWindowFooterImageCell(index);
  return element ? element.src : "";
 },
 SetWindowFooterImageUrl: function(index, url) {
  var element = this.GetWindowFooterImageCell(index);
  if(element != null) {
   element.src = url;
  }
 },
 GetWindowHeaderNavigateUrl: function(index) {
  var link = this.GetWindowHeaderLinkElement(index);
  if(link)
   return link.href || ASPx.Attr.GetAttribute(linkEl, "savedhref");
  return "";
 },
 SetWindowHeaderNavigateUrl: function(index, url) {
  var link = this.GetWindowHeaderLinkElement(index);
  if(link) {
   if(ASPx.Attr.IsExistsAttribute(link, "savedhref"))
    ASPx.Attr.SetAttribute(link, "savedhref", url);
   else if(ASPx.Attr.IsExistsAttribute(link, "href"))
    link.href = url;
  }
 },
 GetWindowFooterNavigateUrl: function(index) {
  var link = this.GetWindowFooterLinkElement(index);
  if(link)
   return link.href || ASPx.Attr.GetAttribute(linkEl, "savedhref");
  return "";
 },
 SetWindowFooterNavigateUrl: function(index, url) {
  var link = this.GetWindowFooterLinkElement(index);
  if(link) {
   if(ASPx.Attr.IsExistsAttribute(link, "savedhref"))
    ASPx.Attr.SetAttribute(link, "savedhref", url);
   else if (ASPx.Attr.IsExistsAttribute(link, "href"))
    link.href = url;
  }
 },
 GetWindowHeaderText: function(index) {
  var element = this.GetWindowHeaderTextElement(index);
  if(element != null) 
    return element.innerHTML;
  return "";
 },
 SetWindowHeaderText: function(index, text) {
  var element = this.GetWindowHeaderTextElement(index);
  if(element != null) {
   element.innerHTML = text;
   this.CorrectHeaderContentElementHeight(index);
   this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index), true);
  }
 },
 GetWindowFooterText: function(index) {
  var element = this.GetWindowFooterTextElement(index);
  if(element != null) 
   return element.innerHTML;
  return "";
 },
 SetWindowFooterText: function(index, text) {
  var element = this.GetWindowFooterTextElement(index);
  if(element != null) {
   element.innerHTML = text;
   this.CorrectWindowSizeGripPositionLite(index);
  }
 },
 CorrectWindowSizeGripPositionLite: function(index) {
  var sizeGrip = this.GetWindowSizeGripElement(index);
  if(!sizeGrip || sizeGrip.corrected) return;
  sizeGrip.style[this.rtl ? "marginRight" : "marginLeft"] = "-" + sizeGrip.offsetWidth + "px";
  sizeGrip.style.marginTop = "-" + sizeGrip.offsetHeight + "px";
  sizeGrip.corrected = true;
 },
 GetHeaderFooterHeightCore: function(index) {
  var extenders = [
   this.GetWindowHeaderElement(index),
   this.GetWindowFooterElement(index)
  ], height = 0;
  for(var i = 0; i < extenders.length; i++) {
   if(extenders[i])
    height += extenders[i].offsetHeight;
  }
  return height;
 },
 GetHeaderImageUrl: function() {
  return this.GetWindowHeaderImageUrl(-1);
 },
 SetHeaderImageUrl: function(value) {
  this.SetWindowHeaderImageUrl(-1, value);
 },
 GetFooterImageUrl: function() {
  return this.GetWindowFooterImageUrl(-1);
 },
 SetFooterImageUrl: function(value) {
  this.SetWindowFooterImageUrl(-1, value);
 },
 GetHeaderNavigateUrl: function() {
  return this.GetWindowHeaderNavigateUrl(-1);
 },
 SetHeaderNavigateUrl: function(value) {
  this.SetWindowHeaderNavigateUrl(-1, value);
 },
 GetFooterNavigateUrl: function() {
  return this.GetWindowFooterNavigateUrl(-1);
 },
 SetFooterNavigateUrl: function(value) {
  this.SetWindowFooterNavigateUrl(-1, value);
 },
 GetHeaderText: function() {
  return this.GetWindowHeaderText(-1);
 },
 SetHeaderText: function(value) {
  this.SetWindowHeaderText(-1, value);
 },
 GetFooterText: function() {
  return this.GetWindowFooterText(-1);
 },
 SetFooterText: function(value) {
  this.SetWindowFooterText(-1, value);
 },
 GetVisible: function() {
  return this.IsVisible();
 },
 SetVisible: function(visible) {
  if(visible && !this.IsVisible())
   this.Show();
  else if(!visible && this.IsVisible())
   this.Hide();
 },
 GetStateHiddenFieldName: function() {
  return this.uniqueID + "State";
 },
 GetWindowCountCore: function() {
  return 0; 
 },
 IsWindowElementsIDAssigned: function(index) {
  var contentElement = this.GetWindowContentElement(index);
  return ASPx.IsExistsElement(contentElement);
 },
 InitializeDOM: function () {
  var windowElement = this.GetWindowElement(this.GetWindowCountCore() - 1);
  if(windowElement)
   windowElement.dxinit = true;
 },
 IsDOMInitialized: function() {
  var windowElement = this.GetWindowElement(this.GetWindowCountCore() - 1);
  return windowElement && windowElement.dxinit;
 },
 IsDOMDisposed: function() { 
  var windowElement = this.GetWindowElement(this.GetWindowCountCore() - 1);
  return !ASPx.IsExistsElement(windowElement);
 },
 OnDispose: function() {
  ASPxClientControl.prototype.OnDispose.call(this);
  this.ClearPopupElementConnection();
 },
 RegisterInControlTree: function(tree) {
  var mainNode = tree.createNode(null, this);
  if(this.HasDefaultWindow())
   this.RegisterRelatedNodeForWindowElement(tree, -1, mainNode);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.RegisterRelatedNodeForWindowElement(tree, i, mainNode);
 },
 RegisterRelatedNodeForWindowElement: function(tree, windowElementIndex, mainNode) {
  var windowElement = this.GetWindowElement(windowElementIndex);
  if(windowElement) {
   var childNode = tree.createNode(windowElement.id, null);
   tree.addRelatedNode(mainNode, childNode);
  }
 },
 CorrectWindowHeaderText: function(index) {
  var headerElement = this.GetWindowHeaderElement(index);
  if(!headerElement || headerElement.corrected) return;
  var leftChildrenWidth = 0, rightChildrenWidth = 0, headerContentElement;
  for(var i = 0; i < headerElement.childNodes.length; i++) {
   var child = headerElement.childNodes[i];
   if(!child.offsetWidth) continue;
   if(ASPx.GetElementFloat(child) === "right")
    rightChildrenWidth += child.offsetWidth + ASPx.GetLeftRightMargins(child);
   else if(ASPx.GetElementFloat(child) === "left")
    leftChildrenWidth += child.offsetWidth + ASPx.GetLeftRightMargins(child);
   else if(!headerContentElement)
    headerContentElement = child;
  }
  if(headerContentElement && (leftChildrenWidth > 0 || rightChildrenWidth > 0)) {
   var headerContentElementStyle = ASPx.GetCurrentStyle(headerContentElement);
   var originalMarginLeft = parseInt(headerContentElementStyle.marginLeft);
   var originalMarginRight = parseInt(headerContentElementStyle.marginRight);
   ASPx.SetStyles(headerContentElement, {
    marginLeft: leftChildrenWidth + originalMarginLeft,
    marginRight: rightChildrenWidth + originalMarginRight
   });
   this.CorrectHeaderContentElementHeight(index);
  }
  headerElement.corrected = true;
 },
 CorrectHeaderContentElementHeight: function(index) {
  var headerElement = this.GetWindowHeaderElement(index),
   headerContentElement = ASPx.GetChildByClassName(headerElement, PopupControlCssClasses.HeaderContentCssClassName);
  if(!headerElement || !headerContentElement) return;
  if(headerContentElement.style.height)
   headerContentElement.style.height = "";
  var contentElementHeight = ASPx.GetClearClientHeight(headerElement) - this.getTopBottomBordersAndPaddingsSummaryValue(headerContentElement),
   lineHeightForTextVerticalAlign = contentElementHeight,
   windowHeaderTextCell = this.GetWindowHeaderTextCell(index);
  if(windowHeaderTextCell)
   lineHeightForTextVerticalAlign -= this.getTopBottomBordersAndPaddingsSummaryValue(windowHeaderTextCell);
  ASPx.SetStyles(headerContentElement, { lineHeight: lineHeightForTextVerticalAlign, height: contentElementHeight }, false);
 },
 CorrectFooterTextElementWidth: function(index) {
  var footerElement = this.GetWindowFooterElement(index);
  var footerContentElement = ASPx.GetChildByClassName(footerElement, PopupControlCssClasses.FooterContentCssClassName);
  var footerTextElement = this.GetWindowFooterTextElement(index);
  var footerImageElement = this.GetWindowFooterImageCell(index);
  if(!footerElement || !footerContentElement || !footerTextElement)
   return;
  var footerTextMaxWidth = "";
  if(footerImageElement) {
   var footerTextMaxWidthCorrection = footerImageElement.offsetWidth + ASPx.GetLeftRightMargins(footerImageElement);
   footerTextMaxWidth = "calc(100% - " + footerTextMaxWidthCorrection + "px)";
  }
  ASPx.SetStyles(footerTextElement, { maxWidth: footerTextMaxWidth }, false);
 },
 OnBeforeDropdownShow: function() {
  var element = this.GetWindowElement(-1);
  if(!ASPx.GetElementDisplay(element)) {
   element.style.visibility = "hidden";
  }
  this.SetWindowDisplay(-1, true);
  if(this.adaptivityEnabled) {
   ASPx.SetElementDisplay(this.GetModalWrapperElement(-1), true);
   this.SetAdaptiveModalMode(-1, this.NeedAdaptiveModalMode());
  }
 },
 SetWindowDisplay: function(index, value) {
  var pcwElement = this.GetWindowElement(index);
  ASPx.SetElementDisplay(pcwElement, value);
 },
 getWindowHorizontalAlign: function(element) {
  return this.popupHorizontalAlign;
 },
 getWindowVerticalAlign: function(element) {
  return this.popupVerticalAlign;
 },
 getWindowHorizontalOffset: function(element) {
  return this.popupHorizontalOffset;
 },
 getWindowVerticalOffset: function(element) {
  return this.popupVerticalOffset;
 },
 GetHorizontalAlign: function() {
  return this.popupHorizontalAlign;
 },
 GetVerticalAlign: function() {
  return this.popupVerticalAlign;
 },
 GetPopupHorizontalOffset: function() {
  return this.popupHorizontalOffset;
 },
 SetPopupHorizontalOffset: function(offset) {
  this.popupHorizontalOffset = offset;
 },
 SetPopupVerticalOffset: function(offset) {
  this.popupVerticalOffset = offset;
 },
 GetPopupVerticalOffset: function() {
  return this.popupVerticalOffset;
 },
 ShowAtElement: function(htmlElement, savePopupElement) {
  this.ShowWindowAtElementByIndex(-1, htmlElement, savePopupElement);
 },
 ShowAtElementByID: function(id) {
  var htmlElement = document.getElementById(id);
  this.ShowAtElement(htmlElement);
 },
 ShowWindowAtElementByIndex: function(index, htmlElement, savePopupElement) {
  var lastIndexBackup = this.GetLastShownPopupElementIndex(index);
  this.ShowWindowByIndex(index, this.AddPopupElementInternal(index, htmlElement));
  if(!savePopupElement)
   this.RemovePopupElementInternal(index, htmlElement);
  this.SetLastShownPopupElementIndex(index, lastIndexBackup);
 },
 ShowWindowByIndex: function(index, popupElementIndex) {
  if(!this.isInitialized)
   return;
  if(popupElementIndex === undefined)
   popupElementIndex = this.GetLastShownPopupElementIndex(index);
  this.DoShowWindowCore(index, ASPx.InvalidPosition, ASPx.InvalidPosition, popupElementIndex, false, true);
 },
 DoShowWindowCore: function(index, x, y, popupElementIndex, closeOtherWindows, allowChangeZIndex, evt, closeOtherReason) {
 },
 DoShowWindow: function(index, popupElementIndex, evt) {
  if(!this.InternalIsWindowVisible(index)) {
   var x = ASPx.Evt.GetEventX(evt);
   var y = ASPx.Evt.GetEventY(evt);
   this.DoShowWindowCore(index, x, y, popupElementIndex, true, true, evt, ASPxClientPopupControlCloseReason.OuterMouseClick);
  }
 },
 SetWindowPos: function(index, element, x, y) {
  ASPx.SetStyles(element, { left: x, top: y });
  this.DoShowWindowIFrame(index, x, y, ASPx.InvalidDimension, ASPx.InvalidDimension);
  this.SetIsDragged(index, true);
  this.SetWindowLeft(index, ASPx.GetAbsoluteX(element));
  this.SetWindowTop(index, ASPx.GetAbsoluteY(element));
  this.UpdateWindowsStateCookie();
 },
 CorrectPopupPositionForClientWindow: function(element, popupPosition, isX) {
  if(element.isPopupPositionCorrectionOn && this.isPopupFullCorrectionOn || this.forceAdjustPositionToClientScreen) {
   popupPosition.position = ASPx.PopupUtils.AdjustPositionToClientScreen(element, popupPosition.position, this.rtl, isX);
  }
  return popupPosition;
 },
 GetClientPopupPos: function(element, popupElement, pos, isX, isDragged) {
  var index = this.GetWindowIndex(element);
  var popupPosition = null;
  if(this.GetIsMaximizedOnWebKitTouch(index))
   return new ASPx.PopupPosition(ASPx.PrepareClientPosForElement(0, element, isX), false);
  if(isDragged)
   popupPosition = new ASPx.PopupPosition(!this.IsValidPosition(pos) ? this.GetPosition(index, isX) : pos, false);
  else
   popupPosition = isX ? this.GetClientPopupPosX(element, popupElement, pos) : this.GetClientPopupPosY(element, popupElement, pos);
  popupPosition.position = ASPx.PrepareClientPosForElement(popupPosition.position, element, isX);
  if(ASPx.Browser.Firefox && ASPx.Browser.Version < 3 && this.GetWindowModalElement(index))
   popupPosition.position -= isX ? ASPx.GetDocumentScrollLeft() : ASPx.GetDocumentScrollTop();
  return popupPosition;
 },
 GetClientPopupPosX: function(element, popupElement, x) {
  var mainElement = this.GetWindowMainCell(element);
  var popupPosition = ASPx.PopupUtils.GetPopupAbsoluteX(mainElement, popupElement, this.getWindowHorizontalAlign(element), this.getWindowHorizontalOffset(element),
   x, this.GetWindowLeft(this.GetWindowIndex(element)), this.rtl, this.isPopupFullCorrectionOn);
  return this.CorrectPopupPositionForClientWindow(element, popupPosition, true);
 },
 GetClientPopupPosY: function(element, popupElement, y) {
  var mainElement = this.GetWindowMainCell(element);
  var popupPosition = ASPx.PopupUtils.GetPopupAbsoluteY(mainElement, popupElement, this.getWindowVerticalAlign(element), this.getWindowVerticalOffset(element),
   y, this.GetWindowTop(this.GetWindowIndex(element)), this.isPopupFullCorrectionOn, this.usedInDropDown, this.usedInDropDown);
  return this.usedInDropDown ? popupPosition : this.CorrectPopupPositionForClientWindow(element, popupPosition, false);
 },
 UpdateWindowPositionInternal: function(index, popupElement) {
  var positionUpdated = false,
   element = this.GetWindowElement(index);
  if(this.InternalIsWindowVisible(index) && element != null) {
   var horizontalPopupPosition;
   if(this.popupHorizontalAlign === ASPx.PopupUtils.WindowCenterAlignIndicator && window.innerWidth <= element.offsetWidth) {
    var scrollDiff = aspxGetPopupControlCollection().GetDocScrollDifference(),
     scrollInProgress = scrollDiff.horizontal !== 0 || scrollDiff.vertical !== 0;
    horizontalPopupPosition = scrollInProgress ? ASPx.PxToInt(element.style.left) : this.GetClientPopupPos(element, popupElement, ASPx.InvalidPosition, true, false);
   } else
    horizontalPopupPosition = this.GetClientPopupPos(element, popupElement, ASPx.InvalidPosition, true, false);
   var verticalPopupPosition = this.GetClientPopupPos(element, popupElement, ASPx.InvalidPosition, false, false);
   this.SetWindowPos(index, element, horizontalPopupPosition.position, verticalPopupPosition.position);
   positionUpdated = true;
  }
  return positionUpdated;
 },
 UpdatePositionAtElement: function(popupElement) {
  this.UpdateWindowPositionAtElement(null, popupElement);
 },
 UpdateWindowPositionAtElement: function(window, popupElement) {
  var index = (window != null) ? window.index : -1;
  this.UpdateWindowPositionInternal(index, popupElement);
 },
 TryAutoUpdatePosition: function(index) {
  if(this.GetAutoUpdatePosition(index))
   this.UpdateWindowPositionInternal(index, this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index)));
 },
 GetLastShownPopupElementIndex: function(windowIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  return ASPx.GetDefinedValue(info.shownPEIndex, 0);
 },
 SetLastShownPopupElementIndex: function(windowIndex, popupElementIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  info.shownPEIndex = popupElementIndex;
 },
 GetLastUsedPopupElementInfo: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsLastUsedPopupElementInfoList[index];
  return this.defaultLastUsedPopupElementInfo;
 },
 GetPopupElement: function(index, popupElementIndex) {
  var popupElement = this.GetPopupElementList(index)[popupElementIndex];
  return popupElement ? popupElement : null;
 },
 GetPopupElementList: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupElementList[index];
  return this.defaultWindowPopupElementList;
 },
 PopulatePopupElementsByIds: function(index) {
  var ids = this.GetPopupElementIDList(index);
  for(var i = 0; i < ids.length; i++) {
   var popupElement = ASPx.PopupUtils.FindPopupElementById(ids[i]);
   if(popupElement)
    this.AddWindowPopupElement(index, popupElement);
  }
 },
 PopulatePopupElements: function(index) {
  this.PopulatePopupElementsByIds(index);
 },
 SetPopupElementIDByIndex: function(index, popupElementId) {
  this.RemoveWindowAllPopupElements(index);
  this.SetPopupElementIDs(index, popupElementId.split(';'));
  if(aspxGetPopupControlCollection().IsDisappearTimerActive()) {
   aspxGetPopupControlCollection().ClearDisappearTimer();
   this.Hide(index);
  }
  this.PopulatePopupElements(index);
 },
 RefreshPopupElementConnection: function() {
  this.ClearPopupElementConnection();
  var index = this.HasDefaultWindow() ? -1 : 0;
  for(; index < this.GetWindowCount(); index++)
   this.PopulatePopupElements(index);
 },
 ClearPopupElementConnection: function() {
  var index = this.HasDefaultWindow() ? -1 : 0;
  for(; index < this.GetWindowCount(); index++)
   this.RemoveWindowAllPopupElements(index);
 },
 GetPopupElementIDList: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupElementIDList[index];
  return this.defaultWindowPopupElementIDList;
 },
 SetPopupElementIDs: function(index, ids) {
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsPopupElementIDList[index] = ids;
  this.defaultWindowPopupElementIDList = ids;
 },
 AddPopupElementInternal: function(index, element) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++) {
   if(!popupElements[i]) {
    popupElements[i] = element;
    return i;
   }
  }
  popupElements.push(element);
  return popupElements.length - 1;
 },
 RemovePopupElementInternal: function(index, element) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++) {
   if(popupElements[i] == element) {
    popupElements[i] = null;
    return;
   }
  }
 },
 AddPopupElement: function(popupElement) {
  this.AddWindowPopupElement(-1, popupElement);
 },
 AddWindowPopupElement: function(index, popupElement) {
  var popupElementIndex = this.AddPopupElementInternal(index, popupElement);
  this.SetPopupElementReference(index, popupElement, popupElementIndex, true);
 },
 RemovePopupElement: function(popupElement) {
  this.RemoveWindowPopupElement(-1, popupElement);
 },
 RemoveWindowPopupElement: function(index, popupElement) {
  this.RemovePopupElementInternal(index, popupElement);
  this.SetPopupElementReference(index, popupElement, null, false);
 },
 SetPopupElementReference: function(index, popupElement, popupElementIndex, attach) {
  if(!ASPx.IsExistsElement(popupElement)) return;
  var setReferenceFunction = this.getAttachReferenceFunction(attach);
  var setContextMenuReferenceFunction = attach ? ASPx.Evt.AttachContextMenuToElement : ASPx.Evt.DetachContextMenuFromElement;
  var windowPopupAction = this.GetWindowPopupAction(index);
  if(windowPopupAction == "LeftMouseClick")
   setReferenceFunction(popupElement, "mouseup", aspxPEMEvent);
  else if(windowPopupAction == "RightMouseClick")
   setContextMenuReferenceFunction(popupElement, aspxPEMEvent);
  else if(windowPopupAction == "MouseOver") {
   var windowElement = this.GetWindowElement(index);
   setReferenceFunction(popupElement, "mouseover", ASPx.PopupUtils.OverControl.OnMouseOver);
   setReferenceFunction(windowElement, "mouseover", aspxPWEMOver);
   if(attach)
    this.SetMSTouchMouseOverReference(popupElement, windowElement, this.name, index, this.appearAfter);
  }
  if(windowPopupAction == "LeftMouseClick" || windowPopupAction == "RightMouseClick") {
   setReferenceFunction(popupElement, "mousedown", aspxPEMEvent);
  }
  if(attach) {
   popupElement.DXPopupElementControl = this;
   popupElement.DXPopupWindowIndex = index;
   popupElement.DXPopupElementIndex = popupElementIndex;
  } else
   popupElement.DXPopupElementControl = popupElement.DXPopupWindowIndex = popupElement.DXPopupElementIndex = undefined;
 },
 getAttachReferenceFunction: function(attach) {
  return attach ? ASPx.Evt.AttachEventToElement : ASPx.Evt.DetachEventFromElement;
 },
 SetMSTouchMouseOverReference: function(popupElement, windowElement, popupName, index, appearAfter) {
  if(!ASPx.TouchUIHelper.pointerEnabled) return;
  popupElement.dxMsTouchGesture = popupElement.dxMsTouchGesture ||
   ASPx.TouchUIHelper.msTouchCreateGesturesWrapper(popupElement, function(evt) {
    window.setTimeout(function() {
     aspxGetPopupControlCollection().SetAppearTimer(popupName, index, popupElement.DXPopupElementIndex, appearAfter, evt);
    }, 0);
   });
  windowElement.dxMsTouchGesture = windowElement.dxMsTouchGesture || ASPx.TouchUIHelper.msTouchCreateGesturesWrapper(windowElement, function(evt) {
   window.setTimeout(function() {
    aspxGetPopupControlCollection().ClearDisappearTimer();
   }, 0);
  });
 },
 GetLastOverPopupElementIndex: function(windowIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  return ASPx.GetDefinedValue(info.overPEIndex, -1);
 },
 SetLastOverPopupElementIndex: function(windowIndex, popupElementIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  info.overPEIndex = popupElementIndex;
 },
 OnPopupElementMouseOver: function(evt, popupElement) {
  if(popupElement != null) {
   var index = popupElement.DXPopupWindowIndex;
   var isVisible = this.InternalIsWindowVisible(index);
   var popupElementIndex = popupElement.DXPopupElementIndex;
   if(this.GetLastOverPopupElementIndex(index) != popupElementIndex) {
    if(aspxGetPopupControlCollection().IsAppearTimerActive())
     aspxGetPopupControlCollection().ClearAppearTimer();
    if(aspxGetPopupControlCollection().IsDisappearTimerActive())
     aspxGetPopupControlCollection().ClearDisappearTimer();
    if(isVisible) {
     this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.MouseOut);
     isVisible = false;
    }
   }
   if(!isVisible) {
    aspxGetPopupControlCollection().SetAppearTimer(this.name, index, popupElement.DXPopupElementIndex, this.appearAfter, evt);
    aspxGetPopupControlCollection().InitOverObject(this, index, evt);
   }
   this.SetLastOverPopupElementIndex(index, popupElementIndex);
  }
 },
 OnPopupElementMouseOut: function(evt, popupElement) {
 },
 RemoveAllPopupElements: function() {
  this.RemoveWindowAllPopupElements(-1);
 },
 RemoveWindowAllPopupElements: function(index) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++)
   this.RemoveWindowPopupElement(index, popupElements[i]);
 },
 GetWindowCurrentPopupElementByIndex: function(index) {
  var popupElement = this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index));
  if(popupElement && popupElement.DXPopupElementControl)
   return popupElement;
  return null;
 },
 GetWindowCurrentPopupElementIndexByWindowIndex: function(windowIndex) {
  var popupElement = this.GetWindowCurrentPopupElementByIndex(windowIndex);
  return popupElement ? popupElement.DXPopupElementIndex : -1;
 },
 GetIsMaximizedOnWebKitTouch: function(index) {
  return false;
 },
 ProcessAccessibleElementOnHide: function() {
  if(this.accessibilityCompliant) {
   var focusElement = this.accessibleFocusElement ? this.accessibleFocusElement : this.GetCurrentPopupElement();
   ASPx.AccessibilityUtils.SetFocusAccessibleCore(focusElement);
   this.accessibleFocusElement = null;
  }
 },
 OnControlsInitialized: function() {
  this.InitializeAccessibleNavigationCore();
  setTimeout(function() {
   ASPx.GetControlCollection().ControlsInitialized.RemoveHandler(this.OnControlsInitialized, this);
  }.aspxBind(this), 0);
 },
 InitializeAccessibleNavigation: function() {
  this.Shown.AddHandler(this.InitializeAccessibleNavigationCore.aspxBind(this));
 },
 InitializeAccessibleNavigationCore: function() {
  this.resetFocusableElements();
  var focusableElement = this.getFirstFocusableElement();
  if(focusableElement) {
   var currentWindowContentCell = this.GetWindowContentElement(-1);
   var contentFirstActionElement = ASPx.FindFirstChildActionElement(currentWindowContentCell);
   if(contentFirstActionElement && contentFirstActionElement !== focusableElement)
    focusableElement = contentFirstActionElement;
   if(!this.preventAccessibilityFocus)
    ASPx.AccessibilityUtils.SetFocusAccessible(focusableElement);
   this.SetLoopingFocusHandlers();
  }
 },
 resetFocusableElements: function() {
  if(this.firstFocusableElement)
   ASPx.Evt.DetachEventFromElement(this.firstFocusableElement, "keydown", this.focusLastElementHandler);
  if(this.lastFocusableElement)
   ASPx.Evt.DetachEventFromElement(this.lastFocusableElement, "keydown", this.focusFirstElementHandler);
  this.firstFocusableElement = null;
  this.lastFocusableElement = null;
 },
 getFirstFocusableElement: function() {
  if(!this.firstFocusableElement)
   this.firstFocusableElement = ASPx.FindFirstChildActionElement(this.GetCurrentWindowElement());
  return this.firstFocusableElement;
 },
 getLastFocusableElement: function() {
  if(!this.lastFocusableElement)
   this.lastFocusableElement = ASPx.FindLastChildActionElement(this.GetCurrentWindowElement());
  return this.lastFocusableElement;
 },
 SetLoopingFocusHandlers: function() {
  ASPx.Evt.AttachEventToElement(this.getFirstFocusableElement(), "keydown", this.focusLastElementHandler);
  ASPx.Evt.AttachEventToElement(this.getLastFocusableElement(), "keydown", this.focusFirstElementHandler);
 },
 loopFocusHandler: function(evt, isLastFocusableElement) {
  var keyCode = ASPx.Evt.GetKeyCode(evt);
  if(keyCode !== ASPx.Key.Tab)
   return;
  var targetElement = isLastFocusableElement ? this.getLastFocusableElement() : this.getFirstFocusableElement();
  if(ASPx.Evt.GetEventSource(evt) !== targetElement)
   return;
  var elementToFocus = null;
  if(!isLastFocusableElement && evt.shiftKey)
   elementToFocus = this.getLastFocusableElement();
  else if(isLastFocusableElement && !evt.shiftKey)
   elementToFocus = this.getFirstFocusableElement();
  if(elementToFocus) {
   ASPx.AccessibilityUtils.SetFocusAccessible(elementToFocus);
   ASPx.Evt.PreventEventAndBubble(evt);
  }
 },
 getLeftRightBordersAndPaddingsSummaryValue: function(element, currentStyle) {
  return ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element, currentStyle);
 },
 getTopBottomBordersAndPaddingsSummaryValue: function(element, currentStyle) {
  return ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element, currentStyle);
 },
 AdjustModalElementBounds: function(element) {
 },
 RefreshDimensionsAfterCreateIframe: function(index) {
 },
 UpdatePositionAfterCallback: function(windowIndex) {
 }
});
ASPxClientPopupControlBase.AnimationType = {
 Fade: "fade",
 Slide: "slide",
 Auto: "auto",
 None: "none"
};
var ASPxClientPopupControl = ASPx.CreateClass(ASPxClientPopupControlBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.popupActionArray = [];
  this.windowsPopupElementIDList = [];
  this.windowsPopupElementList = [];
  this.windowsLastUsedPopupElementInfoList = [];
  this.windowsIsPopupedList = [];
  this.windowsPopupReasonMouseEventList = [];
  this.defaultPopupReasonMouseEvent = null;
  this.modal = false;
  this.modalArray = [];
  this.isDraggedArray = [];
  this.closeActionArray = [];
  this.showOnPageLoadArray = [];
  this.windows = [];
  this.windowCount = 0;
  this.closeOnEscapeArray = [];
  this.leftArray = [];
  this.contentUrlArray = [];
  this.contentUrlIFrameTitleArray = [];
  this.iframeLoadingArray = [];
  this.iframeAdjustingPostponedArray = [];
  this.isResizedArray = [];
  this.zIndexArray = [];
  this.topArray = [];
  this.shownArray = [];
  this.heightArray = [];
  this.widthArray = [];
  this.widthFromServer = false;
  this.widthFromServerArray = [];
  this.minHeightArray = [];
  this.minWidthArray = [];
  this.maxHeightArray = [];
  this.maxWidthArray = [];
  this.hideBodyScrollWhenModal = true;
  this.hideBodyScrollWhenModalArray = [];
  this.hideBodyScrollWhenMaximized = true;
  this.canScrollViewPort = false;
  this.canScrollViewPortArray = [];
  this.autoUpdatePositionArray = [];
  this.cachedSizeArray = [];
  this.enableContentScrollingArray = [];
  this.contentOverflowXArray = [];
  this.contentOverflowYArray = [];
  this.isPinned = false;
  this.isPinnedArray = [];
  this.pinX = 0;
  this.pinXArray = [];
  this.pinY = 0;
  this.pinYArray = [];
  this.lockScroll = 0;
  this.isCollapsed = false;
  this.isCollapsedArray = [];
  this.isCollapsedInit = false;
  this.isCollapsedInitArray = [];
  this.collapseExecutingLockCount = 0;
  this.isMaximized = false;
  this.isMaximizedArray = [];
  this.isMaximizedInit = false;
  this.isMaximizedInitArray = [];
  this.maximizationExecutingLockCount = 0;
  this.restoredWindowValues = {};
  this.restoredWindowValuesArray = [];
  this.browserResizingForMaxWindowLockCount = 0;
  this.updateRestoredWindowSizeLockCount = 0;
  this.touchUIScrollers = {};
  this.adaptivityEnabled = false;
  this.DefaultModalMaxWidth = 500;
  this.DefaultModalMinWidth = 0;
  this.stretchVertically = false;
  this.stretchVerticallyArray = [];
  this.fixedHeader = true;
  this.fixedHeaderArray = [];
  this.fixedFooter = true;
  this.fixedFooterArray = [];
  this.modalMinHeight = null;
  this.modalMinHeightArray = [];
  this.modalMinWidth = null;
  this.modalMinWidthArray = [];
  this.modalMaxHeight = null;
  this.modalMaxHeightArray = [];
  this.modalMaxWidth = null;
  this.modalMaxWidthArray = [];
  this.modalVerticalAlign = ModalAlign.WindowTop;
  this.modalHorizontalAlign = ModalAlign.WindowCenter;
  this.adaptiveModalMode = false;
  this.adaptiveModalModeArray = [];
  this.switchAtWindowInnerWidth = ASPx.MaxMobileWindowWidth;
  this.PinnedChanged = new ASPxClientEvent();
  this.AdaptiveModeChanged = new ASPxClientEvent();
 },
 SetData: function(data){
  if(data.windows)
   this.CreateWindows(data.windows);
 },
 InlineInitialize: function() {
  ASPxClientControl.prototype.InlineInitialize.call(this);
  this.InitializeArrayCores();
 },
 Initialize: function() {
  ASPxClientPopupControlBase.prototype.Initialize.call(this);
  aspxGetPopupControlCollection().EnsureSaveScrollState();
  if(this.HasDefaultWindow())
   this.InitializeWindow(-1);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.InitializeWindow(i);
  this.InitializeScrollbars();
 },
 InitializeEnableContentScrolling: function() {
  for(var windowIndex = 0; windowIndex < this.GetWindowCount() ; windowIndex++) {
   var contentOverflowX = this.GetWindowOverflowX(windowIndex);
   var contentOverflowY = this.GetWindowOverflowY(windowIndex);
   this.enableContentScrollingArray.push(contentOverflowX != "None" || contentOverflowY != "None");
  }
  ASPxClientPopupControlBase.prototype.InitializeEnableContentScrolling.call(this);
 },
 InitializeScrollbars: function() {
  if(!ASPx.Browser.WebKitTouchUI && !ASPx.Browser.MSTouchUI && (!ASPx.Browser.WindowsPhonePlatform || !ASPx.Browser.IE))
   return;
  this.ForEachWindow(function(windowIndex) {
   if(this.GetEnableContentScrolling(windowIndex)) {
    var scrollElement = this.getTouchScrollerElement(windowIndex);
    if(scrollElement) {
     if(ASPx.Browser.MSTouchUI)
      scrollElement.style.touchAction = "auto";
     else {
      var options = this.GetWindowTouchScrollOptions(windowIndex);
      if(!this.HasIframeOnIos(windowIndex))
       this.touchUIScrollers[windowIndex] = ASPx.TouchUIHelper.MakeScrollable(scrollElement, options);
     }
    }
   }
  }.aspxBind(this));
 },
 GetWindowTouchScrollOptions: function (index) {
  var contentOverflowX = this.GetWindowOverflowX(index),
   contentOverflowY = this.GetWindowOverflowY(index);
  return {
   showHorizontalScrollbar: contentOverflowX === "Auto" || contentOverflowX === "Scroll",
   showVerticalScrollbar: contentOverflowY === "Auto" || contentOverflowY === "Scroll"
  };
 },
 ForEachWindow: function(callback) {
  var indices = [];
  if(this.HasDefaultWindow())
   indices.push(-1);
  else {
   for(var i = 0; i < this.GetWindowCount(); i++)
    indices.push(i);
  }
  ASPx.Data.ForEach(indices, callback);
 },
 GetMainElementId: function() {
  return null;
 },
 preventParentOverlowOnIos: function(index) {
  if(!ASPx.Browser.MacOSMobilePlatform) return;
  var parent = this.getParentPopupControl(index);
  if(parent) 
   parent.popupControl.changeContentOverflow(parent.windowIndex);
 },
 restoreParentOverflowOnIos: function(index) {
  if(!ASPx.Browser.MacOSMobilePlatform) return;
  var parent = this.getParentPopupControl(index);
  if(parent) 
   parent.popupControl.restoreContentOverflow(parent.windowIndex);
 },
 changeContentOverflow: function(index) {
  var scrollerElement = this.getTouchScrollerElement(index);
  if(!scrollerElement) return;
  ASPx.Attr.ChangeStyleAttribute(scrollerElement, "overflow", "visible");
  ASPx.Attr.ChangeStyleAttribute(scrollerElement, "overflowX", "visible");
  ASPx.Attr.ChangeStyleAttribute(scrollerElement, "overflowY", "visible");
 },
 restoreContentOverflow: function(index) {
  var scrollerElement = this.getTouchScrollerElement(index);
  if(!scrollerElement) return;
  ASPx.Attr.RestoreStyleAttribute(scrollerElement, "overflow");
  ASPx.Attr.RestoreStyleAttribute(scrollerElement, "overflowX");
  ASPx.Attr.RestoreStyleAttribute(scrollerElement, "overflowY");
 },
 UpdateScrollbar: function(index) {
  var touchUIScroller = this.touchUIScrollers[index];
  if(!touchUIScroller)
   return;
  var scrollElement = this.GetContentContainer(index);
  if(scrollElement)
   touchUIScroller.ChangeElement(scrollElement);
 },
 InitializeArrayCores: function() {
  if(this.GetWindowCountCore() > 0) {
   this.InitializeWindowPopupElementList();
   this.InitializeWindowPopupElementIDList();
   this.InitializeWindowLastUsedPopupElementInfoList();
   this.InitializeArray(this.shownArray);
   this.InitializeArray(this.windowsPopupReasonMouseEventList, null);
   this.InitializeArray(this.windowsIsPopupedList, false);
   this.InitializeArray(this.contentUrlArray, "");
   this.InitializeArray(this.contentUrlIFrameTitleArray, "");
   this.InitializeArray(this.popupActionArray, this.popupAction);
   this.InitializeArray(this.closeActionArray, this.closeAction);
   this.InitializeArray(this.showOnPageLoadArray, false);
   this.InitializeArray(this.isDraggedArray, false);
   this.InitializeArray(this.isPinnedArray, false);
   this.InitializeArray(this.isCollapsedArray, false);
   this.InitializeArray(this.isCollapsedInitArray, false);
   this.InitializeArray(this.isMaximizedArray, false);
   this.InitializeArray(this.isMaximizedInitArray, false);
   this.InitializeArray(this.restoredWindowValuesArray, {});
   this.InitializeArray(this.iframeAdjustingPostponedArray, {});
   this.InitializeArray(this.isResizedArray, false);
   this.InitializeArray(this.zIndexArray, -1);
   this.InitializeArray(this.leftArray, 0);
   this.InitializeArray(this.topArray, 0);
   this.InitializeArray(this.widthArray, constants.DEFAULT_WINDOW_WIDTH);
   this.InitializeArray(this.heightArray, constants.DEFAULT_WINDOW_HEIGHT);
   this.InitializeArray(this.widthFromServerArray, false);
   this.InitializeArray(this.pinXArray, 0);
   this.InitializeArray(this.pinYArray, 0);
   this.InitializeArray(this.minWidthArray, null);
   this.InitializeArray(this.minHeightArray, null);
   this.InitializeArray(this.maxWidthArray, null);
   this.InitializeArray(this.maxHeightArray, null);
   this.InitializeArray(this.cachedSizeArray, null);
   this.InitializeArray(this.iframeLoadingArray, false);
   this.InitializeArray(this.autoUpdatePositionArray, false);
   this.InitializeArray(this.hideBodyScrollWhenModalArray, true);
   this.InitializeArray(this.canScrollViewPortArray, false);
   this.InitializeArray(this.closeOnEscapeArray, this.closeOnEscape);
   this.InitializeArray(this.modalArray, false);
   this.InitializeArray(this.adaptiveModalModeArray, false);
   this.InitializeArray(this.fixedHeaderArray, true);
   this.InitializeArray(this.fixedFooterArray, true);
   this.InitializeArray(this.modalMinWidthArray, null);
   this.InitializeArray(this.modalMinHeightArray, null);
   this.InitializeArray(this.modalMaxWidthArray, null);
   this.InitializeArray(this.modalMaxHeightArray, null);
   this.InitializeArray(this.stretchVerticallyArray, false);
  }
 },
 InitializeArray: function(array, defaultValue) {
  if(array.length == 0) {
   for(var i = 0; i < this.GetWindowCountCore() ; i++)
    array[i] = defaultValue;
  }
 },
 InitializeWindowPopupElementIDList: function() {
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   if(!this.windowsPopupElementIDList[i])
    this.windowsPopupElementIDList[i] = [];
  }
 },
 InitializeWindowPopupElementList: function() {
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   if(!this.windowsPopupElementList[i])
    this.windowsPopupElementList[i] = [];
  }
 },
 InitializeWindowLastUsedPopupElementInfoList: function() {
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   if(!this.windowsLastUsedPopupElementInfoList[i])
    this.windowsLastUsedPopupElementInfoList[i] = {};
  }
 },
 AllowMouseDown: function(evt, index) {
  return ASPxClientPopupControlBase.prototype.AllowMouseDown.call(this, evt, index) &&
   !this.PreventHeaderButtonMouseDownBubbling(evt, this.GetWindowPinButton(index)) &&
   !this.PreventHeaderButtonMouseDownBubbling(evt, this.GetWindowCollapseButton(index)) &&
   !this.PreventHeaderButtonMouseDownBubbling(evt, this.GetWindowMaximizeButton(index));
 },
 AssignHeaderButtonsEvents: function(index) {
  ASPxClientPopupControlBase.prototype.AssignHeaderButtonsEvents.call(this, index);
  this.AttachClickToHeaderButton(index, this.GetWindowPinButton(index), "ASPx.PWPBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowCollapseButton(index), "ASPx.PWMNBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowMaximizeButton(index), "ASPx.PWMXBClick");
 },
 InitializeWindow: function(index) {
  ASPxClientPopupControlBase.prototype.InitializeWindow.call(this, index);
  if(this.adaptivityEnabled) {
   ASPx.Evt.AttachEventToElement(this.GetModalWrapperElement(index), "scroll", function(e) { this.OnModalWrapperScroll(e, index); }.aspxBind(this));
   if(ASPx.Browser.WebKitTouchUI) {
    ASPx.Evt.AttachEventToElement(this.GetModalWrapperElement(index), "touchstart", function(e) { this.OnModalWrapperTouchStart(e); }.aspxBind(this));
    ASPx.Evt.AttachEventToElement(this.GetModalWrapperElement(index), "touchmove", function(e) { this.OnModalWrapperTouchMove(e, index); }.aspxBind(this));
   }
  } else {
   var modalElement = this.GetWindowModalElement(index);
   if(modalElement)
    ASPx.Evt.AttachEventToElement(modalElement, "mousedown", aspxPWMEMDown);
  }
 },
 BrowserWindowResizeSubscriber: function() {
  return true;
 },
 OnBrowserWindowResize: function(e) {
  window.setTimeout(this.SetPopupMaximizedPositionOnBrowserResize.aspxBind(this), 0);
  this.ForEachWindow(this.updateContentScrollIfNeeded.aspxBind(this));
 },
 SetPopupMaximizedPositionOnBrowserResize: function() {
  this.ForEachWindow(this.SetMaximizedPositionOnBrowserResize.aspxBind(this));
 },
 UpdateResizeCursor: function(index, element, verticalDirection, horizontalDirection) {
  if(this.GetAdaptiveModalMode(index))
   this.HideTemporaryCursor(element);
  else
   ASPxClientPopupControlBase.prototype.UpdateResizeCursor.call(this, index, element, verticalDirection, horizontalDirection);
 },
 SetMaximizedPositionOnBrowserResize: function(index) {
  var element = this.GetWindowElement(index);
  if(element && this.GetIsMaximized(index) && this.InternalIsWindowVisible(index)) {
   var left = this.GetMaximizedPosition(element, true);
   var top = this.GetMaximizedPosition(element, false);
   this.SetWindowPos(index, element, left, top);
  }
 },
 InitCollapsedWindows: function(index) {
  if((this.isCollapsedInit && index == -1) || (index >= 0 && index < this.isCollapsedInitArray.length && this.isCollapsedInitArray[index])) {
   if(this.InternalIsWindowVisible(index)) {
    this.DoCollapse(index, true);
    if(index == -1)
     this.isCollapsedInit = false;
    else
     this.isCollapsedInitArray[index] = false;
   }
  }
 },
 InitMaximizedWindows: function(index) {
  if(this.GetIsMaximizedInit(index) && this.InternalIsWindowVisible(index)) {
   this.DoMaximize(index, true);
   this.SetIsMaximizedInit(index, false);
  }
 },
 InitPinnedWindows: function(index) {
  if((this.isPinned && index == -1) || (index >= 0 && index < this.isPinnedArray.length && this.isPinnedArray[index]))
   this.HoldPosition(index, true);
 },
 AfterInitializeWindow: function(index) {
  if(this.contentOverflowX !== "None" && !this.GetWindowWidthFromServer(index))
   this.SetWindowWidth(index, 0);
  ASPxClientPopupControlBase.prototype.AfterInitializeWindow.call(this, index);
  this.InitPinnedWindows(index);
  this.InitMaximizedWindows(index);
  this.InitCollapsedWindows(index);
 },
 OnDragStop: function(index) {
  ASPxClientPopupControlBase.prototype.OnDragStop.call(this, index);
  if(this.adaptivityEnabled)
   ASPxClientPopupControl.WindowResizeHelper.Initialize(this.GetWindowElement(index));
  else
   this.updateContentScrollIfNeeded(index);
 },
 GetPropertyValue: function(index, propName) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this[propName + "Array"][index];
  return ASPxClientPopupControlBase.prototype.GetPropertyValue.call(this, index, propName);
 },
 SetPropertyValue: function(index, propName, value) {
  if(0 <= index && index < this.GetWindowCountCore())
   this[propName + "Array"][index] = value;
  else
   ASPxClientPopupControlBase.prototype.SetPropertyValue.call(this, index, propName, value);
 },
 GetAdaptiveModalMode: function(index) {
  return this.GetPropertyValue(index, "adaptiveModalMode");
 },
 GetAutoUpdatePosition: function(index) {
  return this.GetPropertyValue(index, "autoUpdatePosition") && !this.GetAdaptiveModalMode(index);
 },
 SetAdaptiveModalMode: function(index, enabled) {
  ASPx.ToggleClassNameToElement(this.GetModalWrapperElement(index), this.GetModalSystemCssClass(), enabled);
  this.SetPropertyValue(index, "adaptiveModalMode", enabled);
 },
 GetIsPinned: function(index) {
  return this.GetPropertyValue(index, "isPinned");
 },
 SetIsPinned: function(index, value) {
  this.SetPropertyValue(index, "isPinned", value);
 },
 GetPinPosX: function(index) {
  return this.GetPropertyValue(index, "pinX");
 },
 SetPinPosX: function(index, pinX) {
  this.SetPropertyValue(index, "pinX", pinX);
 },
 GetPinPosY: function(index) {
  return this.GetPropertyValue(index, "pinY");
 },
 SetPinPosY: function(index, pinY) {
  this.SetPropertyValue(index, "pinY", pinY);
 },
 GetIsCollapsed: function(index) {
  return this.GetPropertyValue(index, "isCollapsed");
 },
 SetIsCollapsed: function(index, value) {
  this.SetPropertyValue(index, "isCollapsed", value);
 },
 GetIsMaximized: function(index) {
  return this.GetPropertyValue(index, "isMaximized");
 },
 GetIsMaximizedOnWebKitTouch: function(index) {
  return this.GetIsMaximized(index) && ASPx.Browser.WebKitTouchUI;
 },
 SetIsMaximized: function(index, value) {
  this.SetPropertyValue(index, "isMaximized", value);
 },
 GetIsMaximizedInit: function(index) {
  return this.GetPropertyValue(index, "isMaximizedInit");
 },
 SetIsMaximizedInit: function(index, value) {
  this.SetPropertyValue(index, "isMaximizedInit", value);
 },
 GetRestoredWindowData: function(index) {
  return ASPx.CloneObject(this.GetPropertyValue(index, "restoredWindowValues"));
 },
 GetEnableContentScrolling: function(index) {
  return this.GetPropertyValue(index, "enableContentScrolling");
 },
 GetWindowOverflowX: function(index) {
  return this.GetPropertyValue(index, "contentOverflowX");
 },
 GetWindowOverflowY: function(index) {
  return this.GetPropertyValue(index, "contentOverflowY");
 },
 SetRestoredWindowData: function(index, value) {
  this.SetPropertyValue(index, "restoredWindowValues", value);
 },
 GetWindowIsShown: function(index) {
  return this.GetPropertyValue(index, "shown");
 },
 SetWindowIsShown: function(index, shown) {
  this.SetPropertyValue(index, "shown", shown);
 },
 GetWindowWidthFromServer: function(index) {
  return this.GetPropertyValue(index, "widthFromServer");
 },
 GetHideBodyScrollWhenModal: function(index) {
  return this.GetPropertyValue(index, "hideBodyScrollWhenModal");
 },
 SetHideBodyScrollWhenModal: function(index, value) {
  this.SetPropertyValue(index, "hideBodyScrollWhenModal", value);
 },
 GetCanScrollViewPort: function(index) {
  return this.GetPropertyValue(index, "canScrollViewPort");
 },
 HasDefaultWindow: function() {
  return this.GetWindowCountCore() === 0;
 },
 GetWindowFooterHeightLite: function(index) {
  var footer = this.GetWindowFooterElement(index);
  if(footer)
   return footer.offsetHeight;
  return null;
 },
 SetWindowPopUpReasonMouseEvent: function(index, evt) {
  evt = ASPx.CloneObject(evt);
  if(evt === undefined)
   evt = null;
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsPopupReasonMouseEventList[index] = evt;
  this.defaultPopupReasonMouseEvent = evt;
 },
 GetPopUpReasonMouseEvent: function() {
  return this.GetWindowPopUpReasonMouseEvent(null);
 },
 GetWindowPopUpReasonMouseEvent: function(window) {
  var index = (window != null) ? window.index : -1;
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupReasonMouseEventList[index];
  return this.defaultPopupReasonMouseEvent;
 },
 GetWindowCountCore: function() {
  return (this.windows.length > 0) ? this.windows.length : this.windowCount;
 },
 SetClientModality: function(isModal) {
  this.SetWindowClientModality(-1, isModal);
 },
 SetWindowClientModality: function(index, isModal) {
  var modalElement = this.GetWindowModalElement(index);
  if(isModal && !ASPx.IsElementVisible(modalElement))
   this.DoShowWindowModalElement(index);
  if(!isModal && ASPx.IsElementVisible(modalElement)) {
   var element = this.GetWindowElement(index);
   this.DoHideWindowModalElement(element);
  }
 },
 GetWindowPinButton: function(index) {
  return ASPx.GetElementById(this.name + "_HPB" + index);
 },
 GetWindowCollapseButton: function(index) {
  return ASPx.GetElementById(this.name + "_HMNB" + index);
 },
 GetWindowMaximizeButton: function(index) {
  return ASPx.GetElementById(this.name + "_HMXB" + index);
 },
 GetWindowScrollDiv: function(index) {
  return this.GetWindowChild(index, "_CSD" + index);
 },
 GetWindowElementDisplayValue: function(windowHasAnyScrollbars, windowHeight) {
  return windowHasAnyScrollbars && windowHeight ? "block" : "table";
 },
 GetMainWindowWidth: function(index, noCache) {
  return this.GetClientWindowWidth(index, true, noCache);
 },
 GetClientWindowWidth: function(index, outerSize, noCache) {
  if(!noCache && (this.GetIsCollapsed(index) || this.GetIsMaximized(index))) {
   var cachedSize = this.GetWindowCachedSize(index);
   if(cachedSize != null)
    return cachedSize.width;
  }
  var element = this.GetWindowElement(index);
  if(element != null)
   return element.offsetWidth;
 },
 GetMainWindowHeight: function(index, noCache) {
  return this.GetClientWindowHeight(index, true, noCache);
 },
 GetClientWindowHeight: function(index, outerSize, noCache) {
  if(!noCache && (this.GetIsCollapsed(index) || this.GetIsMaximized(index))) {
   var cachedSize = this.GetWindowCachedSize(index);
   if(cachedSize != null)
    return cachedSize.height;
  }
  var element = this.GetWindowElement(index);
  if(element != null)
   return element.offsetHeight;
 },
 ShowModal: function() {
  this.ShowModalByIndex(-1);
 },
 ShowModalByIndex: function(index) {
  if(this.adaptivityEnabled) {
   this.SetAdaptiveModalMode(index, true);
   this.ResetModalStyles(index);
   this.ResetPopupStyles(index);
   this.DoShowModal(index, ASPx.InvalidPosition, ASPx.InvalidPosition, this.GetLastShownPopupElementIndex(index));
  }
 },
 DoShowWindowCore: function(index, x, y, popupElementIndex, closeOtherWindows, allowChangeZIndex, evt, closeOtherReason) {
  if(this.IsDOMDisposed()) return;
  this.SetWindowPopUpReasonMouseEvent(index, evt);
  if(this.adaptivityEnabled) {
   this.SetAdaptiveModalMode(index, this.NeedAdaptiveModalMode(index));
   this.ResetModalStyles(index);
   if(this.GetAdaptiveModalMode(index)) {
    this.ResetPopupStyles(index);
    this.DoShowModal(index, x, y, popupElementIndex);
    return;
   }
  }
  this.DoShowWindowAtPos(index, x, y, popupElementIndex, closeOtherWindows, allowChangeZIndex, evt, closeOtherReason);
 },
 NeedAdaptiveModalMode: function(index) {
  return window.innerWidth < this.GetSwitchAtWindowInnerWidth();
 },
 GetSwitchAtWindowInnerWidth: function() {
  return this.switchAtWindowInnerWidth;
 },
 GetModalSystemCssClass: function() {
  return "dxmodalSys";
 },
 DoShowWindowAtPos: function(index, x, y, popupElementIndex, closeOtherWindows, allowChangeZIndex, evt, closeOtherReason) {
  if(!this.isInitialized)
   this.PopulatePopupElements(index);
  var element = this.GetWindowElement(index);
  if(element != null && this.IsWindowElementsIDAssigned(index)) {
   this.StopCloseAnimation(index);
   this.PrepareToAdjustContentOnShow(index);
   if(closeOtherWindows)
    aspxGetPopupControlCollection().DoHideAllWindows(element, this.GetWindowElementId(index), false, closeOtherReason, 0);
   var isMoving = this.InternalIsWindowVisible(index);
   ASPx.SetElementDisplay(element, true);
   element.style.display = this.GetWindowElementDisplayValue(this.HasAnyScrollBars(index), this.GetPopupWindowDimensionFromCache(index, false));
   element.style.position = "absolute";
   var scrollDiv = this.GetWindowScrollDiv(index),
    shouldResetScrollSize = scrollDiv && this.GetEnableContentScrolling(index) && ASPx.GetDocumentMaxClientHeight() <= element.offsetHeight,
    savedScrollDivHeight = shouldResetScrollSize && scrollDiv.style.height;
   if(shouldResetScrollSize)
    scrollDiv.style.height = 0;
   this.RestoreWindowSizeFromCache(index);
   if(!this.GetWindowIsShown(index)) {
    var width = this.GetPopupWindowDimensionFromCache(index, true),
     height = this.GetPopupWindowDimensionFromCache(index, false);
    this.SetClientWindowSizeCoreLite(index, width, height);
    this.SetWindowIsShown(index, true);
   }
   var popupElement = this.GetPopupElement(index, popupElementIndex);
   if(popupElement)
    this.SetLastShownPopupElementIndex(index, popupElementIndex);
   if(this.GetIsMaximized(index)) {
    if(this.hideBodyScrollWhenMaximized)
     ASPx.PopupUtils.BodyScrollHelper.HideBodyScroll(element.id);
    this.NormalizeMaximizedWindowSize(index);
   }
   var isDragged = this.GetIsDragged(index);
   var horizontalPopupPosition = this.GetClientPopupPos(element, popupElement, x, true, isDragged);
   var verticalPopupPosition = this.GetClientPopupPos(element, popupElement, y, false, isDragged);
   var clientX = horizontalPopupPosition.position;
   var clientY = verticalPopupPosition.position;
   this.SetWindowPos(index, element, clientX, clientY);
   if(shouldResetScrollSize)
    scrollDiv.style.height = savedScrollDivHeight;
   this.DoShowWindowModalElement(index);
   this.SetVisibleWithAnimation(element, isMoving, index, horizontalPopupPosition, verticalPopupPosition);
   this.ShowWindowContentUrl(index);
   this.AdjustContentOnShow(index);
   scrollDiv = this.GetWindowScrollDiv(index);
   if(scrollDiv && this.GetEnableContentScrolling(index)) {
    var dimension = null;
    var windowMainCell = this.GetWindowMainCell(element);
    if(windowMainCell.style.width && windowMainCell.style.height)
     dimension = 'both';
    else if(windowMainCell.style.width)
     dimension = 'width';
    else if(windowMainCell.style.height)
     dimension = 'height';
    if(!dimension)
     return;
    ASPx.SetElementDisplay(scrollDiv, false);
    this.SetWindowScrollDivSize(scrollDiv, index, dimension);
    ASPx.SetElementDisplay(scrollDiv, true);
   }
   this.registerAndActivateWindow(element, index, allowChangeZIndex);
   this.RaisePopupOnShow(isMoving, index);
   this.CorrectWindowSizeGripPositionLite(index);
   this.CorrectWindowHeaderText(index);
   this.InitMaximizedWindows(index);
   this.InitCollapsedWindows(index);
   if(this.GetIsPinned(index)) window.setTimeout(function() { this.HoldPosition(index, true); }.aspxBind(this), 0);
   if(!this.GetShowOnPageLoad(index))
    this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index));
   if(element.style.width.indexOf("px") > -1) {
    element.style.width = ASPx.GetCurrentStyle(element).width;
   }
   this.updateContentScrollIfNeeded(index);
  }
 },
 DoShowModal: function(index, x, y, popupElementIndex) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   this.StopCloseAnimation(index);
   this.EnsureIframeOnIosContentOverflow(index);
   this.PrepareToAdjustContentOnShow(index);
   if(!ASPx.Browser.WebKitTouchUI)
    ASPx.PopupUtils.BodyScrollHelper.HideBodyScroll(element.id);
   this.DoShowWindowModalElement(index);
   var isMoving = this.InternalIsWindowVisible(index);
   ASPx.SetElementDisplay(this.GetModalWrapperElement(index), true);
   this.ResetScroll(index);
   ASPx.SetElementDisplay(element, true);
   this.SetSizeBeforeShow(index);
   this.UpdateAlignment(index);
   var popupElement = this.GetPopupElement(index, popupElementIndex);
   if(popupElement)
    this.SetLastShownPopupElementIndex(index, popupElementIndex);
   this.SetContentElementsAdaptiveDisplayStyle(index);
   var horizontalPopupPosition = this.GetClientPopupPos(element, popupElement, x, true, false),
    verticalPopupPosition = this.GetClientPopupPos(element, popupElement, y, false, false);
   this.SetVisibleWithAnimation(element, isMoving, index, horizontalPopupPosition, verticalPopupPosition);
   this.ShowWindowContentUrl(index);
   this.AdjustContentOnShow(index);
   this.registerAndActivateWindow(element, index, true);
   this.RaisePopupOnShow(isMoving, index);
   this.CorrectWindowHeaderText(index);
   if(!this.GetShowOnPageLoad(index))
    this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index));
  }
 },
 EnsureIframeOnIosContentOverflow: function(index) {
  if(this.HasIframeOnIos(index)) {
   var contentElement = this.GetWindowContentElement(index);
   if(contentElement.style.overflow === "")
    contentElement.style.overflow = "auto";
  }
 },
 SetWindowElementZIndex: function(element, zIndex) {
  ASPxClientPopupControlBase.prototype.SetWindowElementZIndex.call(this, element, zIndex);
  if(this.adaptivityEnabled)
   this.SetModalWrapperZIndex(this.GetWindowIndex(element), zIndex);
  else
   this.updateContentScrollIfNeeded(this.GetWindowIndex(element));
 },
 SetModalWrapperZIndex: function(index, zIndex) {
  if(!this.GetAdaptiveModalMode(index)) return;
  ASPx.SetStyles(this.GetModalWrapperElement(index), {
   zIndex: zIndex
  });
 },
 updateContentScrollIfNeeded: function(index) {
  var windowElement = this.GetWindowElement(index);
  var wrapper = this.getWindowWrapper(windowElement);
  var wrapperScroll = this.getWindowWrapperScroll(windowElement);
  if(!wrapper || !this.WindowIsModal(index) || !this.GetHideBodyScrollWhenModal(index))
   return;
  ASPx.PopupUtils.adjustViewportScrollWrapper(wrapper, wrapperScroll, windowElement);
 },
 getWindowWrapper: function(windowElement) {
  return ASPx.GetParentByClassName(windowElement, PopupControlCssClasses.WindowWrapperCssClassName);
 },
 getWindowWrapperScroll: function(windowElement) {
  return ASPx.GetParentByClassName(windowElement, PopupControlCssClasses.WindowWrapperScrollCssClassName);
 },
 SizeCanBeSet: function(index, isWindowMaximizedAndCollapsed) {
  return ASPxClientPopupControlBase.prototype.SizeCanBeSet.call(this, index, isWindowMaximizedAndCollapsed) && !this.GetAdaptiveModalMode(index);
 },
 GetPopupWindowDimensionFromCache: function(index, isWidth) {
  var dimension;
  if(isWidth) {
   dimension = this.GetWindowWidthInternal(index);
   if(ASPx.IsExists(dimension)) {
    dimension = Math.max(dimension, this.GetWindowMinWidth(index));
    var maxWidth = this.GetWindowMaxWidth(index);
    if(maxWidth)
     dimension = Math.min(dimension, maxWidth);
   }
  }
  else {
   dimension = this.GetWindowHeightInternal(index);
   if(ASPx.IsExists(dimension)) {
    if(this.HasAnyScrollBars(index) && dimension === constants.DEFAULT_WINDOW_HEIGHT)
     return undefined;
    dimension = Math.max(dimension, this.GetWindowMinHeight(index));
    var maxHeight = this.GetWindowMaxHeight(index);
    if(maxHeight)
     dimension = Math.min(dimension, maxHeight);
   }
  }
  return dimension;
 },
 NormalizeMaximizedWindowSize: function(index) {
  var width = this.GetPopupWindowDimensionFromCache(index, true),
   height = this.GetPopupWindowDimensionFromCache(index, false),
   dimensions = this.getDocumentDimensions(index),
   sizeNormalizationIsNeeded = width < dimensions.width || height < dimensions.height;
  if(sizeNormalizationIsNeeded)
   this.NormalizeWindowSize(index, true);
 },
 NormalizeWindowSize: function(index, isMaximized) {
  var width = this.GetClientWindowWidth(index),
   height = this.GetClientWindowHeight(index),
   normWidth = width,
   normHeight = height,
   maxWidth = this.GetWindowMaxWidth(index),
   minWidth = this.GetWindowMinWidth(index),
   maxHeight = this.GetWindowMaxHeight(index),
   minHeight = this.GetWindowMinHeight(index);
  if(maxWidth)
   normWidth = Math.min(normWidth, maxWidth);
  if(minWidth)
   normWidth = Math.max(normWidth, minWidth);
  if(maxHeight)
   normHeight = Math.min(normHeight, maxHeight);
  if(minHeight)
   normHeight = Math.max(normHeight, minHeight);
  if(normWidth !== width || normHeight !== height)
   this.SetWindowSize(this.GetWindow(index), normWidth, normHeight);
  if(isMaximized) {
   var dimensions = this.getDocumentDimensions(index);
   if(this.GetIsCollapsed(index)) {
    if(normWidth != dimensions.width) {
     this.SetWindowSizeByIndexCore(index, dimensions.width, normHeight, true);
    }
   } else {
    if(normWidth != dimensions.width || normHeight != dimensions.height) {
     this.SetWindowSizeByIndexCore(index, dimensions.width, dimensions.height, false);
    }
   }
  }
 },
 DoShowWindowModalElement: function(index) {
  if(this.CanManipulateWithModalElement(index)) {
   if(this.adaptivityEnabled) {
    this.DoShowWindowModalElementWithAdaptivity(index);
    return;
   }
   var modalElement = this.GetWindowModalElement(index);
   var bodyScrollHasJustBeingHidden = false;
   if(this.GetHideBodyScrollWhenModal(index) && (!this.IsWindowVisible(this.GetWindow(index)) || !ASPx.IsElementVisible(modalElement))) {
    bodyScrollHasJustBeingHidden = true;
    aspxGetPopupControlCollection().LockWindowResizeByBodyScrollVisibilityChanging();
    if(!ASPx.Browser.WebKitTouchUI)
     ASPx.PopupUtils.BodyScrollHelper.HideBodyScroll(this.GetWindowElementId(index));
   }
   if(ASPx.Browser.IE && this.GetHideBodyScrollWhenModal(index))
    ASPx.Evt.AttachEventToElement(modalElement, ASPx.Evt.GetMouseWheelEventName(), function(evt) { return ASPx.Evt.PreventEventAndBubble(evt); });
   ASPx.SetElementDisplay(modalElement, true);
   this.AdjustModalElementBounds(modalElement);
   this.SetModalElementVisibilityWithAnimation(modalElement, index);
   aspxGetPopupControlCollection().RegisterVisibleModalElement(modalElement);
   if(bodyScrollHasJustBeingHidden)
    aspxGetPopupControlCollection().UnlockWindowResizeByBodyScrollVisibilityChanging();
  }
 },
 DoShowWindowModalElementWithAdaptivity: function(index) {
  var overlayElement = this.GetOverlayElement(index);
  if(!overlayElement) return;
  ASPx.SetStyles(overlayElement, {
   right: 0,
   bottom: 0,
   width: "",
   height: ""
  });
  ASPx.SetElementDisplay(overlayElement, true);
  this.SetModalElementVisibilityWithAnimation(overlayElement, index);
  ASPx.GetPopupControlCollection().RegisterVisibleModalElement(overlayElement);
 },
 SetSizeBeforeShow: function(index) {
  if(this.GetModalMaxWidth(index) && this.GetModalMaxWidth(index) !== this.DefaultModalMaxWidth)
   this.SetAdaptiveMaxWidthByIndex(index, this.GetModalMaxWidth(index));
  if(this.GetModalMinWidth(index) !== this.DefaultModalMinWidth)
   this.SetAdaptiveMinWidthByIndex(index, this.GetModalMinWidth(index));
  this.UpdateHeightDimensions(index);
 },
 UpdateHeightDimensions: function(index) {
  this.UpdateAdaptiveMinHeight(index);
  this.UpdateAdaptiveMaxHeight(index);
 },
 UpdateAdaptiveMinHeight: function(index) {
  if(this.GetModalMinHeight(index) !== null)
   this.SetAdaptiveHeightDimension(index, "minHeight", this.GetModalMinHeight(index));
 },
 UpdateAdaptiveMaxHeight: function(index) {
  if(this.GetModalMaxHeight(index) !== null)
   this.SetAdaptiveHeightDimension(index, "maxHeight", this.GetModalMaxHeight(index));
 },
 GetClientPopupPos: function(element, popupElement, pos, isX, isDragged) {
  if(!this.GetAdaptiveModalMode(this.GetWindowIndex(element)))
   return ASPxClientPopupControlBase.prototype.GetClientPopupPos.call(this, element, popupElement, pos, isX, isDragged);
  var getPosFunc = isX ? ASPx.GetAbsolutePositionX : ASPx.GetAbsolutePositionY;
  return { position: getPosFunc(element) };
 },
 GetAnimationVerticalDirection: function(index, verticalPopupPosition) {
  if(!this.GetAdaptiveModalMode(index))
   return ASPxClientPopupControlBase.prototype.GetAnimationVerticalDirection.call(this, index, verticalPopupPosition);
  return ASPxClientPopupControl.Animation.GetVerticalDirection(this.modalVerticalAlign, this.modalHorizontalAlign);
 },
 GetAnimationHorizontalDirection: function(index, horizontalPopupPosition) {
  if(!this.GetAdaptiveModalMode(index))
   return ASPxClientPopupControlBase.prototype.GetAnimationHorizontalDirection.call(this, index, horizontalPopupPosition);
  return ASPxClientPopupControl.Animation.GetHorizontalDirection(this.modalHorizontalAlign);
 },
 GetDefaultVerticalOffset: function() {
  return this.IsSmallDisplay() ? 10 : 30;
 },
 IsSmallDisplay: function() {
  return window.innerWidth < this.GetScreenLimitForCss();
 },
 GetScreenLimitForCss: function() {
  return ASPx.MaxMobileWindowWidth;
 },
 StartAutoAnimation: function(element, index, horizontalPopupPosition, verticalPopupPosition) {
  if(this.adaptivityEnabled) {
   if(this.NeedFadeAnimation(index, this.popupAnimationType))
    this.StartFadeAnimation(element, index);
   else
    this.StartSlideAnimation(element, index, horizontalPopupPosition, verticalPopupPosition);
  } else 
   ASPxClientPopupControlBase.prototype.StartAutoAnimation.call(this, element, index, horizontalPopupPosition, verticalPopupPosition);
 },
 DoHideWindowWithAutoAnimation: function(index, element, closeReason) {
  if(this.NeedFadeAnimation(index, this.closeAnimationType))
   this.DoHideWindowWithFadeAnimation(index, element, closeReason);
  else
   this.DoHideWindowWithSlideAnimation(index, closeReason);
 },
 IsDraggingAllowed: function(index) {
  return this.allowDragging && (!this.GetAdaptiveModalMode(index) || this.allowDraggingInAdaptiveMode);
 },
 IsResizeAllowed: function(index) {
  return ASPxClientPopupControlBase.prototype.IsResizeAllowed.call(this, index) && !this.GetAdaptiveModalMode(index);
 },
 IsFadeCloseAnimation: function(index) {
  return ASPxClientPopupControlBase.prototype.IsFadeCloseAnimation.call(this, index) || this.NeedFadeAnimation(index, this.closeAnimationType);
 },
 NeedFadeAnimation: function(index, animationType) {
  return ASPxClientPopupControl.Animation.NeedFadeAnimation(this.modalHorizontalAlign, this.modalVerticalAlign,
   animationType, this.popupHorizontalAlign, this.popupVerticalAlign, this.GetAdaptiveModalMode(index));
 },
 AllowModalElementAnimation: function(index) {
  if(this.GetAdaptiveModalMode(index))
   return this.popupAnimationType !== ASPxClientPopupControlBase.AnimationType.None;
  return ASPxClientPopupControlBase.prototype.AllowModalElementAnimation.call(this, index);
 },
 DoHideWindowCore: function(index, closeReason) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(this.HasCloseAnimation())
    this.PrepareElementAfterCloseAnimation(index, element);
   element.isHiding = true;
   element.style.zIndex = this.GetDefaultZIndexFromServer();
   this.SetIsDragged(index, false);
   this.UpdateWindowsStateCookie();
   element.isHiding = false;
   this.StopShowAnimation(index);
   if(ASPx.Browser.WebKitTouchUI || ASPx.Browser.Safari) {
    var dummy = element.offsetWidth; 
   }
   ASPx.SetElementDisplay(element, false);
   ASPx.SetElementVisibility(element, false);
   if(this.adaptivityEnabled) {
    ASPx.SetElementDisplay(this.GetModalWrapperElement(index), "");
    if(!ASPx.Browser.WebKitTouchUI)
     ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
    this.SetWrapperScrollVisible(index, true);
    this.SetIsDragged(index, false);
   }
   if(this.hideBodyScrollWhenMaximized && this.GetIsMaximized(index))
    ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
   this.DoHideWindowModalElement(element, closeReason);
   this.DoHideWindowIFrame(element);
   aspxGetPopupControlCollection().UnregisterVisibleWindow(element);
   this.ProcessAccessibleElementOnHide();
   this.HideWindowLoadingPanel(index);
  }
 },
 OnAnimationStop: function(index) {
  if(this.adaptivityEnabled) {
   this.SetWrapperScrollVisible(index, true);
   this.UnlockWrapperScrollEventEvent();
  }
  ASPxClientPopupControlBase.prototype.OnAnimationStop.call(this, index);
  if(!this.adaptivityEnabled && ASPx.Browser.Firefox)
   this.GetWindowElement(index).style.display = "table";
 },
 ResetModalStyles: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   ASPx.SetStyles(element, {
    minWidth: "",
    maxWidth: "",
    marginTop: "",
    marginLeft: "",
    marginRight: "",
    position: ""
   });
   ASPx.SetStyles(this.GetWindowContentElement(index), {
    minHeight: "",
    maxHeight: "",
   });
   this.FixateFooter(index, false, 0);
   this.FixateHeader(index, false, 0);
   this.SetIsDragged(false);
   this.DoHideWindowModalElement(element);
  }
 },
 ResetPopupStyles: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   ASPx.SetStyles(element, {
    left: "",
    top: "",
    width: "",
    height: "",
   });
   ASPx.SetStyles(this.GetWindowContentWrapperElement(index), {
    height: "",
    width: "",
    display: ""
   });
   ASPx.SetStyles(this.GetWindowContentElement(index), {
    display: "",
    width: "",
    height: ""
   });
   this.SetWindowIsShown(index, false);
  }
 },
 InitDivPosForHideSlideAnimation: function(animationDivElement) {
  ASPx.PopupUtils.InitAnimationDivCore(animationDivElement);
 },
 DoHideWindow: function(index, dontRaiseClosing, closeReason) {
  var cancel = ASPxClientPopupControlBase.prototype.DoHideWindow.call(this, index, dontRaiseClosing, closeReason);
  this.updateContentScrollIfNeeded(index);
  return cancel;
 },
 OnWindowShown: function(windowIndex) {
  this.EnsureContent(windowIndex, false);
  this.EnsureIFrameHeightAdjusted(windowIndex);
  if(this.GetAdaptiveModalMode(windowIndex))
   this.ChangeFooterFixed(windowIndex);
  else {
   var isMaximized = this.GetIsMaximized(windowIndex);
   if(isMaximized || this.HasAnyScrollBars(windowIndex))
    this.NormalizeWindowSize(windowIndex, isMaximized);
  }
  this.RaiseShown(windowIndex);
  var loadingElementsWillNotBeShown = !this.lpTimers[windowIndex] || this.lpTimers[windowIndex] < 0;
  if(this.InWindowCallback(windowIndex) && loadingElementsWillNotBeShown) {
   this.ShowWindowLoadingElementsInternal(windowIndex);
  }
  if(this.GetAdaptiveModalMode(windowIndex))
   this.UpdateAdaptiveMinHeight(windowIndex);
  aspxGetPopupControlCollection().RefreshModalRenderInIe(); 
 },
 RefreshModalRenderInIe: function(index) {
  var windowElement = this.GetWindowElement(index),
   zoom = windowElement.style.zoom;
  windowElement.style.zoom = "1";
  window.setTimeout(function() {
   windowElement.style.zoom = zoom;
  }, 100);
 },
 SetWrapperScrollVisible: function(index, visible) {
  if(!this.GetAdaptiveModalMode(index)) return;
  var modalWrapper = this.GetModalWrapperElement(index);
  if(visible) {
   ASPx.Attr.RestoreStyleAttribute(modalWrapper, "overflow-x");
   ASPx.Attr.RestoreStyleAttribute(modalWrapper, "overflow-y");
  } else {
   if(this.modalVerticalAlign === ModalAlign.WindowBottom && this.GetWindowElement(index).offsetHeight <= window.innerHeight)
    ASPx.Attr.ChangeStyleAttribute(modalWrapper, "overflow-y", "hidden");
   if(this.modalHorizontalAlign === ModalAlign.WindowRight)
    ASPx.Attr.ChangeStyleAttribute(modalWrapper, "overflow-x", "hidden");
  }
 },
 GetDragCorrection: function(index, element, isX) {
  if(this.adaptivityEnabled) {
   var offset = isX ? element.offsetLeft : element.offsetTop;
   offset -= ASPx.PxToInt(element.style[isX ? "left" : "top"]);
   return ASPx.GetPositionElementOffset(this.GetModalWrapperElement(index), isX) + offset;
  } else
   return ASPxClientPopupControlBase.prototype.GetDragCorrection.call(this, index, element, isX);
 },
 GetSlideAnimationDuration: function(index) {
  return !this.GetAdaptiveModalMode(index) ? ASPxClientPopupControlBase.prototype.GetSlideAnimationDuration.call(this, index) : 300;
 },
 GetSlideOffsetCoefficient: function(index) {
  return !this.GetAdaptiveModalMode(index) ? ASPxClientPopupControlBase.prototype.GetSlideOffsetCoefficient.call(this, index) : 0.25;
 },
 InitDivPosForShowSlideAnimation: function(index, animationDivElement, clientX, clientY, onAnimStopCallString) {
  if(!this.GetAdaptiveModalMode(index))
   ASPxClientPopupControlBase.prototype.InitDivPosForShowSlideAnimation.call(this, index, animationDivElement, clientX, clientY, onAnimStopCallString);
  else
   ASPx.PopupUtils.InitAnimationProperties(animationDivElement, onAnimStopCallString);
 },
 BeforeAnySlideAnimation: function(index) {
  this.FixateFooter(index, false, 0);
  this.FixateHeader(index, false, 0);
  this.SetWrapperScrollVisible(index, false);
 },
 StartSlideAnimation: function(animationDivElement, index, horizontalPopupPosition, verticalPopupPosition) {
  if(this.adaptivityEnabled) {
   this.LockWrapperScrollEvent();
   this.BeforeAnySlideAnimation(index);
  }
  ASPxClientPopupControlBase.prototype.StartSlideAnimation.call(this, animationDivElement, index, horizontalPopupPosition, verticalPopupPosition);
 },
 DoHideWindowWithSlideAnimation: function(index, closeReason) {
  if(this.adaptivityEnabled)
   this.BeforeAnySlideAnimation(index);
  ASPxClientPopupControlBase.prototype.DoHideWindowWithSlideAnimation.call(this, index, closeReason);
 },
 UpdatePositionAfterCallback: function(windowIndex) {
  if(this.adaptivityEnabled)
   this.TryAutoUpdatePosition(windowIndex);
  else if(this.contentLoadingMode === LoadContentViaCallback.OnFirstShow && this.InternalIsWindowVisible(windowIndex))
   this.UpdateWindowPositionInternal(windowIndex, this.GetPopupElement(windowIndex, this.GetLastShownPopupElementIndex(windowIndex)));
 },
 CreateLoadingDiv: function(parentElement, offsetElement, windowIndex) {
  if(typeof (windowIndex) != "undefined") { 
   var loadingDiv = ASPxClientControl.prototype.CreateLoadingDiv.call(this, parentElement, offsetElement);
   loadingDiv.id += windowIndex;
   return loadingDiv;
  }
 },
 CreateLoadingPanelWithAbsolutePosition: function(parentElement, offsetElement, windowIndex) {
  if(typeof (windowIndex) != "undefined") { 
   var loadingPanel = ASPxClientControl.prototype.CreateLoadingPanelWithAbsolutePosition.call(this, parentElement, offsetElement);
   loadingPanel.id += windowIndex;
   return loadingPanel;
  }
 },
 PerformWindowCallback: function(window, parameter, onSuccess) {
  ASPxClientPopupControlBase.prototype.PerformWindowCallback.call(this, window, parameter, onSuccess);
 },
 SetIframeVisibleForDragging: function(index, visible) {
  var iframeElement = this.GetWindowContentIFrameElement(index);
  if(ASPx.Browser.IE || ASPx.Browser.Edge) {
   if(ASPx.Browser.Edge || ASPx.Browser.Version >= 11)
    iframeElement.style.pointerEvents = visible ? "" : "none";
   else {
    if(visible)
     this.RemoveIframeCoverDiv(iframeElement, index);
    else
     this.CreateIframeCoverDiv(iframeElement, index);
   }
  }
  ASPx.SetElementVisibility(iframeElement, visible);
 },
 OnResizeStop: function(evt, index, cursor, resizePanel) {
  ASPxClientPopupControlBase.prototype.OnResizeStop.call(this, evt, index, cursor, resizePanel);
  if(this.IsResizeAllowed(index))
   this.SetWindowCachedSize(index, this.GetClientWindowWidth(index), this.GetClientWindowHeight(index));
  this.updateContentScrollIfNeeded(index);
 },
 OnMouseDownModalElement: function(evt, index) {
  aspxGetPopupControlCollection().DoHideAllWindows(ASPx.Evt.GetEventSource(evt), "", false, ASPxClientPopupControlCloseReason.OuterMouseClick, evt.offsetX);
  this.SetIsPopuped(index, true);
 },
 IsRaiseAfterResizingLocked: function() {
  return this.CollapseExecuting() || this.MaximizationExecuting();
 },
 GetContentElementChildren: function(index, contentElement) {
  var cache = this.GetResizeSessionCache();
  if(!cache.contentElementChildren || !cache.contentElementChildren[index]) {
   cache.contentElementChildren = [];
   cache.contentElementChildren[index] = contentElement.getElementsByTagName("*");
  }
  return cache.contentElementChildren[index];
 },
 GetContentElementChildrenScroll: function(index, contentElementChildren) {
  var cache = this.GetResizeSessionCache();
  if(!cache.contentElementChildrenScroll || !cache.contentElementChildrenScroll[index]) {
   cache.contentElementChildrenScroll = [];
   cache.contentElementChildrenScroll[index] = [];
   for(var i = 0, len = contentElementChildren.length; i < len; i++) {
    var child = contentElementChildren[i];
    if(!!child.scrollLeft || !!child.scrollTop)
     cache.contentElementChildrenScroll[index].push([i, child.scrollLeft, child.scrollTop]);
   }
  }
  return cache.contentElementChildrenScroll[index];
 },
 GetElementBordersAndPaddings: function(index, element, leftRight) {
  var cache = this.GetResizeSessionCache();
  if(!cache.elementBordersAndPaddings || !cache.elementBordersAndPaddings[index]) {
   cache.elementBordersAndPaddings = [];
   var style = ASPx.GetCurrentStyle(element);
   cache.elementBordersAndPaddings[index] = {
    leftRight: this.getLeftRightBordersAndPaddingsSummaryValue(element, style),
    topBottom: this.getTopBottomBordersAndPaddingsSummaryValue(element, style)
   };
  }
  return leftRight ? cache.elementBordersAndPaddings[index].leftRight : cache.elementBordersAndPaddings[index].topBottom;
 },
 GetHeaderFooterHeight: function(index) {
  var cache = this.GetResizeSessionCache();
  if(!cache.headerFooterHeight || !cache.headerFooterHeight[index]) {
   cache.headerFooterHeight = [];
   cache.headerFooterHeight[index] = this.GetHeaderFooterHeightCore(index);
  }
  return cache.headerFooterHeight[index];
 },
 getContentElementDisplay: function(correctContentElementSize, contentUrl) {
  return correctContentElementSize || contentUrl ? "block" : "table-cell";
 },
 SetContentWrapperHeightLite: function(index, actualHeight, windowElem, contentWrapper) {
  if(!windowElem.style.height || ASPx.IsPercentageSize(windowElem.style.height))
   return;
  var borderOwner = this.GetWindowBorderOwnerElement(windowElem);
  var height = borderOwner == windowElem ? actualHeight : actualHeight - (borderOwner ? ASPx.GetTopBottomBordersAndPaddingsSummaryValue(borderOwner) : 0);
  height -= this.GetHeaderFooterHeight(index);
  if(height > 0)
   contentWrapper.style.height = height + "px";
 },
 SetWindowScrollDivSize: function(scrollDiv, index, dimension) {
  var windowClientTable = this.GetWindowClientTable(index);
  var headerElement = this.GetWindowHeaderElement(index);
  var height = windowClientTable.offsetHeight;
  if(headerElement)
   height -= headerElement.offsetHeight;
  height -= this.GetWindowFooterHeightLite(index);
  if(dimension == 'height' || dimension == 'both')
   ASPx.SetOffsetHeight(scrollDiv, height);
  if(dimension == 'width' || dimension == 'both') {
   var width = windowClientTable.offsetWidth;
   var contentElement = this.GetWindowContentElement(index);
   width -= this.getLeftRightBordersAndPaddingsSummaryValue(scrollDiv) + ASPx.GetHorizontalBordersWidth(contentElement);
   if(width > -1)
    scrollDiv.style.width = width + "px";
  }
  scrollDiv.style.marginRight = "0px";
 },
 AdjustIFrameHeight: function(index, iframe) {
  ASPxClientPopupControlBase.prototype.AdjustIFrameHeight.call(this, index, iframe);
  if(!this.InternalIsWindowVisible(index) || !iframe || this.GetAdaptiveModalMode(index)) return;
  this.SetIframeAdjustingPostponed(index, false);
  var content = this.GetContentContainer(index);
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  iframe.style.verticalAlign = "text-bottom";
  var iframeHeight = contentWrapper.offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(content);
  if(iframeHeight >= 0)
   iframe.style.height = iframeHeight + "px";
 },
 OnPinButtonClick: function(index) {
  var value = this.GetIsPinned(index);
  this.SetPinCore(index, !value);
 },
 SetPinCore: function(index, value) {
  if(this.GetIsPinned(index) != value) {
   this.SetIsPinned(index, value);
   this.HoldPosition(index, value);
   this.UpdateWindowsStateCookie();
   this.OnPinned(index, value);
  }
 },
 OnPinned: function(index, pinned) {
  this.RaisePinnedChanged(index, pinned);
 },
 HoldPosition: function(index, hold, element) {
  if(hold) {
   element = element || this.GetWindowElement(index);
   if(!element) return;
   var x = ASPx.GetAbsoluteX(element);
   var y = ASPx.GetAbsoluteY(element);
   scrollX = ASPx.GetDocumentScrollLeft();
   scrollY = ASPx.GetDocumentScrollTop();
   this.SetPinPosX(index, x - scrollX);
   this.SetPinPosY(index, y - scrollY);
  }
  this.UpdateHeaderButtonSelected(index, "GetWindowPinButton", hold);
  this.CheckHeaderCursor(index);
 },
 GetBodyWidth: function() {
  return aspxGetPopupControlCollection().GetSavedBodyWidth();
 },
 GetBodyHeight: function() {
  return aspxGetPopupControlCollection().GetSavedBodyHeight();
 },
 GetIsOutFromViewPort: function(index) {
  var element = this.GetWindowElement(index);
  if(!element) return false;
  var pinXTarget = this.GetPinPosX(index);
  var pinYTarget = this.GetPinPosY(index);
  var popupWindowWidth = this.GetClientWindowWidth(index);
  var docClientWidth = ASPx.GetDocumentClientWidth();
  var rightOutOffset = (pinXTarget + popupWindowWidth) - docClientWidth;
  var popupWindowHeight = this.GetClientWindowHeight(index);
  var docClientHeight = ASPx.GetDocumentClientHeight();
  var bottomOutOffset = (pinYTarget + popupWindowHeight) - docClientHeight;
  return (rightOutOffset > 0 || bottomOutOffset > 0);
 },
 needToHidePinnedOutFromViewPort: function(index) {
  return this.GetIsPinned(index) && this.GetIsOutFromViewPort(index);
 },
 AdjustPinPositionWhileScroll: function(index) {
  var element = this.GetWindowElement(index);
  if(!element) return;
  var x = ASPx.GetAbsoluteX(element);
  var y = ASPx.GetAbsoluteY(element);
  var scrollX = ASPx.GetDocumentScrollLeft();
  var scrollY = ASPx.GetDocumentScrollTop();
  var pinX = x - scrollX;
  var pinY = y - scrollY;
  var pinXTarget = this.GetPinPosX(index);
  var pinYTarget = this.GetPinPosY(index);
  if((pinX != pinXTarget) || (pinY != pinYTarget)) {
   this.lockScroll++;
   var xNew = pinXTarget + scrollX;
   var yNew = pinYTarget + scrollY;
   var bodyWidth = this.GetBodyWidth();
   var bodyHeight = this.GetBodyHeight();
   var popupWindowWidth = this.GetClientWindowWidth(index);
   var docClientWidth = ASPx.GetDocumentClientWidth();
   var rightOutOffset = (pinXTarget + popupWindowWidth) - docClientWidth;
   var popupWindowHeight = this.GetClientWindowHeight(index);
   var docClientHeight = ASPx.GetDocumentClientHeight();
   var bottomOutOffset = (pinYTarget + popupWindowHeight) - docClientHeight;
   var cancelScrollX = false;
   if(xNew + (popupWindowWidth - rightOutOffset) > bodyWidth) {
    xNew -= (xNew + (popupWindowWidth - rightOutOffset) - bodyWidth);
    cancelScrollX = true;
   }
   var cancelScrollY = false;
   if(yNew + (popupWindowHeight - bottomOutOffset) > bodyHeight) {
    yNew -= (yNew + (popupWindowHeight - bottomOutOffset) - bodyHeight);
    cancelScrollY = true;
   }
   xNew = ASPx.PrepareClientPosForElement(xNew, element, true);
   yNew = ASPx.PrepareClientPosForElement(yNew, element, false);
   this.SetWindowPos(index, element, xNew, yNew);
   if(cancelScrollX) {
    var scrollLeftMax = bodyWidth - ASPx.GetDocumentClientWidth();
    if((rightOutOffset > 0) && (scrollX > scrollLeftMax)) {
     this.lockScroll++;
     ASPx.SetDocumentScrollLeft(scrollLeftMax);
     this.lockScroll--;
    }
   }
   if(cancelScrollY) {
    var scrollTopMax = bodyHeight - ASPx.GetDocumentClientHeight();
    if((bottomOutOffset > 0) && (scrollY > scrollTopMax)) {
     this.lockScroll++;
     ASPx.SetDocumentScrollTop(scrollTopMax);
     this.lockScroll--;
    }
   }
   this.lockScroll--;
  }
 },
 OnCollapseButtonClick: function(index) {
  this.SetCollapsedCore(index, !this.GetIsCollapsed(index));
 },
 SetCollapsedCore: function(index, minimization) {
  if(this.GetIsCollapsed(index) == minimization) return;
  this.DoCollapse(index, minimization);
  this.OnCollapsed(index, minimization);
 },
 DoCollapse: function(index, minimization) {
  if(this.GetIsCollapsed(index) == minimization) return;
  this.StartCollapse();
  if(minimization) {
   var cachedWidth = this.GetClientWindowWidth(index);
   var cachedHeight = this.GetClientWindowHeight(index);
   var shouldUpdateRestoredSize = this.ShoulUpdatedRestoredWindowSizeOnCollapse(index);
   var width = this.GetMainWindowWidth(index, !shouldUpdateRestoredSize);
   var height = this.GetMainWindowHeight(index, !shouldUpdateRestoredSize);
   this.SetWindowSizeByIndex(index, width, 0);
   this.SetWindowContentVisible(index, false);
   this.SetWindowFooterVisible(index, false);
   this.ResetWindowHeight(index);
   this.SetIsCollapsed(index, minimization);
   this.SetWindowCachedSize(index, cachedWidth, cachedHeight);
   if(shouldUpdateRestoredSize)
    this.UpdateRestoredWindowSize(index, width, height);
  }
  else {
   if(this.MaximizationExecuting()) {
    var element = this.GetWindowElement(index);
    if(element) {
     element.style.left = ASPx.GetDocumentScrollLeft();
     element.style.top = ASPx.GetDocumentScrollTop();
    }
   }
   this.SetWindowContentVisible(index, true);
   this.SetWindowFooterVisible(index, true);
   this.SetIsCollapsed(index, minimization);
   if(this.GetIsMaximized(index)) {
    var documentClientWidth = ASPx.PopupUtils.GetDocumentClientWidthForPopup();
    var documentClientHeight = ASPx.PopupUtils.GetDocumentClientHeightForPopup();
    this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
   } else {
    var restoredWindowData = this.GetRestoredWindowData(index);
    this.SetWindowSizeByIndex(index, restoredWindowData.width, restoredWindowData.height);
   }
   ASPx.GetControlCollection().AdjustControls(this.GetWindowElement(index));
  }
  this.UpdateHeaderButtonSelected(index, "GetWindowCollapseButton", minimization);
  this.EndCollapse();
  this.UpdateWindowsStateCookie();
 },
 ResetWindowHeight: function(index) {
  var element = this.GetWindowElement(index);
  if(element)
   element.style.height = "";
 },
 ShoulUpdatedRestoredWindowSizeOnCollapse: function(index) {
  return !this.GetIsMaximized(index);
 },
 OnCollapsed: function(index, value) {
  if(value)
   this.RaiseCollapsed(index);
  else
   this.RaiseExpanded(index);
  this.RaiseAfterResizing(index);
 },
 OnMaximizeButtonClick: function(index) {
  this.SetMaximizedCore(index, !this.GetIsMaximized(index));
 },
 SetMaximizedCore: function(index, maximization) {
  if(this.GetIsMaximized(index) == maximization) return;
  this.DoMaximize(index, maximization);
  this.OnMaximizedChanged(index, maximization);
 },
 GetMaximizedPosition: function(element, isX) {
  if(ASPx.Browser.WebKitTouchUI)
   return ASPx.PrepareClientPosForElement(0, element, isX);
  return ASPx.PrepareClientPosForElement(isX ? ASPx.GetDocumentScrollLeft() : ASPx.GetDocumentScrollTop(), element, isX);
 },
 PerformMaximaze: function (index, maximization, element) {
  if (this.hideBodyScrollWhenMaximized)
   ASPx.PopupUtils.BodyScrollHelper.HideBodyScroll(element.id);
  if (this.GetIsCollapsed(index))
   this.DoCollapse(index, false);
  var cachedWidth = this.GetClientWindowWidth(index);
  var cachedHeight = this.GetClientWindowHeight(index);
  var restoredWindowData = this.GetInitRestoredWindowData(index);
  var documentClientWidth = ASPx.PopupUtils.GetDocumentClientWidthForPopup();
  var documentClientHeight = ASPx.PopupUtils.GetDocumentClientHeightForPopup();
  var windowClientTable = this.GetWindowClientTable(index);
  var windowClientTableParent = windowClientTable.parentNode;
  childStyle = ASPx.GetCurrentStyle(windowClientTableParent);
  var left = this.GetMaximizedPosition(element, true);
  var top = this.GetMaximizedPosition(element, false);
  this.SetWindowPos(index, element, left, top);
  this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
  this.SetWindowCachedSize(index, cachedWidth, cachedHeight);
  this.SetRestoredWindowData(index, restoredWindowData);
  this.SetIsMaximized(index, maximization);
 },
 PerformMinimize: function (index, maximization, element) {
  var restoredWindowData = this.GetRestoredWindowData(index);
  var width = restoredWindowData.width || this.GetMainWindowWidth(index);
  var height = restoredWindowData.height || this.GetMainWindowHeight(index);
  this.SetIsMaximized(index, maximization);
  var left = ASPx.PrepareClientPosForElement(restoredWindowData.left, element, true);
  var top = ASPx.PrepareClientPosForElement(restoredWindowData.top, element, false);
  this.SetWindowPos(index, element, left, top);
  this.SetWindowSizeByIndex(index, width, height);
  if (this.GetIsCollapsed(index)) {
   this.SetIsCollapsed(index, false);
   this.UpdateRestoredWindowSizeLock();
   this.DoCollapse(index, true);
   this.UpdateRestoredWindowSizeUnlock();
  }
  if (this.hideBodyScrollWhenMaximized)
   ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
 },
 DoMaximize: function(index, maximization) {
  if(this.GetIsMaximized(index) == maximization) return;
  var element = this.GetWindowElement(index);
  if(!element) return;
  this.StartMaximization();
  if(maximization)
   this.PerformMaximaze(index, maximization, element);
  else
   this.PerformMinimize(index, maximization, element);
  if(this.GetIsPinned(index))
   this.HoldPosition(index, true, element);
  this.UpdateHeaderButtonSelected(index, "GetWindowMaximizeButton", maximization);
  this.EndMaximization();
  this.UpdateWindowsStateCookie();
  this.CheckHeaderCursor(index);
 },
 OnMaximizedChanged: function(index, value) {
  if(value)
   this.RaiseMaximized(index);
  else
   this.RaiseRestoredAfterMaximized(index);
  this.RaiseAfterResizing(index);
 },
 GetInitRestoredWindowData: function(index) {
  var restoredWindowData = this.GetRestoredWindowData(index);
  restoredWindowData.left = this.GetCurrentLeft(index);
  restoredWindowData.top = this.GetCurrentTop(index);
  restoredWindowData.width = this.GetMainWindowWidth(index);
  restoredWindowData.height = this.GetMainWindowHeight(index);
  return restoredWindowData;
 },
 getDocumentDimensions: function(index) {
  var documentClientWidth = ASPx.PopupUtils.GetDocumentClientWidthForPopup(),
   documentClientHeight = ASPx.PopupUtils.GetDocumentClientHeightForPopup();
  return { width: documentClientWidth, height: documentClientHeight };
 }, 
 UpdateMaximizedWindowSizeOnResize: function(index) {
  this.StartUpdateMaximizedWindowSizeOnResize();
  var dimensions = this.getDocumentDimensions(index);
  if(this.GetIsCollapsed(index)) dimensions.height = 0;
  this.SetWindowSizeByIndex(index, dimensions.width, dimensions.height);
  if(this.GetIsCollapsed(index)) {
   this.CorrectCollapsedSize(index);
  }
  window.setTimeout(function() { this.SetMaximizedWindowSizeAfterOnResize(index); }.aspxBind(this), 0);
  this.EndUpdateMaximizedWindowSizeOnResize();
 },
 SetMaximizedWindowSizeAfterOnResize: function(index) {
  this.StartUpdateMaximizedWindowSizeOnResize();
  var dimensions = this.getDocumentDimensions(index);
  windowWidthCurrent = this.GetMainWindowWidth(index, true);
  windowHeightCurrent = this.GetMainWindowHeight(index, true);
  if(this.GetIsCollapsed(index))
   dimensions.height = 0;
  if(dimensions.width != windowWidthCurrent || dimensions.height != windowHeightCurrent) {
   this.SetWindowSizeByIndex(index, dimensions.width, dimensions.height);
   if(this.GetIsCollapsed(index)) {
    this.CorrectCollapsedSize(index);
   }
  }
  this.EndUpdateMaximizedWindowSizeOnResize();
 },
 CorrectCollapsedSize: function(index) {
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  if(contentWrapper && ASPx.IsElementVisible(contentWrapper))
   contentWrapper.style.display = 'none';
 },
 UpdateHeaderButtonSelected: function(index, methodGetWindowButton, flagSelected) {
  if(typeof (ASPx.GetStateController) != "undefined") {
   button = this[methodGetWindowButton](index);
   var method = flagSelected ? "SelectElementBySrcElement" : "DeselectElementBySrcElement";
   ASPx.GetStateController()[method](button);
  }
 },
 CheckHeaderCursor: function(index) {
  if(!this.allowDragging) return;
  var dragElement = this.GetDragElement(index);
  if(!dragElement) return;
  var styleCursor = dragElement.style.cursor;
  var isPinned = this.GetIsPinned(index);
  var isMaximized = this.GetIsMaximized(index);
  if((isPinned || isMaximized) && styleCursor != "default")
   dragElement.style.cursor = "default";
  else if(!isPinned && !isMaximized && styleCursor != "move")
   dragElement.style.cursor = "move";
 },
 StartCollapse: function() {
  this.collapseExecutingLockCount++;
 },
 EndCollapse: function() {
  this.collapseExecutingLockCount--;
 },
 CollapseExecuting: function() {
  return this.collapseExecutingLockCount > 0;
 },
 StartMaximization: function() {
  this.maximizationExecutingLockCount++;
 },
 EndMaximization: function() {
  this.maximizationExecutingLockCount--;
 },
 MaximizationExecuting: function() {
  return this.maximizationExecutingLockCount > 0;
 },
 StartUpdateMaximizedWindowSizeOnResize: function() {
  this.browserResizingForMaxWindowLockCount++;
 },
 EndUpdateMaximizedWindowSizeOnResize: function() {
  this.browserResizingForMaxWindowLockCount--;
 },
 ResizingForMaxWindowLocked: function() {
  return this.browserResizingForMaxWindowLockCount > 0;
 },
 UpdateRestoredWindowSizeLock: function() {
  this.updateRestoredWindowSizeLockCount++;
 },
 UpdateRestoredWindowSizeUnlock: function() {
  this.updateRestoredWindowSizeLockCount--;
 },
 UpdateRestoredWindowSizeLocked: function() {
  return this.updateRestoredWindowSizeLockCount > 0;
 },
 UpdateRestoredWindowSize: function(index, width, height) {
  if(!this.UpdateRestoredWindowSizeLocked()) {
   restoredMinWindowData = this.GetRestoredWindowData(index);
   restoredMinWindowData.width = width;
   restoredMinWindowData.height = height;
   this.SetRestoredWindowData(index, restoredMinWindowData);
  }
 },
 GetWindowsState: function() {
  var state = ASPxClientPopupControlBase.prototype.GetWindowsState.call(this);
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   state += this.GetWindowState(i);
   if(i < this.GetWindowCountCore() - 1) state += ";";
  }
  return state;
 },
 CreateWindows: function(windowsNames) {
  for(var i = 0; i < windowsNames.length; i++) {
   var window = new ASPxClientPopupWindow(this, i, windowsNames[i]);
   this.windows.push(window);
  }
 },
 RaiseCloseButtonClick: function(index) {
  ASPxClientPopupControlBase.prototype.RaiseCloseButtonClick.call(this, index);
 },
 RaisePinnedChanged: function(index, pinned) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.PinnedChanged.IsEmpty()) {
   var args = new ASPxClientPopupWindowPinnedChangedEventArgs(window, pinned);
   this.PinnedChanged.FireEvent(this, args);
  }
 },
 RaiseCollapsed: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Collapsed);
 },
 RaiseExpanded: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Expanded);
 },
 RaiseMaximized: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Maximized);
 },
 RaiseRestoredAfterMaximized: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.RestoredAfterMaximized);
 },
 GetContentWidth: function() {
  return this.GetWindowContentWidth(null);
 },
 GetContentHeight: function() {
  return this.GetWindowContentHeight(null);
 },
 SetSize: function(width, height) {
  ASPxClientPopupControlBase.prototype.SetSize.call(this, width, height);
 },
 GetWindowDimension: function(window, isWidth, forceFromCache) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowDimensionByIndex(index, isWidth, forceFromCache);
 },
 GetWindowContentDimension: function(window, isWidth) {
  var index = (window != null) ? window.index : -1,
   contentElem = this.GetWindowContentElement(index),
   dimensionHolder = contentElem.parentNode,
   paddingsHolder = contentElem;
  return isWidth ?
  (dimensionHolder.offsetWidth - this.getLeftRightBordersAndPaddingsSummaryValue(paddingsHolder)) :
  (dimensionHolder.offsetHeight - this.getTopBottomBordersAndPaddingsSummaryValue(paddingsHolder));
 },
 GetWindowContentWidth: function(window) {
  return this.GetWindowContentDimension(window, true);
 },
 GetWindowContentHeight: function(window) {
  return this.GetWindowContentDimension(window, false);
 },
 GetWindowHeight: function(window) {
  return this.GetWindowDimension(window, false);
 },
 GetWindowWidth: function(window) {
  return this.GetWindowDimension(window, true);
 },
 SetWindowSize: function(window, width, height) {
  return ASPxClientPopupControlBase.prototype.SetWindowSize.call(this, window, width, height);
 },
 GetContentHTML: function() {
  return this.GetContentHtml();
 },
 SetContentHTML: function(html) {
  this.SetContentHtml(html);
 },
 SetWindowPopupElementID: function(window, popupElementId) {
  var index = (window != null) ? window.index : -1;
  this.SetPopupElementIDByIndex(index, popupElementId);
 },
 SetPopupElementID: function(popupElementId) {
  this.SetPopupElementIDByIndex(-1, popupElementId);
 },
 GetCurrentPopupElementIndex: function() {
  return this.GetWindowCurrentPopupElementIndexByWindowIndex(-1);
 },
 GetWindowCurrentPopupElementIndex: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowCurrentPopupElementIndexByWindowIndex(index);
 },
 GetCurrentPopupElement: function() {
  return this.GetWindowCurrentPopupElementByIndex(-1);
 },
 GetWindowCurrentPopupElement: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowCurrentPopupElementByIndex(index);
 },
 ShowAtPos: function(x, y) {
  this.ShowWindowAtPos(null, Math.round(x), Math.round(y));
 },
 BringToFront: function() {
  this.BringWindowToFront(null);
 },
 IsWindowVisible: function(window) {
  return ASPxClientPopupControlBase.prototype.IsWindowVisible.call(this, window);
 },
 GetWindow: function(index) {
  return ASPxClientPopupControlBase.prototype.GetWindow.call(this, index);
 },
 GetWindowByName: function(name) {
  for(var i = 0; i < this.windows.length; i++)
   if(this.windows[i].name == name) return this.windows[i];
  return null;
 },
 GetWindowCount: function() {
  return this.GetWindowCountCore();
 },
 ShowWindow: function(window, popupElementIndex) {
  var index = (window != null) ? window.index : -1;
  this.ShowWindowByIndex(index, popupElementIndex);
 },
 ShowWindowAtElement: function(window, htmlElement) {
  var index = (window != null) ? window.index : -1;
  this.ShowWindowAtElementByIndex(index, htmlElement);
 },
 ShowWindowAtElementByID: function(window, id) {
  var htmlElement = document.getElementById(id);
  this.ShowWindowAtElement(window, htmlElement);
 },
 ShowWindowAtPos: function(window, x, y) {
  if(!this.isInitialized)
   return;
  var index = (window != null) ? window.index : -1;
  this.DoShowWindowCore(index, x, y, -1, false, true);
 },
 BringWindowToFront: function(window) {
  var index = (window != null) ? window.index : -1;
  var element = this.GetWindowElement(index);
  aspxGetPopupControlCollection().ActivateWindowElement(element, undefined, this.GetPopupType(), this.GetDefaultZIndexFromServer(), this.GetPopupControlZIndex());
 },
 HideWindow: function(window) {
  ASPxClientPopupControlBase.prototype.HideWindow.call(this, window);
 },
 GetWindowContentHTML: function(window) {
  return this.GetWindowContentHtml(window);
 },
 SetWindowContentHTML: function(window, html) {
  this.SetWindowContentHtml(window, html);
 },
 GetWindowContentHtml: function(window) {
  return ASPxClientPopupControlBase.prototype.GetWindowContentHtml.call(this, window);
 },
 SetWindowContentHtml: function(window, html, useAnimation) {
  ASPxClientPopupControlBase.prototype.SetWindowContentHtml.call(this, window, html, useAnimation);
 },
 AfterSetWindowContentHtml: function(index, contentContainer, useAnimation) {
  if(this.GetAdaptiveModalMode(index))
   this.TryAutoUpdatePosition(index);
  else if(this.InternalIsWindowVisible(index))
   this.RecalculateWindowSize(index);
  ASPxClientPopupControlBase.prototype.AfterSetWindowContentHtml.call(this, index, contentContainer, useAnimation);
  this.UpdateScrollbar(index);
 },
 UpdateAlignment: function(index) {
  if(this.GetIsDragged(index)) return;
  var element = this.GetWindowElement(index),
   wrapperStyle = getComputedStyle(this.GetModalWrapperElement(index)),
   top = ASPxClientPopupControl.AligmentCalculator.CalculateTopMargin(this.modalVerticalAlign, element.offsetHeight, this.GetDefaultVerticalOffset()),
   left = ASPxClientPopupControl.AligmentCalculator.CalculateLeftRightMargin(this.modalHorizontalAlign, ModalAlign.WindowLeft, wrapperStyle.paddingLeft),
   right = ASPxClientPopupControl.AligmentCalculator.CalculateLeftRightMargin(this.modalHorizontalAlign, ModalAlign.WindowRight, wrapperStyle.paddingRight);
  ASPx.SetStyles(element, {
   marginTop: top,
   marginLeft: left,
   marginRight: right
  });
 },
 GetOverlayElement: function(index) {
  return this.GetWindowModalElement(index);
 },
 GetModalWrapperElement: function(index) {
  if(!this.adaptivityEnabled) return null;
  var windowElement = this.GetWindowElement(index);
  return !!windowElement ? windowElement.parentNode : null;
 },
 GetWindowHeightWithoutContent: function(index) {
  var element = this.GetWindowElement(index),
   borderOwner = this.GetWindowBorderOwnerElement(element);
  return this.GetHeaderFooterHeightCore(index) + ASPx.GetVerticalBordersWidth(borderOwner);
 },
 StretchVertically: function() {
  this.StretchVerticallyByIndex(-1, true);
 },
 WindowStretchVertically: function(window) {
  var index = (window != null) ? window.index : -1;
  this.StretchVerticallyByIndex(index, true);
 },
 StretchVerticallyByIndex: function(index, value) {
  if(this.GetStretchVerticallyByIndex(index) !== value) {
   this.SetPropertyValue(index, "stretchVertically", value);
   var oldMinHeight = !!this.GetModalMinHeight(index) ? this.GetModalMinHeight(index) : 0;
   this.SetPropertyValue(index, "modalMinHeight", value ? "100vh" : this.minHeightBackup);
   this.minHeightBackup = oldMinHeight;
   this.UpdateHeightDimensions(index);
  }
 },
 SetAdaptiveMinWidth: function(minWidth) {
  this.SetAdaptiveMinWidthByIndex(-1, minWidth);
 },
 SetWindowAdaptiveMinWidth: function(window, minWidth) {
  var index = (window != null) ? window.index : -1;
  this.SetAdaptiveMinWidthByIndex(index, minWidth);
 },
 SetAdaptiveMaxWidth: function(maxWidth) {
  this.SetAdaptiveMaxWidthByIndex(-1, maxWidth);
 },
 SetWindowAdaptiveMaxWidth: function(window, maxWidth) {
  var index = (window != null) ? window.index : -1;
  this.SetAdaptiveMaxWidthByIndex(index, maxWidth);
 },
 SetAdaptiveMinHeight: function(minHeight) {
  this.SetAdaptiveMinHeightByIndex(-1, minHeight);
 },
 SetWindowAdaptiveMinHeight: function(window, minHeight) {
  var index = (window != null) ? window.index : -1;
  this.SetAdaptiveMinHeightByIndex(index, minHeight);
 },
 SetAdaptiveMaxHeight: function(maxHeight) {
  this.SetAdaptiveMaxHeightByIndex(-1, maxHeight);
 },
 SetWindowAdaptiveMaxHeight: function(window, maxHeight) {
  var index = (window != null) ? window.index : -1;
  this.SetAdaptiveMaxHeightByIndex(index, maxHeight);
 },
 SetAdaptiveHeightDimension: function(index, propertyName, value) {
  value = this.ConvertDimensionValueToString(value);
  value = value.indexOf("%") > -1 ? value.replace("%", "vh") : value;
  var margins = 0;
  if(this.stretchVertically && propertyName === "minHeight")
   margins = ASPx.GetTopBottomMargins(this.GetWindowElement(index));
  var contentElement = this.GetWindowContentElement(index);  
  var iframe = this.GetWindowContentIFrameElement(index);
  var additionalHeight = this.GetWindowHeightWithoutContent(index) + margins;
  var adaptiveHeight = "calc(" + value + " - " + additionalHeight + "px)";
  contentElement.style[propertyName] = adaptiveHeight;
  if (contentElement.style.minHeight) {
   if (iframe || this.HasAnyScrollBars(index))
    contentElement.style.height = "1px";
   else if (propertyName === "minHeight")
    this.SetContentWrapperAdaptiveHeight(index, adaptiveHeight);
  }
  if(iframe) {
   iframe.style.verticalAlign = "text-bottom";
   iframe.style.height = "100%";
  }
 },
 ConvertDimensionValueToString: function(value) {
  if(typeof value === "number")
   return value + "px";
  if(typeof value === "string")
   return value;
 },
 CanBeClosedByClickOnElement: function(index, srcElement, posX, id) {
  return ASPxClientPopupControlBase.prototype.CanBeClosedByClickOnElement.call(this, index, srcElement, posX, id) &&
   (!this.GetAdaptiveModalMode(index) || srcElement != this.GetModalWrapperElement(index) || posX < srcElement.offsetWidth - ASPx.GetVerticalScrollBarWidth());
 },
 SetWindowDisplay: function(index, value) {
  ASPxClientPopupControlBase.prototype.SetWindowDisplay.call(this, index, value);
  if(this.adaptivityEnabled) {
   var wrapper = this.GetModalWrapperElement(index);
   ASPx.SetElementDisplay(wrapper, value);
  }
 },
 HaveSpecialDivForAnimation: function() {
  return ASPxClientPopupControlBase.prototype.HaveSpecialDivForAnimation.call(this) || this.adaptivityEnabled;
 },
 WindowIsModal: function(index) {
  return ASPxClientPopupControlBase.prototype.WindowIsModal.call(this, index) || this.GetAdaptiveModalMode(index);
 },
 RecalculateWindowSize: function(index) {
  var window = this.GetWindowElement(index);
  var displayAfterSetSize = window.style.display;
  this.SetClientWindowSizeCoreLite(index, this.GetWindowWidthInternal(index), this.GetWindowHeightInternal(index), this.GetIsCollapsed(index));
  window.style.display = displayAfterSetSize;
  if(this.HasAnyScrollBars(index))
   this.NormalizeWindowSize(index, this.GetIsMaximized(index));
 },
 GetWindowContentIFrame: function(window) {
  return ASPxClientPopupControlBase.prototype.GetWindowContentIFrame.call(this, window);
 },
 GetWindowContentUrl: function(window) {
  return ASPxClientPopupControlBase.prototype.GetWindowContentUrl.call(this, window);
 },
 SetWindowContentUrl: function(window, url) {
  ASPxClientPopupControlBase.prototype.SetWindowContentUrl.call(this, window, url);
 },
 RefreshDimensionsAfterCreateIframe: function(index) {
  if(ASPx.IsElementVisible(this.GetWindowElement(index), true)) {
   var windowWidth = this.GetWindowDimensionByIndex(index, true, false);
   var windowHeight = this.GetWindowDimensionByIndex(index, false, false);
   this.SetClientWindowSizeCoreLite(index, windowWidth, windowHeight);
  }
 },
 GetPinned: function() {
  return this.GetIsPinned(-1);
 },
 SetPinned: function(value) {
  this.SetPinCore(-1, value);
 },
 GetWindowPinned: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsPinned(index);
 },
 SetWindowPinned: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetPinCore(index, value);
 },
 GetMaximized: function() {
  return this.GetIsMaximized(-1);
 },
 SetMaximized: function(value) {
  this.SetMaximizedCore(-1, value);
 },
 GetWindowMaximized: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsMaximized(index);
 },
 SetWindowMaximized: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetMaximizedCore(index, value);
 },
 GetCollapsed: function() {
  return this.GetIsCollapsed(-1);
 },
 SetCollapsed: function(value) {
  this.SetCollapsedCore(-1, value);
 },
 GetWindowCollapsed: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsCollapsed(index);
 },
 SetWindowCollapsed: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetCollapsedCore(index, value);
 },
 RefreshWindowContentUrl: function(window) {
  ASPxClientPopupControlBase.prototype.RefreshWindowContentUrl.call(this, window);
 },
 SetWindowContentVisible: function(index, visible) {
  var contentElement = this.GetWindowContentWrapperElement(index);
  if(contentElement)
   this.SetWindowPartVisibleCore(contentElement, "DXPopupWindowContentDisplay", visible);
 },
 SetWindowFooterVisible: function(index, visible) {
  var footerElement = this.GetWindowFooterElement(index);
  if(footerElement)
   this.SetWindowPartVisibleCore(footerElement, "DXPopupWindowFooterDisplay", visible);
 },
 SetWindowPartVisibleCore: function(partElement, displayCacheName, visible) {
  var nothingChanged = ASPx.IsElementVisible(partElement) && visible;
  if(nothingChanged) return;
  if(!(ASPx.IsExists(partElement[displayCacheName])))
   partElement[displayCacheName] = partElement.style.display;
  partElement.style.display = visible ? partElement[displayCacheName] : 'none';
 },
 UpdatePosition: function() {
  this.UpdatePositionAtElement(this.GetPopupElement(-1, this.GetLastShownPopupElementIndex(-1)));
 },
 UpdatePositionAtElement: function(popupElement) {
  ASPxClientPopupControlBase.prototype.UpdatePositionAtElement.call(this, popupElement);
 },
 UpdateWindowPosition: function(window) {
  var index = (window != null) ? window.index : -1;
  this.UpdateWindowPositionAtElement(window, this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index)));
 },
 UpdateWindowPositionAtElement: function(window, popupElement) {
  ASPxClientPopupControlBase.prototype.UpdateWindowPositionAtElement.call(this, window, popupElement);
 },
 UpdateWindowPositionInternal: function(index, popupElement) {
  if(this.GetAdaptiveModalMode(index)) {
   this.TryAutoUpdatePosition(index);
   return;
  }
  if(!ASPxClientPopupControlBase.prototype.UpdateWindowPositionInternal.call(this, index, popupElement))
   this.DoShowWindowAtPos(index, ASPx.InvalidDimension, ASPx.InvalidDimension, this.GetLastShownPopupElementIndex(index), false, false);
 },
 UpdateMode: function(index) {
  if(!this.adaptivityEnabled) return;
  var currentMode = this.GetAdaptiveModalMode(index),
   newMode = this.NeedAdaptiveModalMode(index);
  if(currentMode != newMode) {
   this.SetAdaptiveModalMode(index, newMode);
   if(!newMode && !ASPx.Browser.WebKitTouchUI) {
    var element = this.GetWindowElement(index);
    ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
   }
   this.ShowWindowByIndex(-1);
   this.RaiseAdaptiveModeChanged();
  }
 },
 RaiseAdaptiveModeChanged: function() {
  if(!this.AdaptiveModeChanged.IsEmpty()) {
   var args = new ASPxClientEventArgs();
   this.AdaptiveModeChanged.FireEvent(this, args);
  }
 },
 TryAutoUpdatePosition: function(index) {
  this.UpdateMode(index);
  ASPxClientPopupControlBase.prototype.TryAutoUpdatePosition.call(this, index);
  if(this.GetAdaptiveModalMode(index)) {
   this.CorrectScrollPositionOnAndroid(index, false);
   this.ResetWebkitScrolling(this.GetModalWrapperElement(index), 100);
   this.UpdateHeightDimensions(index);
   this.ChangeHeaderFixed(index);
   this.UpdateAlignment(index);
   this.ChangeFooterFixed(index);
   if(this.GetIsDragged(index) &&
    ASPxClientPopupControl.WindowResizeHelper.AdjustModalOnWindowResize(this.GetWindowElement(index)))
    this.SetIsDragged(index, false);
  }
  if(this.GetIsMaximized(index)) {
   this.CorrectScrollPositionOnAndroid(index, true);
   this.UpdateMaximizedWindowSizeOnResize(index);
  }
 },
 CorrectScrollPositionOnAndroid: function(index, checkElementIsInPopup) {
  if(ASPx.Browser.AndroidMobilePlatform) {
   var activeElement = this.GetActiveElementIncludingIframes();
   if(activeElement && (activeElement.tagName === "INPUT" || activeElement.tagName === "TEXTAREA") &&
    (!checkElementIsInPopup || this.GetWindowElement(index).contains(activeElement)))
    window.setTimeout(function() {
     if(activeElement.scrollIntoViewIfNeeded)
      activeElement.scrollIntoViewIfNeeded();
    }, 100);
  }
 },
 GetActiveElementIncludingIframes: function(document) {
  document = document || window.document;
  if(document.body === document.activeElement || document.activeElement.tagName === "IFRAME") {
   var iframes = document.getElementsByTagName("iframe");
   for(var i = 0; i < iframes.length; i++) {
    var iFrameDocument = null;
    try {
     iFrameDocument = iframes[i].contentWindow.document;
    }
    catch(e) {  }
    if(iFrameDocument !== null) {
     var focused = this.GetActiveElementIncludingIframes(iframes[i].contentWindow.document);
     if(focused !== false) {
      return focused;
     }
    }
   }
  } else 
   return document.activeElement;
  return false;
 },
 OnModalWrapperScroll: function(e, index) {
  if(!this.GetAdaptiveModalMode(index) || this.IsWrapperScrollEventLocked()) return;
  this.ChangeHeaderFixed(index);
  this.ChangeFooterFixed(index);
 },
 OnModalWrapperTouchStart: function(e) {
  this.touchStartY = e.touches[0].clientY;
 },
 OnModalWrapperTouchMove: function (e, index) {
  if(e.touches.length > 1)
   return;
  var preventScroll = this.RequirePreventScrollForAdaptiveMode(e, index);
  if(preventScroll)
   ASPx.Evt.PreventEvent(e);
  this.touchStartY = e.touches[0].clientY;
 },
 RequirePreventScrollForAdaptiveMode: function(e, index) {
  var modalWrapper = this.GetModalWrapperElement(index),
   zoom = modalWrapper.offsetWidth / window.innerWidth,
   activeElement = document.activeElement,
   activeTyping = !!activeElement && (activeElement["type"] === "text" || activeElement["type"] === "textarea"); 
  if(zoom !== 1 || activeTyping)
   return false;
  var currentY = e.touches[0].clientY,
   preventScroll = currentY > this.touchStartY && modalWrapper.scrollTop === 0 ||
    currentY < this.touchStartY && modalWrapper.scrollTop + modalWrapper.clientHeight >= modalWrapper.scrollHeight;
  if(!preventScroll)
   return false;
  var targetElement = ASPx.Evt.GetEventSource(e),
   contentWrapper = this.GetWindowContentWrapperElement(index);
  while(targetElement && targetElement !== contentWrapper && targetElement.tagName !== 'BODY') {
   if(this.ElementHasScroll(targetElement))
    return false;
   targetElement = targetElement.parentNode;
  }
  return true;
 },
 ElementHasScroll: function(elem) {
  var style = window.getComputedStyle(elem);
  return ["overflow", "overflow-x", "overflow-y"].some(function(prop) {
   return ASPx.Data.ArrayContains(["scroll","auto"], style[prop]);
  });
 },
 GetFixedHeaderMaxBottom: function(index) {
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  return ASPx.GetAbsolutePositionY(contentWrapper) + contentWrapper.offsetHeight;
 },
 GetFixedFooterMaxTop: function(index) {
  var header = this.GetWindowHeaderElement(index),
   contentWrapper = this.GetWindowContentWrapperElement(index),
   headerBottom = !!header ? ASPx.GetAbsolutePositionY(header) + header.offsetHeight : ASPx.GetAbsolutePositionY(contentWrapper);
  return window.innerHeight - headerBottom;
 },
 ChangeHeaderFixed: function(index) {
  if(!this.GetFixedHeader(index)) return;
  var element = this.GetWindowElement(index),
   modalWrapper = this.GetModalWrapperElement(index),
   isHeaderPartiallyHidden = modalWrapper.scrollTop > element.offsetTop,
   maxBottom = isHeaderPartiallyHidden ? this.GetFixedHeaderMaxBottom(index) : 0;
  this.FixateHeader(index, isHeaderPartiallyHidden, maxBottom);
 },
 ChangeFooterFixed: function(index) {
  if(!this.GetFixedFooter(index) || !this.GetWindowFooterElement(index)) return;
  var element = this.GetWindowElement(index),
   modalWrapper = this.GetModalWrapperElement(index),
   isFooterPartiallyHidden = element.offsetTop + element.offsetHeight - modalWrapper.scrollTop > window.innerHeight,
   maxTop = isFooterPartiallyHidden ? this.GetFixedFooterMaxTop(index) : 0;
  this.FixateFooter(index, isFooterPartiallyHidden, maxTop);
 },
 ChangeHeaderFooterFixed: function(index, elementToFix, isFixed, fixedClassName, offsetName, maxPos) {
  if(!elementToFix) return;
  var element = this.GetWindowElement(index),
   contentWrapper = this.GetWindowContentWrapperElement(index),
   changeClassNameFunc = isFixed ? ASPx.AddClassNameToElement : ASPx.RemoveClassNameFromElement,
   elementToFixHeight = elementToFix.offsetHeight;
  if(isFixed) {
   var borderOwner = this.GetWindowBorderOwnerElement(element),
    width = ASPx.GetClearClientWidth(borderOwner);
   ASPx.SetOffsetWidth(elementToFix, width);
   elementToFix.style[offsetName] = maxPos < elementToFixHeight ? maxPos - elementToFixHeight + "px" : "";
  } else
   elementToFix.style.width = "";
  contentWrapper.style["margin-" + offsetName] = isFixed ? elementToFixHeight + "px" : 0;
  changeClassNameFunc(elementToFix, fixedClassName);
 },
 FixateFooter: function(index, isFixed, maxTop) {
  this.ChangeHeaderFooterFixed(index, this.GetWindowFooterElement(index), isFixed, "dxFixedFooter", "bottom", maxTop);
 },
 FixateHeader: function(index, isFixed, maxBottom) {
  this.ChangeHeaderFooterFixed(index, this.GetWindowHeaderElement(index), isFixed, "dxFixedHeader", "top", maxBottom);
 },
 LockWrapperScrollEvent: function() {
  this.wrapperScrollEventLocked = true;
 },
 UnlockWrapperScrollEventEvent: function() {
  this.wrapperScrollEventLocked = false;
 },
 IsWrapperScrollEventLocked: function() {
  return this.wrapperScrollEventLocked;
 },
 ResetScroll: function(index) {
  if(!this.GetAdaptiveModalMode(index)) return;
  this.LockWrapperScrollEvent();
  this.GetModalWrapperElement(index).scrollTop = 0;
  this.UnlockWrapperScrollEventEvent();
 },
 AdjustModalElementBounds: function(element) {
  if(!ASPx.IsExistsElement(element)) return;
  ASPx.SetStyles(element, {
   left: 0,
   top: 0,
   right: 0,
   bottom: 0,
   width: "",
   height: ""
  });
 },
 RefreshPopupElementConnection: function() {
  ASPxClientPopupControlBase.prototype.RefreshPopupElementConnection.call(this);
 }
});
ASPxClientPopupControl.AligmentCalculator = (function() {
 function CalculateTopMargin(verticalAlign, elementHeight, defaultOffset) {
  if(verticalAlign === ModalAlign.WindowTop)
   return "";
  if(elementHeight < window.innerHeight) {
   var freeSpace = window.innerHeight - elementHeight;
   switch(verticalAlign) {
    case ModalAlign.WindowCenter:
     return freeSpace / 2;
    case ModalAlign.WindowBottom:
     return freeSpace - defaultOffset;
   }
  }
  return "";
 }
 function CalculateLeftRightMargin(horizontalAlign, forAligmenment, wrapperPadding) {
  if(horizontalAlign === forAligmenment) {
   if(ASPx.PxToInt(wrapperPadding) !== 0)
    return 0;
   return 10;
  }
  return "";
 }
 return {
  CalculateTopMargin: CalculateTopMargin,
  CalculateLeftRightMargin: CalculateLeftRightMargin
 };
})();
ASPxClientPopupControl.Animation = (function() {
 function GetVerticalDirection(verticalAlign, horizontalAlign) {
  switch(verticalAlign) {
   case ModalAlign.WindowTop:
    return -1;
   case ModalAlign.WindowCenter:
    if(horizontalAlign === ModalAlign.WindowCenter)
     return -1;
    return 0;
   case ModalAlign.WindowBottom:
    return 1;
  }
 }
 function GetHorizontalDirection(horizontalAlign) {
  switch(horizontalAlign) {
   case ModalAlign.WindowLeft:
    return -1;
   case ModalAlign.WindowCenter:
    return 0;
   case ModalAlign.WindowRight:
    return 1;
  }
 }
 function NeedFadeAnimation(horizontalAlign, verticalAlign, animationType, popupHorizontalAlign, popupVerticalAlign, adaptiveModalMode) {
  if(animationType === ASPxClientPopupControlBase.AnimationType.Auto) {
   if(adaptiveModalMode)
    return horizontalAlign === ModalAlign.WindowCenter && verticalAlign === ModalAlign.WindowCenter;
   else
    return popupHorizontalAlign === ASPx.PopupUtils.WindowCenterAlignIndicator && popupVerticalAlign === ASPx.PopupUtils.WindowCenterAlignIndicator;
  }
  return false;
 }
 return {
  GetVerticalDirection: GetVerticalDirection,
  GetHorizontalDirection: GetHorizontalDirection,
  NeedFadeAnimation: NeedFadeAnimation
 };
})();
ASPxClientPopupControl.WindowResizeHelper = (function() {
 var previousInnerWidth = 0,
  previousMargin = 0;
 function AdjustModalOnWindowResize(element) {
  var offsetLeft = element.offsetLeft,
   offsetWidth = element.offsetWidth,
   windowWidth = window.innerWidth,
   expectedLeft = windowWidth / 2 - offsetWidth / 2,
   toTheRightOfCenter = offsetLeft > expectedLeft,
   dw = windowWidth - previousInnerWidth,
   computedStyle = getComputedStyle(element),
   left = ASPx.PxToFloat(computedStyle.left),
   currentMargin = ASPx.PxToFloat(computedStyle.marginLeft),
   dm = currentMargin - previousMargin,
   newLeft = left - dm;
  if(toTheRightOfCenter)
   newLeft += dw;
  ASPx.SetStyles(element, { left: newLeft + "px" });
  if(Math.abs(offsetLeft - expectedLeft) <= 10 || dw < 0 && toTheRightOfCenter !== (element.offsetLeft > expectedLeft)) {
   ASPx.SetStyles(element, { left: "" });
   ASPx.Attr.RestoreStyleAttribute(element, "top");
   ASPx.Attr.RestoreStyleAttribute(element, "margin-top");
   return true;
  }
  previousMargin = currentMargin;
  previousInnerWidth = windowWidth;
  return false;
 }
 function Initialize(element) {
  previousInnerWidth = window.innerWidth;
  ASPx.Attr.ChangeStyleAttribute(element, "top", element.offsetTop + "px");
  ASPx.Attr.ChangeStyleAttribute(element, "margin-top", "0");
  previousMargin = ASPx.PxToFloat(getComputedStyle(element).marginLeft);
 }
 return {
  Initialize: Initialize,
  AdjustModalOnWindowResize: AdjustModalOnWindowResize
 };
})();
ASPxClientPopupControl.Cast = ASPxClientControl.Cast;
ASPxClientPopupControl.GetPopupControlCollection = function() {
 return aspxGetPopupControlCollection();
};
var ASPxClientPopupWindow = ASPx.CreateClass(null, {
 constructor: function(popupControl, index, name) {
  this.popupControl = popupControl;
  this.index = index;
  this.name = name;
 },
 GetHeaderImageUrl: function() {
  return this.popupControl.GetWindowHeaderImageUrl(this.index);
 },
 SetHeaderImageUrl: function(value) {
  this.popupControl.SetWindowHeaderImageUrl(this.index, value);
 },
 GetFooterImageUrl: function() {
  return this.popupControl.GetWindowFooterImageUrl(this.index);
 },
 SetFooterImageUrl: function(value) {
  this.popupControl.SetWindowFooterImageUrl(this.index, value);
 },
 GetHeaderNavigateUrl: function() {
  return this.popupControl.GetWindowHeaderNavigateUrl(this.index);
 },
 SetHeaderNavigateUrl: function(value) {
  this.popupControl.SetWindowHeaderNavigateUrl(this.index, value);
 },
 GetFooterNavigateUrl: function() {
  return this.popupControl.GetWindowFooterNavigateUrl(this.index);
 },
 SetFooterNavigateUrl: function(value) {
  this.popupControl.SetWindowFooterNavigateUrl(this.index, value);
 },
 GetHeaderText: function() {
  return this.popupControl.GetWindowHeaderText(this.index);
 },
 SetHeaderText: function(value) {
  this.popupControl.SetWindowHeaderText(this.index, value);
 },
 GetFooterText: function() {
  return this.popupControl.GetWindowFooterText(this.index);
 },
 SetFooterText: function(value) {
  this.popupControl.SetWindowFooterText(this.index, value);
 }
});
var ASPxClientPopupWindowEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(window) {
  this.constructor.prototype.constructor.call(this);
  this.window = window;
 }
});
var ASPxClientPopupWindowCancelEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(window, closeReason) {
  this.constructor.prototype.constructor.call(this);
  this.window = window;
  this.closeReason = closeReason;
 }
});
var ASPxClientPopupWindowCloseUpEventArgs = ASPx.CreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function(window, closeReason) {
  this.constructor.prototype.constructor.call(this, window);
  this.closeReason = closeReason;
 }
});
var ASPxClientPopupWindowResizeEventArgs = ASPx.CreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function(window, resizeState) {
  this.constructor.prototype.constructor.call(this, window);
  this.resizeState = resizeState;
 }
});
var ASPxClientPopupWindowPinnedChangedEventArgs = ASPx.CreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function(window, pinned) {
  this.constructor.prototype.constructor.call(this, window);
  this.pinned = pinned;
 }
});
var ASPxClientPopupControlCollection = ASPx.CreateClass(ASPxClientControlCollection, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.draggingControl = null;
  this.draggingWindowIndex = -1;
  this.gragXOffset = 0;
  this.gragYOffset = 0;
  this.visibleModalElements = [];
  this.visiblePopupWindowIds = [];
  this.windowResizeByBodyScrollVisibilityChangingLockCount = 0;
  this.savedBodyWidth = 0;
  this.savedBodyHeight = 0;
  this.overControl = null;
  this.overWindowIndex = -1;
  this.overXPos = ASPx.InvalidPosition;
  this.overYPos = ASPx.InvalidPosition;
  this.appearTimerID = -1;
  this.disappearTimerID = -1;
  this.scrollEventLockCount = 0;
  this.currentActiveWindowElement = null;
  this.resizeControl = null;
  this.resizeIndex = -2;
  this.resizeCursor = "";
  this.resizePanel = null;
  this.selectBanned = false;
  this.pcWindowsAreRestrictedByDocumentWindow = true;
  this.docScrollLeft = -1;
  this.docScrollTop = -1;
  this.EnsureSaveScrollState();
 },
 GetCollectionType: function(){
  return "Popup";
 },
 Remove: function(popupControl) {
  for(var i = this.visibleModalElements.length - 1; i >= 0; i--) {
   var modalElement = this.visibleModalElements[i];
   if(modalElement && modalElement.DXModalPopupControl === popupControl)
    this.UnregisterVisibleModalElement(modalElement);
  }
  for(var j = this.visiblePopupWindowIds.length - 1; j >= 0; j--) {
   var id = this.visiblePopupWindowIds[j];
   if(!ASPx.IsExists(id)) continue;
   var popupWindow = this.GetPopupWindowFromID(id);
   if(popupWindow.popupControl === popupControl) {
    var windowElement = popupControl.GetWindowElement(popupWindow.windowIndex);
    if(windowElement)
     this.UnregisterVisibleWindow(windowElement);
    else
     ASPx.Data.ArrayRemove(this.visiblePopupWindowIds, id);
   }
  }
  ASPxClientControlCollection.prototype.Remove.call(this, popupControl);
 },
 EnsureSaveScrollState: function() {
  if(ASPx.documentLoaded && this.docScrollLeft < 0 && this.docScrollTop < 0)
   this.SaveScrollState();
 },
 GetPopupWindowFromID: function(id) {
  var pos = id.lastIndexOf(ASPx.PCWIdSuffix);
  var name = id.substring(0, pos);
  var index = id.substr(pos + ASPx.PCWIdSuffix.length);
  var popupControl = aspxGetPopupControlCollection().Get(name);
  return { popupControl: popupControl, windowIndex: index };
 },
 DoHideAllWindows: function(srcElement, excptId, applyToAll, closeReason, posX) {
  for(var i = this.visiblePopupWindowIds.length - 1; i >= 0; i--) {
   var id = this.visiblePopupWindowIds[i];
   if(id == excptId) continue;
   var popupWindow = this.GetPopupWindowFromID(id),
    windowIndex = popupWindow.windowIndex,
    popupControl = popupWindow.popupControl;
   if(!popupControl.CanBeClosedByClickOnElement(windowIndex, srcElement, posX, id)) continue;
   if(popupControl != null) {
    var popupWindowZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(popupControl.GetWindowElement(windowIndex));
    var isPopupHigherSrcElement = ASPx.PopupUtils.IsHigher(popupWindowZIndexArray, ASPx.PopupUtils.GetElementZIndexArray(srcElement)) || !popupControl.HasDefaultWindow();
    var windowCloseAction = popupControl.GetWindowCloseAction(windowIndex);
    if ((windowCloseAction != "CloseButton" && windowCloseAction != "None") && isPopupHigherSrcElement || applyToAll)
     popupControl.DoHideWindow(parseInt(windowIndex), false, closeReason);
   }
  }
 },
 RefreshModalRenderInIe: function() {
  if(ASPx.Browser.IE && ASPx.Browser.Version === 11 && this.visibleModalElements.length > 0) {
   var topModalWindow = this.GetTopModalWindow();
   if(topModalWindow) {
    var popupWindow = this.GetPopupWindowFromID(topModalWindow.id),
     windowIndex = popupWindow.windowIndex,
     popupControl = popupWindow.popupControl;
    if(popupControl)
     popupControl.RefreshModalRenderInIe(windowIndex);
   }
  }
 },
 DoShowAtCurrentPos: function(name, index, popupElementIndex, evtClone) {
  var pc = this.Get(name);
  if(pc != null && !pc.InternalIsWindowVisible(index))
   pc.DoShowWindowCore(index, this.overXPos, this.overYPos, popupElementIndex, true, true, evtClone, ASPxClientPopupControlCloseReason.MouseOut);
 },
 WindowZIndexWasInitialized: function(zIndex, pcZIndex) {
  return pcZIndex <= zIndex;
 },
 ActivateWindowElement: function(element, evt, popupType, defZIndex, zIndex) {
  var maxZIndex = this.GetMaxZIndex(popupType, defZIndex),
   topZIndex = this.WindowZIndexWasInitialized(maxZIndex, zIndex) ? parseInt(maxZIndex) : zIndex;
  if(this.WindowZIndexWasInitialized(element.style.zIndex, zIndex) && element.style.zIndex != topZIndex) {
   this.DeleteWindowFromZIndexOrder(element);
  }
  if(!this.WindowZIndexWasInitialized(element.style.zIndex, zIndex))
   topZIndex += 2;
  var popupWindow = this.GetPopupWindowFromID(element.id);
  popupWindow.popupControl.SetWindowElementZIndex(element, topZIndex);
  var pcWElementEventSource = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupWindowElement);
  if(!evt || (evt && pcWElementEventSource == element)) { 
   if(this.GetCurrentActiveWindowElement() != element) {
    this.RefreshTabIndexes(false);
    this.SaveCurrentActiveWindowElement(element);
   }
  }
 },
 RefreshTabIndexes: function(forceRecalculate) {
  var topModalWindow = this.GetTopModalWindow();
  if(topModalWindow != null || forceRecalculate) {
   var topModalWindowZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(topModalWindow);
   this.CalculateTabIndexes(topModalWindowZIndexArray);
  }
 },
 ElementHasTabIndex: function(element) {
  return ASPx.IsExists(ASPx.Attr.GetAttribute(element, "tabindex"));
 },
 IsElementCanBeActive: function(element) { 
  return element.tagName === "INPUT" || element.tagName === "A" ||
   element.tagName === "BUTTON" || element.tagName === "TEXTAREA" ||
   element.tagName === "SELECT" || this.ElementHasTabIndex(element);
 },
 GetCanBeActiveElements: function() { 
  var elements = document.getElementsByTagName("*"),
   canBeActiveElements = [];
  for(var i = 0; i < elements.length; i++) {
   if(this.IsElementCanBeActive(elements[i]))
    canBeActiveElements.push(elements[i]);
  }
  return canBeActiveElements;
 },
 GetEditableDivs: function(){
  if(document.querySelectorAll)
   return document.querySelectorAll("div[contenteditable=true]");
  var editableDivs = [ ];
  var allDivs = document.getElementsByTagName("DIV");
  for(var i = 0; i < allDivs.length; i++){
   var div = allDivs[i];
   if(div.getAttribute("contenteditable") == 'true')
    editableDivs.push(div);
  }
  return editableDivs;
 },
 CalculateTabIndexes: function(topModalWindowZIndexArray) {
  var elements = this.GetCanBeActiveElements();
  for(var i = 0; i < elements.length; i++) {
   var currentElementZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(elements[i]),
    manager = ASPx.ControlTabIndexManager.getInstance(),
    tabIndexManagerGroupId = "pcCollection";
   if(ASPx.PopupUtils.IsHigher(currentElementZIndexArray, topModalWindowZIndexArray))
    manager.restoreTabIndexAttribute(elements[i], tabIndexManagerGroupId);
   else
    manager.changeTabIndexAttribute(elements[i], tabIndexManagerGroupId);
  }
 },
 PopupWindowIsModalByVisibleIndex: function(visiblePopupWindowIndex) {
  return this.PopupWindowIsModalByID(this.visiblePopupWindowIds[visiblePopupWindowIndex]);
 },
 PopupWindowIsModalByID: function(windowElementID) {
  var popupWindow = this.GetPopupWindowFromID(windowElementID);
  return popupWindow.popupControl.WindowIsModal(popupWindow.windowIndex);
 },
 SaveCurrentActiveWindowElement: function(windowElement) {
  this.currentActiveWindowElement = windowElement;
 },
 SkipCurrentActiveWindowElement: function(element) {
  if(element == this.GetCurrentActiveWindowElement())
   this.SaveCurrentActiveWindowElement(null);
 },
 GetCurrentActiveWindowElement: function() {
  return this.currentActiveWindowElement;
 },
 GetMaxZIndex: function (type, defaultZIndex) {
  var maxZIndex = defaultZIndex;
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var id = this.visiblePopupWindowIds[i];
   if(type !== undefined && this.GetPopupWindowFromID(id).popupControl.GetPopupType() !== type)
    continue;
   var currentWindow = ASPx.GetElementById(id);
   if(!!currentWindow && ASPx.IsElementVisible(currentWindow) && currentWindow.style && currentWindow.style.zIndex > maxZIndex)
    maxZIndex = currentWindow.style.zIndex;
  }
  return maxZIndex;
 },
 GetTopModalWindow: function() {
  return this.GetTopWindow(true);
 },
 GetTopWindow: function(onlyModal) {
  var topWindow = null;
  var topWindowZIndexArray = null;
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var currentWindow = ASPx.GetElementById(this.visiblePopupWindowIds[i]);
   if(onlyModal && !this.PopupWindowIsModalByVisibleIndex(i))
    continue;
   if(ASPx.IsElementVisible(currentWindow)) {
    var currentWindowZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(currentWindow);
    if(topWindow == null || ASPx.PopupUtils.IsHigher(currentWindowZIndexArray, topWindowZIndexArray)) {
     topWindow = currentWindow;
     topWindowZIndexArray = currentWindowZIndexArray;
    }
   }
  }
  return topWindow;
 },
 DeleteWindowFromZIndexOrder: function(element) {
  for(var i = this.visiblePopupWindowIds.length - 1; i >= 0; i--) {
   var windowElement = ASPx.GetElementById(this.visiblePopupWindowIds[i]);
   if(!windowElement)
    ASPx.Data.ArrayRemoveAt(this.visiblePopupWindowIds, i);
   else if(windowElement.style.zIndex > element.style.zIndex) {
    var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
    popupWindow.popupControl.SetWindowElementZIndex(windowElement, windowElement.style.zIndex - 2);
   }
  }
 },
 AdjustModalElementsBounds: function() {
  for(var i = 0; i < this.visibleModalElements.length; i++)
   this.visibleModalElements[i].DXModalPopupControl.AdjustModalElementBounds(this.visibleModalElements[i]);
 },
 ClearAppearTimer: function() {
  this.appearTimerID = ASPx.Timer.ClearTimer(this.appearTimerID);
 },
 ClearDisappearTimer: function() {
  this.disappearTimerID = ASPx.Timer.ClearTimer(this.disappearTimerID);
 },
 IsAppearTimerActive: function() {
  return this.appearTimerID > -1;
 },
 IsDisappearTimerActive: function() {
  return this.disappearTimerID > -1;
 },
 SetAppearTimer: function(name, index, popupElementIndex, timeout, evt) {
  var evtClone = ASPx.CloneObject(evt);
  this.appearTimerID = window.setTimeout(function() {
   aspxGetPopupControlCollection().DoShowAtCurrentPos(name, index, popupElementIndex, evtClone);
  }, timeout);
 },
 SetDisappearTimer: function(name, index, timeout) {
  this.disappearTimerID = window.setTimeout(function() {
   aspxGetPopupControlCollection().OnPWDisappearTimer(name, index);
  }, timeout);
 },
 GetDocScrollDifference: function() {
  return new _aspxScrollDifference(ASPx.GetDocumentScrollLeft() - this.docScrollLeft, ASPx.GetDocumentScrollTop() - this.docScrollTop);
 },
 IsDocScrolled: function(scroll) {
  return scroll.horizontal != 0 || scroll.vertical != 0;
 },
 SaveScrollState: function() {
  this.docScrollLeft = ASPx.GetDocumentScrollLeft();
  this.docScrollTop = ASPx.GetDocumentScrollTop();
 },
 InitDragObject: function(control, index, x, y, xClientCorrection, yClientCorrection) {
  this.draggingControl = control;
  this.draggingWindowIndex = index;
  this.gragXOffset = x;
  this.gragYOffset = y;
  this.xClientCorrection = xClientCorrection;
  this.yClientCorrection = yClientCorrection;
  this.SetDocumentSelectionBan(true);
 },
 InitOverObject: function(control, index, evt) {
  this.overControl = control;
  this.overWindowIndex = index;
  if(evt)
   this.SaveCurrentMouseOverPos(evt);
 },
 InitResizeObject: function(control, index, cursor, resizePanel) {
  this.resizeControl = control;
  this.resizeIndex = index;
  this.resizeCursor = cursor;
  this.resizePanel = resizePanel;
  this.SetDocumentSelectionBan(true);
 },
 SetDocumentSelectionBan: function(value) {
  if(this.selectBanned === value)
   return;
  this.selectBanned = value;
  if(ASPx.Browser.WebKitFamily) {
   if(value) {
    if(!this.webkitUserSelectBackup && document.body.style.webkitUserSelect)
     this.webkitUserSelectBackup = document.body.style.webkitUserSelect;
    document.body.style.webkitUserSelect = "none";
   } else {
    if(this.webkitUserSelectBackup) {
     document.body.style.webkitUserSelect = this.webkitUserSelectBackup;
     delete this.webkitUserSelectBackup;
    } else
     document.body.style.webkitUserSelect = "auto";
   }
  }
 },
 IsResizeInint: function() {
  return this.resizeControl != null;
 },
 ClearDragObject: function() {
  this.draggingControl = null;
  this.draggingWindowIndex = -1;
  this.gragXOffset = 0;
  this.gragYOffset = 0;
  this.SetDocumentSelectionBan(this.resizeControl != null);
 },
 ClearResizeObject: function() {
  this.resizeControl = null;
  this.resizeIndex = -2;
  this.resizeCursor = "";
  this.SetDocumentSelectionBan(this.draggingControl != null);
  this.resizePanel.parentNode.removeChild(this.resizePanel);
 },
 Drag: function(evt) {
  if(ASPx.tableColumnResizing || ASPx.currentDragHelper || !ASPx.Evt.IsLeftButtonPressed(evt)) return;
  var x = ASPx.Evt.GetEventX(evt);
  var y = ASPx.Evt.GetEventY(evt);
  if(this.pcWindowsAreRestrictedByDocumentWindow && ASPx.PopupUtils.CoordinatesInDocumentRect(x, y)) {
   x += this.gragXOffset;
   y += this.gragYOffset;
   this.draggingControl.OnDrag(this.draggingWindowIndex, x, y, this.xClientCorrection, this.yClientCorrection, evt);
   if(ASPx.Browser.WebKitTouchUI)
    ASPx.Evt.PreventEvent(evt);
  }
 },
 DragStop: function() {
  this.draggingControl.OnDragStop(this.draggingWindowIndex);
  this.ClearDragObject();
 },
 ResizeStop: function(evt) {
  this.resizeControl.OnResizeStop(evt, this.resizeIndex, this.resizeCursor, this.resizePanel);
  aspxGetPopupControlCollection().ClearResizeObject();
 },
 setIframesMouseMoveEnabled: function(enabled) {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(popupControl) {
    var iframe = popupControl.GetWindowContentIFrameElement(popupWindow.windowIndex);
    if(iframe) {
     iframe.style.pointerEvents = enabled ? "" : "none";
     if(ASPx.Browser.IE && ASPx.Browser.MajorVersion < 11) {
      if(enabled)
       popupControl.RemoveIframeCoverDiv(iframe, popupWindow.windowIndex);
      else
       popupControl.CreateIframeCoverDiv(iframe, popupWindow.windowIndex);
     }
    }
   }
  }
 },
 OnPWMouseMove: function(evt, name, index) {
  if(this.draggingControl == null &&
   this.overControl == null &&
   this.resizeControl == null) {
   var pc = aspxGetPopupControlCollection().Get(name);
   if(pc != null) pc.OnMouseMove(evt, index);
  }
 },
 OnPWMouseOver: function(evt) {
  if(!this.overControl || this.draggingControl) return;
  if(this.IsOverPopupWindow(evt))
   this.ClearDisappearTimer();
 },
 IsOverPopupWindow: function(evt) {
  return ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlOverElement) != null;
 },
 OnDocumentKeyDown: function(evt) {
  var windowElement = this.GetTopWindow(false);
  if(windowElement) {
   var window = this.GetPopupWindowFromID(windowElement.id);
   if(window.popupControl);
    window.popupControl.OnDocumentKeyDown(evt, windowElement);
  }
 },
 OnDocumentMouseDown: function(evt) {
  var popupElement = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlElement);
  var excptId = popupElement == null ? "" :
   popupElement.DXPopupElementControl.GetWindowElementId(popupElement.DXPopupWindowIndex);
  this.OnMouseDownCore(evt, excptId);
 },
 OnMouseDown: function(evt) {
  this.OnMouseDownCore(evt, "");
 },
 OnMouseDownCore: function(evt, excptId) {
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.DoHideAllWindows(srcElement, excptId, false, ASPxClientPopupControlCloseReason.OuterMouseClick, ASPx.Evt.GetEventX(evt));
  aspxGetPopupControlCollection().ClearAppearTimer();
 },
 OnMouseMove: function (evt) {
  if(ASPx.Browser.WebKitTouchUI && ASPx.TouchUIHelper.isGesture)
   return;
  if(this.draggingControl != null) {
   this.Drag(evt);
  }
  else if(this.overControl != null) {
   this.OnMouseOver(evt);
  }
  else if(this.resizeControl != null) {
   if(ASPx.Browser.IE && !ASPx.Evt.IsLeftButtonPressed(evt))
    this.ResizeStop(evt);
   else
    this.resizeControl.OnResize(evt, this.resizeIndex, this.resizeCursor, this.resizePanel);
  }
 },
 OnMouseOver: function(evt) {
  var element = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlOverElement);
  var curPopupElement = this.overControl.GetWindowCurrentPopupElementByIndex(this.overWindowIndex);
  var popup = element != null ? element.DXPopupElementControl : null;
  var isPopupActionMouseOver = popup && popup.GetWindowPopupAction(this.overWindowIndex) == 'MouseOver';
  var isCurPopupElement = element !== null && element === curPopupElement;
  var isCurPopupWindow = element != null && element.id === this.overControl.GetWindowElementId(this.overWindowIndex);
  var isCurPopupElementOrCurPopupWindow = isCurPopupElement || isCurPopupWindow || isPopupActionMouseOver;
  if(isCurPopupElementOrCurPopupWindow) {
   var clearTimer = true;
   popup = element.DXPopupElementControl;
   if(popup && popup.GetLastShownPopupElementIndex(element.DXPopupWindowIndex) != element.DXPopupElementIndex)
    clearTimer = false;
   if(clearTimer)
    this.ClearDisappearTimer();
   this.SaveCurrentMouseOverPos(evt);
   return;
  }
  this.OnMouseOut();
 },
 OnMouseOut: function(evt) {
  if(!this.overControl || this.draggingControl) return;
  this.ClearAppearTimer();
  var windowCloseAction = this.overControl.GetWindowCloseAction(this.overWindowIndex);
  if(windowCloseAction == "MouseOut" && this.overControl.InternalIsWindowVisible(this.overWindowIndex)) {
   if(!this.IsDisappearTimerActive() && this.IsDisappearAllowedByMouseOut(evt))
    this.SetDisappearTimer(this.overControl.name, this.overWindowIndex, this.overControl.disappearAfter);
  }
  else
   this.OverStop();
 },
 IsDisappearAllowedByMouseOut: function(evt) {
  return ASPx.Browser.Firefox || ASPx.Browser.Chrome ? !this.IsOverPopupWindow(evt) : true;  
 },
 OnMouseUp: function(evt) {
  if(this.draggingControl != null)
   this.DragStop();
  if(this.resizeControl != null)
   this.ResizeStop(evt);
 },
 OnResize: function(evt) {
  this.AutoUpdateElementsPosition();
  this.AdjustModalElementsBounds();
 },
 OnScroll: function(evt) {
  if(this.scrollEventLockCount > 0)
   return;
  var scroll = this.GetDocScrollDifference();
  if(this.IsDocScrolled(scroll)) { 
   this.CorrectPositionAtScroll(scroll);
   this.AdjustModalElementsBounds();
   this.SaveScrollState();
  }
  this.CalculateDocumentDimensionsWithoutPinnedWindows(evt);
  this.FireScrollEventToWindows(evt);
 },
 GetSavedBodyWidth: function() {
  if(this.savedBodyWidth == 0)
   this.CalculateDocumentDimensionsWithoutPinnedWindows();
  return this.savedBodyWidth;
 },
 GetSavedBodyHeight: function() {
  if(this.savedBodyHeight == 0)
   this.CalculateDocumentDimensionsWithoutPinnedWindows();
  return this.savedBodyHeight;
 },
 HidePinnedPopupsThatOutFromViewPort: function() {
  var popupsToRestoreVisible = [];
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(!popupControl.needToHidePinnedOutFromViewPort(popupWindow.windowIndex))
    continue;
   var element = popupControl.GetWindowElement(popupWindow.windowIndex);
   if(!element) continue;
   var restoreData = {};
   restoreData.element = element;
   restoreData.display = element.style.display;
   element.style.display = "none";
   popupsToRestoreVisible.push(restoreData);
  }
  return popupsToRestoreVisible;
 },
 RestorePinnedPopupsThatOutFromViewPort: function(popupsToRestoreVisible) {
  if(popupsToRestoreVisible.length > 0) {
   for(var i = 0; i < popupsToRestoreVisible.length; i++) {
    var restoreData = popupsToRestoreVisible[i];
    restoreData.element.style.display = restoreData.display;
   }
  }
 },
 CalculateDocumentDimensionsWithoutPinnedWindows: function(evt) { 
  var popupsToRestoreVisible = [];
  var needToHideRestorePopupsThatOutFromViewPort = !!evt && ASPx.Evt.GetEventSource(evt) == document;
  if(needToHideRestorePopupsThatOutFromViewPort)
   popupsToRestoreVisible = this.HidePinnedPopupsThatOutFromViewPort();
  this.savedBodyWidth = ASPx.GetDocumentWidth();
  this.savedBodyHeight = ASPx.GetDocumentHeight();
  if(needToHideRestorePopupsThatOutFromViewPort)
   this.RestorePinnedPopupsThatOutFromViewPort(popupsToRestoreVisible);
 },
 FireScrollEventToWindows: function(evt) {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   popupControl.OnScroll(evt, popupWindow.windowIndex);
  }
 },
 CalculateDocumentDimensionsWithoutPinnedWindowsOldIE: function(onCalculateFinished, evt) {  
  var popupsToRestoreVisible = [];
  var needToHideRestorePopupsThatOutFromViewPort = !!evt && ASPx.Evt.GetEventSource(evt) == document;
  if(needToHideRestorePopupsThatOutFromViewPort)
   popupsToRestoreVisible = this.HidePinnedPopupsThatOutFromViewPort();
  this.scrollEventLockCount++;
  window.setTimeout(function() {
   this.savedBodyWidth = ASPx.GetDocumentWidth();
   this.savedBodyHeight = ASPx.GetDocumentHeight();
   if(needToHideRestorePopupsThatOutFromViewPort)
    this.RestorePinnedPopupsThatOutFromViewPort(popupsToRestoreVisible);
   if(onCalculateFinished)
    window.setTimeout(function() { onCalculateFinished(); }.aspxBind(this), 0);
   this.scrollEventLockCount--;
  }.aspxBind(this), 0);
 },
 FireScrollEventToWindowsOldIE: function(evt) {
  this.scrollEventLockCount++;
  this.FireScrollEventToWindows(evt);
  this.scrollEventLockCount--;
 },
 LockScrollEvent: function() {
  this.scrollEventLockCount++;
 },
 UnlockScrollEvent: function() {
  this.scrollEventLockCount--;
 },
 CorrectPositionAtScroll: function(scroll) {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(popupControl != null && popupControl.InternalIsWindowVisible(popupWindow.windowIndex)) {
    if(popupControl.GetAutoUpdatePosition(popupWindow.windowIndex))
     popupWindow.popupControl.TryAutoUpdatePosition(popupWindow.windowIndex);
   }
  }
 },
 OnSelectStart: function() {
  return !this.selectBanned;
 },
 OverStop: function() {
  this.overControl = null;
  this.overWindowIndex = -1;
 },
 OnPWDisappearTimer: function(name, index) {
  var pc = this.Get(name);
  if(pc != null) {
   if(!pc.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.MouseOut))
    this.OverStop();
   this.ClearDisappearTimer();
  }
 },
 SaveCurrentMouseOverPos: function(evt) {
  this.overXPos = ASPx.Evt.GetEventX(evt);
  this.overYPos = ASPx.Evt.GetEventY(evt);
 },
 RegisterVisibleModalElement: function(element) {
  if(ASPx.Data.ArrayIndexOf(this.visibleModalElements, element) == -1)
   this.visibleModalElements.push(element);
 },
 UnregisterVisibleModalElement: function(element) {
  ASPx.Data.ArrayRemove(this.visibleModalElements, element);
 },
 RegisterVisibleWindow: function(element, popupControl, index) {
  if(ASPx.Data.ArrayIndexOf(this.visiblePopupWindowIds, element.id) == -1) {
   this.visiblePopupWindowIds.push(element.id);
   if(popupControl && popupControl.GetWindowCloseAction(index) == "MouseOut")
    aspxGetPopupControlCollection().InitOverObject(popupControl, index, null);
   this.OnRegisteredVisibleWindow(element);
  }
 },
 OnRegisteredVisibleWindow: function(element) {
  var elementIndex = ASPx.Data.ArrayIndexOf(this.visiblePopupWindowIds, element.id);
  if(this.PopupWindowIsModalByVisibleIndex(elementIndex))
   ASPx.PopupUtils.RemoveFocus(element);
 },
 UnregisterVisibleWindow: function(element) {
  this.DeleteWindowFromZIndexOrder(element);
  ASPx.Data.ArrayRemove(this.visiblePopupWindowIds, element.id);
  var forceRecalculate = this.PopupWindowIsModalByID(element.id);
  this.RefreshTabIndexes(forceRecalculate);
  this.SkipCurrentActiveWindowElement(element);
 },
 AutoUpdateElementsPosition: function() {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(popupControl != null && popupControl.InternalIsWindowVisible(popupWindow.windowIndex))
    popupControl.TryAutoUpdatePosition(popupWindow.windowIndex);
  }
 },
 LockWindowResizeByBodyScrollVisibilityChanging: function() {
  this.windowResizeByBodyScrollVisibilityChangingLockCount++;
 },
 UnlockWindowResizeByBodyScrollVisibilityChanging: function() {
  this.windowResizeByBodyScrollVisibilityChangingLockCount--;
 },
 WindowResizeByBodyScrollVisibilityChangingLocked: function() {
  return this.windowResizeByBodyScrollVisibilityChangingLockCount > 0;
 },
 HideAllWindows: function() {
  this.DoHideAllWindows(null, "", true, ASPxClientPopupControlCloseReason.API, 0);
 }
});
var ASPxClientPopupControlResizeState = {
 Resized: 0,
 Collapsed: 1,
 Expanded: 2,
 Maximized: 3,
 RestoredAfterMaximized: 4
};
var ASPxClientPopupControlCloseReason = {
 API: "API",
 CloseButton: "CloseButton",
 OuterMouseClick: "OuterMouseClick",
 MouseOut: "MouseOut",
 Escape: "Escape"
};
var popupControlCollection = null;
function aspxGetPopupControlCollection() {
 if(popupControlCollection == null)
  popupControlCollection = new ASPxClientPopupControlCollection();
 return popupControlCollection;
}
function _aspxScrollDifference(horizontal, vertical) {
 this.horizontal = horizontal;
 this.vertical = vertical;
}
function aspxPWEMOver(evt) {
 aspxGetPopupControlCollection().OnPWMouseOver(evt);
}
ASPx.PWHMDown = function(evt) {
 return ASPx.Evt.CancelBubble(evt);
};
ASPx.PWCBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnCloseButtonClick");
};
ASPx.PWPBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnPinButtonClick");
};
ASPx.PWRBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnRefreshButtonClick");
};
ASPx.PWMNBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnCollapseButtonClick");
};
ASPx.PWMXBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnMaximizeButtonClick");
};
ASPx.PWDGMDown = function (evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 return ASPx.PWMDown(evt, name, index, pc.IsDraggingAllowed(index));
};
ASPx.PWGripMDown = function(evt, name, index) {
 aspxPWMDownCore(evt, name, index, false);
 return ASPx.PWHMDown(evt);
};
ASPx.PWMMove = function(evt, name, index) {
 aspxGetPopupControlCollection().OnPWMouseMove(evt, name, index);
};
ASPx.PWMDown = function(evt, name, index, isWindowContentDraggingAllowed) { 
 var pointOnScrollBar = false;
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc && pc.GetEnableContentScrolling(index)) {
  var rtl = pc.rtl && (ASPx.Browser.IE || ASPx.Browser.Firefox || ASPx.Browser.Opera);
  pointOnScrollBar = aspxPointOnElementScrollBar(pc.GetContentContainer(index), evt.clientX, evt.clientY, rtl);
 }
 aspxPWMDownCore(evt, name, index, isWindowContentDraggingAllowed, pointOnScrollBar);
 if(isWindowContentDraggingAllowed) { 
  aspxGetPopupControlCollection().OnDocumentMouseDown(evt); 
  if(typeof (ASPx.GetDropDownCollection) == "function")
   ASPx.GetDropDownCollection().OnDocumentMouseDown(evt); 
  if(!pointOnScrollBar) {
   if(!ASPx.Browser.WebKitTouchUI && ASPx.Evt.GetEventSource(evt).tagName == "IMG") 
    ASPx.Evt.PreventEvent(evt);
  }
 }
};
function aspxPWMDownCore(evt, name, index, isDraggingAllowed, pointOnScrollBar) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) {
  pc.OnActivate(index, evt);
  pc.OnMouseDown(evt, index, isDraggingAllowed, pointOnScrollBar);
 }
}
function aspxPWMEMDown(evt) {
 var internalScrollableModalDiv = ASPx.Browser.AndroidDefaultBrowser ? ASPx.Evt.GetEventSource(evt) : null;
 var modalDiv = internalScrollableModalDiv ? internalScrollableModalDiv.parentNode : ASPx.Evt.GetEventSource(evt);
 if(modalDiv != null) 
  modalDiv.DXModalPopupControl.OnMouseDownModalElement(evt, modalDiv.DXModalPopupWindowIndex);
}
function aspxPEMEvent(evt) {
 var element = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlElement);
 if(element != null) {
  var popupControl = element.DXPopupElementControl;
  var index = element.DXPopupWindowIndex;
  if(evt.type == "mousedown") {
   popupControl.SetIsPopuped(index, popupControl.InternalIsWindowVisible(index));
   aspxGetPopupControlCollection().OnMouseDown(evt);
  }
  else {
   var windowPopupAction = popupControl.GetWindowPopupAction(element.DXPopupWindowIndex);
   var leftMouseButtonAction = windowPopupAction == "LeftMouseClick" && ASPx.Evt.IsLeftButtonPressed(evt);
   var isAccessibleKeyboardAction = popupControl.accessibilityCompliant && ASPx.Evt.IsActionKeyPressed(evt);
   var rightMouseButtonAction = windowPopupAction == "RightMouseClick" && !ASPx.Evt.IsLeftButtonPressed(evt);
   if(leftMouseButtonAction || rightMouseButtonAction || isAccessibleKeyboardAction) {
    if(rightMouseButtonAction)
     ASPx.PopupUtils.PreventContextMenu(evt);
    var windowCloseAction = popupControl.GetWindowCloseAction(index);
    var isPopuped = popupControl.GetIsPopuped(index);
    var isNewPopupElement = popupControl.GetLastShownPopupElementIndex(index) != element.DXPopupElementIndex;
    if(isPopuped && isNewPopupElement) {
     popupControl.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.OuterMouseClick);
     aspxGetPopupControlCollection().ClearDisappearTimer();
     isPopuped = false;
    }
    if(!(isPopuped && windowCloseAction == "OuterMouseClick")) {
     popupControl.DoShowWindow(index, element.DXPopupElementIndex, evt);
    }
    if(windowCloseAction == "MouseOut")
     aspxGetPopupControlCollection().InitOverObject(popupControl, element.DXPopupWindowIndex, evt);
    return false;
   }
  }
 }
}
ASPx.PopupElementMouseEvent = aspxPEMEvent;
function aspxPointOnElementScrollBar(element, x, y, rtl) {
 var scrollWidth = ASPx.GetVerticalScrollBarWidth();
 var hasHorizontalScroll = element.scrollWidth > element.clientWidth;
 var hasVerticalScroll = element.scrollHeight > element.clientHeight;
 var ceilX = rtl ? ASPx.GetAbsoluteX(element) + scrollWidth :
  ASPx.GetAbsoluteX(element) + (element.offsetWidth - ASPx.GetHorizontalBordersWidth(element));
 var ceilY = ASPx.GetAbsoluteY(element) + (element.offsetHeight - ASPx.GetVerticalBordersWidth(element));
 return (hasVerticalScroll && x >= ceilX - scrollWidth && x <= ceilX) ||
   (hasHorizontalScroll && y >= ceilY - scrollWidth && y <= ceilY);
}
ASPx.PCAStop = function(name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnAnimationStop(index);
};
ASPx.PCIframeLoad = function(evt) {
 var srcElement = ASPx.Evt.GetEventSource(evt);
 if(srcElement) {
  var pcName = srcElement.popupControlName;
  var pcWndIndex = srcElement.pcWndIndex;
  if(pcName) {
   var pc = aspxGetPopupControlCollection().Get(pcName);
   if(pc) pc.OnIFrameLoad(pcWndIndex);
  }
 }
};
function aspxTestPopupWindowElement(element) {
 return !!element.DXPopupWindowElement;
}
function aspxTestPopupControlElement(element) {
 return element.DXPopupElementControl && ASPx.IsExists(element.DXPopupWindowIndex);
}
function aspxTestPopupControlOverElement(element) {
 var collection = aspxGetPopupControlCollection();
 var popupControl = collection.overControl;
 var index = collection.overWindowIndex;
 var windowId = popupControl.GetWindowElementId(index);
 if(element.id == windowId)
  return true;
 var popupElements = popupControl.GetPopupElementList(index);
 for(var i = 0; i < popupElements.length; i++)
  if(popupElements[i] == element)
   return true;
 return false;
}
ASPx.Evt.AttachEventToDocument("keydown", function(evt) {
 aspxGetPopupControlCollection().OnDocumentKeyDown(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
 aspxGetPopupControlCollection().OnDocumentMouseDown(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, function(evt) {
 return aspxGetPopupControlCollection().OnMouseUp(evt);
});
ASPx.Evt.AttachEventToElement(window, ASPx.TouchUIHelper.touchMouseMoveEventName, function(evt) {
 if(typeof(aspxGetPopupControlCollection) != "undefined")
  aspxGetPopupControlCollection().OnMouseMove(evt);
}, false, !ASPx.Browser.WebKitTouchUI);
ASPx.Evt.AttachEventToDocument("mouseout", function(evt) {
 if(typeof (aspxGetPopupControlCollection) != "undefined")
  aspxGetPopupControlCollection().OnMouseOut(evt);
});
 ASPx.Evt.AttachEventToElement(window, "resize", function(evt) {
 aspxGetPopupControlCollection().OnResize(evt);
});
ASPx.Evt.AttachEventToElement(window, "scroll", function(evt) {
 aspxGetPopupControlCollection().OnScroll(evt);
});
ASPx.Evt.AttachEventToDocument("selectstart", function(evt) {
 var ret = aspxGetPopupControlCollection().OnSelectStart(evt);
 if(!ret) return false; 
});
var currViewPortSize = null,
 viewPortSizeInterval = null;
function getViewPortSize() {
 return { 
  w: window.innerWidth, 
  h: window.innerHeight,
  x: window.pageXOffset,
  y: window.pageYOffset
 }; 
}
function ensureViewPortSizeInterval() {
 if(!!viewPortSizeInterval) return;
 viewPortSizeInterval = setInterval(function() {
  var size = getViewPortSize();
  if(currViewPortSize && (size.w != currViewPortSize.w || size.h != currViewPortSize.h || size.x != currViewPortSize.x || size.y != currViewPortSize.y)) {
   var controlCollection = aspxGetPopupControlCollection();
   controlCollection.ForEachControl(function(popupControl) {
    if(popupControl.GetCanScrollViewPort(-1) && popupControl.IsVisible()) {
     popupControl.updateContentScrollIfNeeded(-1);
     popupControl.UpdatePosition();
    }
   });
  }
  currViewPortSize = size;
 }, 50);
}
window.ASPxClientPopupControlBase = ASPxClientPopupControlBase;
window.ASPxClientPopupControl = ASPxClientPopupControl;
window.ASPxClientPopupWindow = ASPxClientPopupWindow;
window.ASPxClientPopupWindowEventArgs = ASPxClientPopupWindowEventArgs;
window.ASPxClientPopupWindowCancelEventArgs = ASPxClientPopupWindowCancelEventArgs;
window.ASPxClientPopupWindowResizeEventArgs = ASPxClientPopupWindowResizeEventArgs;
window.ASPxClientPopupWindowPinnedChangedEventArgs = ASPxClientPopupWindowPinnedChangedEventArgs;
window.ASPxClientPopupControlCollection = ASPxClientPopupControlCollection;
window.ASPxClientPopupControlResizeState = ASPxClientPopupControlResizeState;
window.ASPxClientPopupControlCloseReason = ASPxClientPopupControlCloseReason;
ASPx.GetPopupControlCollection = aspxGetPopupControlCollection;
ASPx.PopupControlCssClasses = PopupControlCssClasses;
})();

(function () {
var PagerIDSuffix = {
 PageSizeBox: "PSB",
 PageSizeButton: "DDB",
 PageSizePopup: "PSP",
 PageSizePopupMenuContainer: "DXMCC"
};
var ASPxClientPager = ASPx.CreateClass(ASPxClientControl, {
 constructor: function (name) {
  this.constructor.prototype.constructor.call(this, name);
  this.hasOwnerControl = false;
  this.originalWidth = null;
  this.containerOffsetWidth = 0;
  this.droppedDown = false;
  this.pageSizeItems = [];
  this.pageSizeSelectedItem = null;
  this.enableAdaptivity = false;
  this.pageSizeChanged = new ASPxClientEvent();
  this.requireInlineLayout = false;
  this.rightAlignContainer = null;
 },
 InlineInitialize: function () {
  this.originalWidth = this.GetMainElement().style.width;
  ASPxClientControl.prototype.InlineInitialize.call(this);
 },
 Initialize: function() {
  ASPxClientControl.prototype.Initialize.call(this);
  aspxGetPagersCollection().Add(this);
  if(this.requireInlineLayout) {
   var mainElement = this.GetMainElement();
   mainElement.style.display = "inline-block";
   mainElement.style.float = "none";
  }
  this.InitAccessibilityListboxRole();
 },
 BrowserWindowResizeSubscriber: function () {
  return ASPxClientControl.prototype.BrowserWindowResizeSubscriber.call(this) || this.hasOwnerControl;
 },
 OnBrowserWindowResize: function (e) {
  this.AdjustControl();
 },
 GetAdjustedSizes: function () {
  if(this.hasOwnerControl) {
   var mainElement = this.GetMainElement();
   if(mainElement)
    return { width: mainElement.parentNode.offsetWidth, height: mainElement.parentNode.offsetHeight };
  }
  return ASPxClientControl.prototype.GetAdjustedSizes.call(this);
 },
 AdjustControlCore: function() {
  this.CorrectVerticalAlignment(ASPx.ClearHeight, this.GetPageSizeButtonElement, "PSB");
  this.CorrectVerticalAlignment(ASPx.ClearVerticalMargins, this.GetPageSizeButtonImage, "PSBImg");
  this.CorrectVerticalAlignment(ASPx.ClearHeight, this.GetButtonElements, "Btns");
  this.CorrectVerticalAlignment(ASPx.ClearVerticalMargins, this.GetButtonImages, "BtnImgs");
  this.CorrectVerticalAlignment(ASPx.ClearVerticalMargins, this.GetSeparatorElements, "Seps");
  this.containerOffsetWidth = this.GetContainerWidth();
  var savedDroppedDown = false;
  if(this.droppedDown && this.GetPageSizePopupMenu()) {
   this.HidePageSizeDropDown();
   savedDroppedDown = true;
  }
  if(ASPx.IsPercentageSize(this.originalWidth))
   this.AdjustControlItems();
  else if(this.hasOwnerControl)
   this.AdjustControlMinWidth();
  if(savedDroppedDown)
   this.ShowPageSizeDropDown();
  this.CorrectVerticalAlignment(ASPx.AdjustHeight, this.GetPageSizeButtonElement, "PSB");
  this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.GetPageSizeButtonImage, "PSBImg");
  this.CorrectVerticalAlignment(ASPx.AdjustHeight, this.GetButtonElements, "Btns");
  this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.GetButtonImages, "BtnImgs");
  this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.GetSeparatorElements, "Seps");
 },
 AdjustControlMinWidth: function() {
  var mainElement = this.GetMainElement();
  if(!mainElement) return;  
  if(this.enableAdaptivity) {
   var selectors = this.GetAdaptiveElementSelectors();
   this.SetElementsDisplay(mainElement, selectors.numeric, true);
   this.SetElementsDisplay(mainElement, selectors.ellipsis, true);
   this.SetElementsDisplay(mainElement, selectors.summary, true);
   var hideSummaryAtFirst = this.GetButtonElements().length === 0;
   if(hideSummaryAtFirst && this.GetAdaptiveWidth(mainElement) < this.GetMinWidth(mainElement))
    this.SetElementsDisplay(mainElement, selectors.summary, false);
   if(this.GetAdaptiveWidth(mainElement) < this.GetMinWidth(mainElement)){
    this.SetElementsDisplay(mainElement, selectors.numeric, false);
    this.SetElementsDisplay(mainElement, selectors.ellipsis, false);
   }
   if(!hideSummaryAtFirst && this.GetAdaptiveWidth(mainElement) < this.GetMinWidth(mainElement))
    this.SetElementsDisplay(mainElement, selectors.summary, false);
  }
  else {
   var minWidth = this.GetMinWidth(mainElement);
   mainElement.style.minWidth = minWidth + "px";
  }
 },
 GetAdaptiveElementSelectors: function(){
  return { summary: "dxp-summary", ellipsis: "dxp-ellip", numeric: "dxp-num" };
 },
 GetAdaptiveWidth: function(element){
  if(ASPx.IsPercentageSize(this.originalWidth)) 
   return element.offsetWidth;
  else if(this.hasOwnerControl)
   return element.parentNode.offsetWidth;
  else
   return 10000;
 },
 GetMinWidth: function(element){
  return this.GetItemsWidth(element) + ASPx.GetLeftRightPaddings(element) + (ASPx.Browser.HardwareAcceleration ? 1 : 0);
 },
 SetElementsDisplay: function(element, cssClass, value) {
  var elements = ASPx.GetNodesByPartialClassName(element, cssClass);
  for(var i = 0; i < elements.length; i++) 
   ASPx.SetElementDisplay(elements[i], value);
 },
 AdjustControlItems: function () {
  var mainElement = this.GetMainElement();
  mainElement.style.width = this.originalWidth;
  var spacers = [];
  for(var i = 0; i < mainElement.childNodes.length; i++) {
   var itemElement = mainElement.childNodes[i];
   if(!itemElement.tagName) continue;
   if(itemElement.className === "dxp-spacer") {
    spacers.push(itemElement);
    itemElement.style.width = "0px";
   }
  }
  this.AdjustControlMinWidth();
  if(spacers.length > 0) {
   var clientWidth = mainElement.clientWidth - ASPx.GetLeftRightPaddings(mainElement);
   var spacerWidth = Math.floor((clientWidth - this.GetItemsWidth(mainElement)) / spacers.length);
   var makeItemsFloatRight = false;
   var rightItems = [];
   for(var i = 0; i < mainElement.childNodes.length; i++) {
    var itemElement = mainElement.childNodes[i];
    if(!itemElement.tagName) continue;
    if(itemElement.className === "dxp-spacer") {
     if(itemElement == spacers[spacers.length - 1])
      makeItemsFloatRight = true;
     else
      itemElement.style.width = spacerWidth + "px";
    }
    else if(makeItemsFloatRight) {
     if(!this.IsAdjusted())
      rightItems.push(itemElement);
    }
   }
   this.AdjustRightFloatItems(rightItems, ASPx.GetLeftRightPaddings(mainElement));
   this.AdjustControlMinWidth();
  }
 },
 AdjustRightFloatItems: function (items, rightMargin) {
  if(items.length === 0)
   return;
  var container = this.GetRightAlignContainer();
  for(var i = 0; i < items.length; i++) {
   if(items[i] !== container)
    container.appendChild(items[i]);
  }
 },
 GetRightAlignContainer: function() {
  if(!ASPx.IsExistsElement(this.rightAlignContainer)) {
   this.rightAlignContainer = ASPx.CreateHtmlElementFromString("<div class='dxp-right' style='border-width: 0px; padding: 0px; margin: 0px'></div>");
   this.GetMainElement().appendChild(this.rightAlignContainer);
  }
  return this.rightAlignContainer;
 },
 GetItemsWidth: function (mainElement) {
  var width = 0;
  for(var i = 0; i < mainElement.childNodes.length; i++)
   width += this.GetItemWidth(mainElement.childNodes[i]);
  return width;
 },
 GetItemWidth: function (item) {
  if(!item || !item.tagName || !ASPx.GetElementDisplay(item))
   return 0;
  var style = ASPx.Browser.IE && ASPx.Browser.Version > 8 ? window.getComputedStyle(item, null) : ASPx.GetCurrentStyle(item);
  var margins = 0;
  if(!this.ShouldIgnoreItemHorizontalMargin(item, true))
   margins += ASPx.PxToInt(style.marginLeft);
  if(!this.ShouldIgnoreItemHorizontalMargin(item, false))
   margins += ASPx.PxToInt(style.marginRight);
  if(ASPx.Browser.IE) {
   if(ASPx.Browser.Version > 8) 
    return ASPx.PxToFloat(style.width) + ASPx.GetLeftRightBordersAndPaddingsSummaryValue(item) + margins;
   return item.offsetWidth + margins;
  }
  return ASPx.PxToFloat(style.width) + ASPx.GetLeftRightBordersAndPaddingsSummaryValue(item) + margins;
 },
 ShouldIgnoreItemHorizontalMargin: function(item, isLeft) {
  return false;
 },
 GetContainerWidth: function () {
  var mainElement = this.GetMainElement();
  if(mainElement && mainElement.parentNode)
   return mainElement.parentNode.offsetWidth;
  return 0;
 },
 GetPageSizeBoxID: function () {
  return this.name + "_" + PagerIDSuffix.PageSizeBox;
 },
 GetPageSizeButtonID: function () {
  return this.name + "_" + PagerIDSuffix.PageSizeButton;
 },
 GetPageSizePopupMenuID: function () {
  return this.name + "_" + PagerIDSuffix.PageSizePopup;
 },
 GetPageSizePopupMenuContainerID: function () {
  return this.name + "_" + PagerIDSuffix.PageSizePopupMenuContainer;
 },
 GetPageSizeBoxElement: function () {
  return ASPx.GetElementById(this.GetPageSizeBoxID());
 },
 GetPageSizeButtonElement: function () {
  return ASPx.GetElementById(this.GetPageSizeButtonID());
 },
 GetPageSizeButtonImage: function () {
  return ASPx.GetNodeByTagName(this.GetPageSizeButtonElement(), "IMG", 0);
 },
 GetPageSizeInputElement: function () {
  return ASPx.GetNodeByTagName(this.GetPageSizeBoxElement(), "INPUT", 0);
 },
 GetPageSizePopupMenu: function () {
  return ASPx.GetControlCollection().Get(this.GetPageSizePopupMenuID());
 },
 GetButtonElements: function () {
  return ASPx.GetNodesByClassName(this.GetMainElement(), "dxp-button");
 },
 GetButtonImages: function () {
  var images = [];
  var buttons = this.GetButtonElements();
  for(var i = 0; i < buttons.length; i++) {
   var img = ASPx.GetNodeByTagName(buttons[i], "IMG", 0);
   if(img) images.push(img);
  }
  return images;
 },
 GetSeparatorElements: function () {
  return ASPx.GetNodesByClassName(this.GetMainElement(), "dxp-sep");
 },
 TogglePageSizeDropDown: function () {
  if(!this.droppedDown)
   this.ShowPageSizeDropDown();
  else
   this.HidePageSizeDropDown();
 },
 ShowPageSizeDropDown: function () {
  this.GetPageSizePopupMenu().Show();
  this.droppedDown = true;
  this.SetAccessibilityPopupMenuExpanded(true);
 },
 HidePageSizeDropDown: function () {
  this.GetPageSizePopupMenu().Hide();
  this.droppedDown = false;
  this.SetAccessibilityPopupMenuExpanded(false);
 },
 ChangePageSizeInput: function (isNext) {
  var input = this.GetPageSizeInputElement();
  var oldIndex = this.GetPageSizeIndexByText(input.value);
  var index = oldIndex;
  var count = this.pageSizeItems.length;
  if(isNext)
   index = (oldIndex < count - 1) ? (oldIndex + 1) : 0;
  else
   index = (oldIndex > 0) ? (oldIndex - 1) : (count - 1);
  input.value = this.pageSizeItems[index].text;
  this.SetAccessibilitySelectedItem(index, oldIndex);
 },
 ChangePageSizeValue: function (value) {
  this.GetPageSizeInputElement().value = this.GetPageSizeTextByValue(value);
 },
 IsPageSizeValueChanged: function () {
  var newValue = this.GetPageSizeValueByText(this.GetPageSizeInputElement().value);
  return newValue != this.pageSizeSelectedItem.value;
 },
 InitAccessibilityListboxRole: function() {
  var popupMenu = this.GetPageSizePopupMenu();
  if(!this.accessibilityCompliant || !popupMenu)
   return;
  var listElement = popupMenu.GetMenuMainElement(popupMenu.GetMainElement()).firstElementChild; 
  listElement.id = this.GetPageSizePopupMenuContainerID();
  ASPx.Attr.SetAttribute(listElement, "role", "listbox");
  ASPx.Attr.SetAttribute(this.GetPageSizeInputElement(), "aria-owns", listElement.id);
  for(var i = 0; i < popupMenu.GetItemCount(); i++) {
   var menuItemElement = popupMenu.GetItemElement(i);
   ASPx.Attr.SetAttribute(menuItemElement, "role", "option");
   ASPx.Attr.SetAttribute(menuItemElement, "aria-selected", false);
  }
 },
 SetAccessibilityPopupMenuExpanded: function(expanded) {
  if(!this.accessibilityCompliant)
   return;
  var inputElement = this.GetPageSizeInputElement();
  if(expanded){
   ASPx.Attr.SetAttribute(inputElement, "aria-expanded", true);
   setTimeout(function() {
    var index = this.GetPageSizeIndexByText(inputElement.value);
    this.SetAccessibilitySelectedItem(index);
   }.aspxBind(this), ASPx.AccessibilityPronounceTimeout);
  } else {
   ASPx.Attr.SetAttribute(inputElement, "aria-expanded", false);
   ASPx.Attr.RemoveAttribute(inputElement, "aria-activedescendant");
  }
 },
 SetAccessibilitySelectedItem: function(curIndex, oldIndex) {
  if(!this.accessibilityCompliant)
   return;
  var popupMenu = this.GetPageSizePopupMenu();
  if(ASPx.IsExists(oldIndex)) {
   var itemElement = popupMenu.GetItemElement(oldIndex);
   if(itemElement)
    ASPx.Attr.SetAttribute(itemElement, "aria-selected", false);
  }
  var selItemElement = popupMenu.GetItemElement(curIndex);
  if(selItemElement) {
   ASPx.Attr.SetAttribute(selItemElement, "aria-selected", true);
   if(this.droppedDown)
    ASPx.Attr.SetAttribute(this.GetPageSizeInputElement(), "aria-activedescendant", selItemElement.id);
  }
 },
 OnDocumentOnClick: function (evt) {
  var srcElement = ASPx.Evt.GetEventSource(evt);
  if(srcElement != this.GetPageSizeBoxElement() && ASPx.GetParentById(srcElement, this.GetPageSizeBoxID()) == null) {
   this.droppedDown = false;
  }
 },
 OnPageSizeClick: function (evt) {
  var self = this;
  window.setTimeout(function () {
   self.TogglePageSizeDropDown();
  }, 0);
  ASPx.SetFocus(this.GetPageSizeInputElement());
 },
 OnPageSizePopupItemClick: function (value) {
  this.ChangePageSizeValue(value);
  if(this.IsPageSizeValueChanged())
   this.OnPageSizeValueChangedWrapped(true);
 },
 OnPageSizeBlur: function (evt) {
  if(this.IsPageSizeValueChanged())
   this.OnPageSizeValueChangedWrapped(false);
 },
 OnPageSizeValueChangedWrapped: function(keepFocus) {
  if(this.accessibilityCompliant) {
   setTimeout(function() {
    if(keepFocus)
     this.GetPageSizeInputElement().focus();
    this.OnPageSizeValueChanged();
    this.SetAccessibilityPopupMenuExpanded(false);
   }.aspxBind(this), 0);
  } else
   this.OnPageSizeValueChanged();
 },
 OnPageSizeKeyDown: function (evt) {
  var keyCode = ASPx.Evt.GetKeyCode(evt);
  if(keyCode == ASPx.Key.Down || keyCode == ASPx.Key.Up) {
   if(evt.altKey)
    this.TogglePageSizeDropDown();
   else
    this.ChangePageSizeInput(keyCode == ASPx.Key.Down);
   if(this.droppedDown) {
    var popupMenu = this.GetPageSizePopupMenu();
    var value = this.GetPageSizeValueByText(this.GetPageSizeInputElement().value);
    var item = popupMenu.GetItemByName(value);
    popupMenu.SetSelectedItem(item);
   }
   ASPx.Evt.PreventEvent(evt);
  }
  else if(keyCode == ASPx.Key.Enter) {
   if(this.IsPageSizeValueChanged())
    this.OnPageSizeValueChanged();
   else
    this.HidePageSizeDropDown();
   return ASPx.Evt.PreventEventAndBubble(evt);
  }
  else if(keyCode == ASPx.Key.Tab) {
   this.HidePageSizeDropDown();
  }
  else if(keyCode == ASPx.Key.Esc) {
   this.HidePageSizeDropDown();
   this.GetPageSizeInputElement().value = this.pageSizeSelectedItem.text;
  }
  return true;
 },
 UpdatePageSizeSelectedItem: function() {
  this.pageSizeSelectedItem.text = this.GetPageSizeInputElement().value;
  this.pageSizeSelectedItem.value = this.GetPageSizeValueByText(this.pageSizeSelectedItem.text);
 },
 OnPageSizeValueChanged: function () {
  this.UpdatePageSizeSelectedItem();
  if(!this.pageSizeChanged.IsEmpty()) {
   var popupMenu = this.GetPageSizePopupMenu();
   var menuItem = popupMenu.GetItemByName(this.pageSizeSelectedItem.value);
   var menuItemElement = popupMenu.GetItemElement(menuItem.index);
   var command = PagerIDSuffix.PageSizePopup + this.pageSizeSelectedItem.value;
   var args = new ASPxClientPagerPageSizeChangedEventArgs(menuItemElement, command);
   this.pageSizeChanged.FireEvent(this, args);
  }
 },
 GetPageSizeIndexByText: function (text) {
  var count = this.pageSizeItems.length;
  for(var i = 0; i < count; i++) {
   if(text == this.pageSizeItems[i].text)
    return i;
  }
  return -1;
 },
 GetPageSizeTextByValue: function (value) {
  var count = this.pageSizeItems.length;
  for(var i = 0; i < count; i++) {
   if(value == this.pageSizeItems[i].value)
    return this.pageSizeItems[i].text;
  }
  return value.toString();
 },
 GetPageSizeValueByText: function (text) {
  var count = this.pageSizeItems.length;
  for(var i = 0; i < count; i++) {
   if(text == this.pageSizeItems[i].text)
    return this.pageSizeItems[i].value;
  }
  return this.pageSizeSelectedItem.value;
 }
});
var ASPxClientPagerPageSizeChangedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function (element, value) {
  this.constructor.prototype.constructor.call(this);
  this.element = element;
  this.value = value;
 }
});
var pagersCollection = null;
function aspxGetPagersCollection() {
 if(pagersCollection == null)
  pagersCollection = new ASPxClientPagersCollection();
 return pagersCollection;
}
var ASPxClientPagersCollection = ASPx.CreateClass(ASPxClientControlCollection, {
 constructor: function () {
  this.constructor.prototype.constructor.call(this);
 },
 GetCollectionType: function(){
  return "Pager";
 },
 OnDocumentOnClick: function (evt) {
  this.ForEachControl(function (control) {
   control.OnDocumentOnClick(evt);
  });
 }
});
ASPx.Evt.AttachEventToDocument("click", aspxPagerDocumentOnClick);
function aspxPagerDocumentOnClick(evt) {
 return aspxGetPagersCollection().OnDocumentOnClick(evt);
}
function _aspxPGNavCore(element) {
 if(element != null) {
  if(element.tagName != "A") {
   var linkElement = ASPx.GetNodeByTagName(element, "A", 0);
   if(linkElement != null)
    ASPx.Url.NavigateByLink(linkElement);
  }
 }
}
ASPx.PGNav = function(evt) {
 var element = ASPx.Evt.GetEventSource(evt);
 _aspxPGNavCore(element);
 if(!ASPx.Browser.NetscapeFamily)
  evt.cancelBubble = true;
};
ASPx.POnPageSizeChanged = function(s, e) {
 s.SendPostBack(e.value);
};
ASPx.POnSeoPageSizeChanged = function(s, e) {
 _aspxPGNavCore(e.element);
};
ASPx.POnPageSizeBlur = function(name, evt) {
 var pager = ASPx.GetControlCollection().Get(name);
 if(pager != null)
  pager.OnPageSizeBlur(evt);
 return true;
};
ASPx.POnPageSizeKeyDown = function(name, evt) {
 var pager = ASPx.GetControlCollection().Get(name);
 if(pager != null)
  return pager.OnPageSizeKeyDown(evt);
 return true;
};
ASPx.POnPageSizeClick = function(name, evt) {
 var pager = ASPx.GetControlCollection().Get(name);
 if(pager != null)
  pager.OnPageSizeClick(evt);
};
ASPx.POnPageSizePopupItemClick = function(name, item) {
 var pager = ASPx.GetControlCollection().Get(name);
 if(pager != null) {
  pager.OnPageSizePopupItemClick(item.name);
 }
};
window.ASPxClientPager = ASPxClientPager;
window.ASPxClientPagerPageSizeChangedEventArgs = ASPxClientPagerPageSizeChangedEventArgs;
ASPx.PagerIDSuffix = PagerIDSuffix;
ASPx.GetPagersCollection = aspxGetPagersCollection;
})();
