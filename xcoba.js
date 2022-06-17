

function coba() {
  // randome number 1 - 100
  var randomNumber = Math.floor(Math.random() * 3) + 1;
  console.log(randomNumber);
}

// detect type of data
function typeNya(data) {
  if (typeof data === "string") {
    return "String";
  } else if (typeof data === "number") {
    return "int";
  } else if (typeof data === "boolean") {
    return "bool";
  } else if (Array.isArray(data)) {
    return "List";
  } else if (data instanceof Object) {
    return "Map";
  } else if(data instanceof Date) {
    return "DateTime";
  }else {
    return "var";
  }
}

;(async () => {
    console.log(typeNya(new Date()));
})()
