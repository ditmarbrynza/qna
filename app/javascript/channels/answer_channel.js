import consumer from "./consumer"

consumer.subscriptions.create("AnswerChannel", {
  connected() {
    this.perform("follow")
  },

  disconnected() {
    console.log("disconected")
  },

  received(data) {
    console.log("received", data)
    // document.querySelector('.answers').append(data)
  }
});
