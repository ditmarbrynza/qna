import consumer from "./consumer"
import Answer from "../components/answer"
import React from 'react'
import ReactDOM from 'react-dom'

consumer.subscriptions.create("AnswerChannel", {
  connected() {
    this.perform("follow")
  },

  disconnected() {
    console.log("disconected")
  },

  received(data) {
    console.log("received", data)
    if(gon.current_user == data.user.id) { return null }

    document.querySelector('.answers').append(document.createElement('div'))
    ReactDOM.render(
      <Answer data={data} />,
      document.querySelector('.answers').lastChild
    )
  }
});
