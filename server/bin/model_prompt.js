const prompts = require("prompts");

class ModelPrompt {
  choice = {
    title: "",
    value: "",
  };

  constructor(title) {
    this.choice.title = title;
    this.choice.value = title.replace(" ", "");
  }

  action = (answer, onSubmit) => {
    if (answer === this.choice.value) {
      onSubmit();
    }
  };

  promptSelect(answer, choices, onSubmit) {
    if (answer === this.choice.value) {
      prompts(
        {
          type: "select",
          name: "name",
          message: "select menu",
          choices: choices,
        },
        { onSubmit }
      );
    }
  }
}

function PromptSelect(choices, onSubmit) {
  prompts(
    {
      type: "select",
      name: "name",
      message: "select menu",
      choices: choices,
    },
    { onSubmit }
  );
}

function Prom(title) {
  return {
    chooice: {
      title: title,
      value: title.replace(" ", ""),
    },
    isMe(answer, onSubmit) {
      if (answer === this.choice.value) {
        onSubmit();
      }
    },
  };
}

module.exports = { ModelPrompt, PromptSelect, Prom };
