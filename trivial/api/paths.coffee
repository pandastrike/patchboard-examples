module.exports =

  users:
    resource: "users"
    path: "/users"

  user:
    resource: "user"
    template: "/users/:id"

  statistics:
    resource: "statistics"
    template: "/users/:id/statistics"

  questions:
    resource: "questions"
    template: "/users/:id/questions"

  question:
    resource: "question"
    template: "/questions/:id"



