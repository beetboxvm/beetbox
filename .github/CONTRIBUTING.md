Contributing Guide
==================

Firstly, thanks for taking the time to contribute!

The following is a set of guidelines for contributing to the project. These are just guidelines, not rules, that are designed to help your contributions here succeed. Please use your best judgment and feel free to propose changes to this document in a pull request.

If you haven't already, please take the time to read through the complete [Contributing guide][] for the project. It should help ensure your contributions succeed by aligning them with the goals for the project.

**We want you to contribute the things you're excited about so everyone can benefit.**

[Contributing guide]: http://beetbox.readthedocs.io/en/stable/contributing/contributing/

Proposing Changes
-----------------

Please submit a [GitHub Pull Request][] with a clear list of what you've done.

When you send a pull request with a new or changed feature, we will love you forever if you also include documentation or tests.

Please ensure all of your commits are atomic (one feature per commit) and have a clear log message (read on below).

[GitHub Pull Request]: https://github.com/beetboxvm/beetbox/pull/new/master
[pull requests]: http://help.github.com/pull-requests/

Commit Messages
---------------

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should include more detail. Please do not use an issue number as your commit message.

Here is a commit message template, adapted from one written by Tim Pope, that you should use as a guide.

    Short (50 chars or less) summary of changes

    More detailed explanatory text, if necessary.  Wrap it to
    about 72 characters or so.  The blank line separating the
    summary from the body is critical; tools like rebase can
    get confused if you run the two together.

    Further paragraphs come after blank lines.

      - Bullet points are okay, too

      - Typically a hyphen or asterisk is used for the bullet,
        with blank lines in between

If you read and follow the [Git commit guidelines][], when contributing to almost any project, the chances of your contribution being merged as-is will be greatly improved.

### Issues

Please do not use an issue number as your commit message.

To reference an issue in a commit message follow the [Github Autolinked references][] format **on its own line** after the short summary line.

This example commit message links to Github issue 555:

    Short (50 chars or less) summary of changes

    More detailed explanatory text, if necessary.  Wrap it to
    about 72 characters or so.

    GH-555

If you follow the above example, the Github issue will be autolinked, providing easy reference when viewing on Github.

[Git commit guidelines]: https://git-scm.com/book/ch5-2.html#Commit-Guidelines
[Github Autolinked references]: https://help.github.com/articles/autolinked-references-and-urls/#issues-and-pull-requests

Testing
-------

Beetbox uses Circle CI for Continuous Integration. When you create a Github Pull Request, Circle CI will initiate a new build and run the configured tests. The results of those tests are reported back to Github on completion.

[Read the docs on Continuous Integration][] for more details on the build and test configuration.

Contributions to the tests are welcomed and strongly encouraged.

[Read the docs on Continuous Integration]: http://beetbox.readthedocs.io/en/stable/continuous-integration/circle-ci/
