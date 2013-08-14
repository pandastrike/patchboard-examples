GitHubClient = require("../client")
Testify = require("testify")
assert = require "assert"

fs = require("fs")
# read login:password from a file
string = fs.readFileSync("auth")
string = string.slice(0, string.length-1)
basic_auth = new Buffer(string).toString("base64")

client = new GitHubClient(basic_auth)

## FIXME: Why is this here?
#test_repository = (context, repo) ->
  #repo.get
    #on:
      #200: (response, repo) ->
        #context.test "repo.owner is a resource", ->
          #assert.equal repo.owner.resource_type, "user"


Testify.test "Resources from templatized urls", (context) ->

  context.test "User", (context) ->
    context.test ".get()", (context) ->
      user = client.resources.user(login: "dyoder")
      user.get
        on:
          response: (response) ->
            context.fail "Unexpected response status: #{response.status}"
          200: (response, user) ->
            context.test "provides a user resource", ->
              assert.equal user.resource_type, "user"

  context.test "Repositories", (context) ->
    context.test ".list()", (context) ->
      user_repos = client.resources.user_repositories(login: "dyoder")
      user_repos.list
        on:
          response: (response) ->
            context.fail "Unexpected response status: #{response.status}"
          200: (response, list) ->
            context.test "provides an array", (context) ->
              assert.equal list.constructor, Array
              context.test "of repository resources", ->
                for item in list
                  assert.equal item.resource_type, "repository"





