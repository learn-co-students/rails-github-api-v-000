# Working with APIs

## Instructions

1. Follow [this tutorial](https://github.com/learn-co-curriculum/web-auth-readme) to implement authentication with the GitHub API. Display the current user's username on the `index` page in a heading.

2. On the repositories `index` page, display a list of the current user's repositories. Displaying only the first page of results is fine; feel free to tackle pagination as a bonus.

3. Implement the `create` action in your `RepositoriesController` so that the form on `index.html.erb` successfully creates a new repository for the current user. The form input should be the name of the new repository. Redirect back to `'/'`. (HINT: Your parameters hash should be passed in as JSON. How can you accomplish this? Can you think of a method that will convert a hash to JSON?)

4. Your solution will "make it work", but we want to move the API calls out of the controllers. Once the tests pass, [learn how to refactor your code in the next lab](https://github.com/learn-co-curriculum/rails-refactoring-apis). This is important – don't skip it!