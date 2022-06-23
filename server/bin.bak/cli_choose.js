class CliChoose {
  choice = {
    title: "",
    value: "",
  };

  constructor(title) {
    this.choice.title = title;
    this.choice.value = `${title}`.replace(" ", "");
  }

  isMe(answer, onSubmit) {
    if (answer == this.choice.value) {
      onSubmit();
    }
  }
}

module.exports = { CliChoose };
