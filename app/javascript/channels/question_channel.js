import consumer from "./consumer"
import Question from "../components/question"
import React from 'react'
import ReactDOM from 'react-dom'

consumer.subscriptions.create("QuestionChannel", {
  connected() {
    this.perform("follow")
  },

  disconnected() {
  },

  received(data) {
    document.querySelector('.questions').append(document.createElement('p'))
    ReactDOM.render(
      <Question data={data} />,
      document.querySelector('.questions p:last-child')
    )
  }
});
