const prompts = require('prompts');


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


module.exports = {PromptSelect}
