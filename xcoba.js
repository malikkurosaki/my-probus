

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

String.prototype.log = function () {
  console.log(this.toString());
}

const prompts = require("prompts");

;(async () => {
  const menu = await prompts([
    {
      type: "select",
      name: "action",
      message: "What do you want to do?",
      choices: [
        {
          title: "git",
          value: "git",
        },
        {
          title: "model",
          value: "model",
        },
        {
          title: "build",
          value: "build",
        },
      ],
    },
    {
      type: "select",
      name: "action2",
      message: "What do you want to do?",
      choices: [
        {
          title: "git2",
          value: "git",
        },
        {
          title: "model2",
          value: "model",
        },
        {
          title: "build2",
          value: "build",
        },
      ],
      
    }
  ]);

  console.log(menu);

})()