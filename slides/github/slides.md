---
theme: seriph
background: https://source.unsplash.com/user/steinbrueckri/3840x2160
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Github
drawings:
  persist: false
defaults:
  foo: true
transition: slide-left
title: Github
mdc: true
---

# Github

---

### My GitHub Profile

![Richard Github Profile1](/images/me_github_1.png){width=700px lazy}

---

### My First commit

![Richard Github Profile2](/images/me_github_2.png){width=700px lazy}

---

### What is GitHub?

[![](/images/reddit_git_github.png)](https://www.reddit.com/r/github/comments/g5030w/whats_the_difference_between_git_and_github/)

---
layout: image-right
image: https://source.unsplash.com/random/900%C3%97700/?star
---
### What is GitHub?

The biggest open source plattform on the internet maybe also a bit of on a social network for Developer.

⭐ = likes

You could also say the SourceForge of modern times. 👴

---
layout: image-right
image: https://source.unsplash.com/random/900%C3%97700/?opensource
---

### Why Github?

It is the de facto standard for open source projects.

- React (150k ⭐️)
- Tensorflow (145k ⭐️)
- Bootstrap (141k ⭐️)
- Linux (92.2k ⭐️)
- Rails (45k ⭐️)
- Jenkins (45k ⭐️)

[source](https://github.com/EvanLi/Github-Ranking)

---
layout: image-right
image: https://source.unsplash.com/random/900%C3%97700/?github
---

### Facts about GitHub

- 40 million users (2020)
- 100 million repositories (2018)
- 32 million monthly visitors (2015)

[source](https://expandedramblings.com/index.php/github-statistics/)

---
layout: image-right
image: https://source.unsplash.com/1600x900/?github
---

### History

- Feb 2008 // founded, written in Ruby on Rails and Erlang
- Jun 2018 // [Github acquired by Microsoft](https://news.microsoft.com/announcement/microsoft-acquires-github/)
- Dec 2018 // [Spectrum acquired by Github](https://hub.packtpub.com/github-acquires-spectrum-a-community-centric-conversational-platform/)
- May 2019 // [Dependabot acquired by Github](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/)
- Jun 2019 // [Pull Panda acquired by Github](https://pullpanda.com/github)
- Sep 2019 // [Semmle acquired by Github](https://blog.semmle.com/secure-software-github-semmle/)
- Apr 2020 // [NPM acquired by Github](https://github.blog/2020-03-16-npm-is-joining-github/)

[source](https://de.wikipedia.org/wiki/GitHub)

---

# Github Features
## CODEOWNER File

```bash
$ cat .github/CODEOWNERS
*.js @p1nkun1c0rns/jsgurus
*.java @p1nkun1c0rns/javagurus
*.pom @p1nkun1c0rns/mavengurus
*.md @p1nkun1c0rns/docgurus
```

<a href="https://help.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners">See Docs for more examples</a>

---

# Github Features
## 🏗 Build and CI

Github Actions events for everything.

Issues, PRs, Push, Release, Dispatch ...

---

### Marketplace

![Screenshot](/images/marketplace.png){width=700px lazy}

---

### Build your own ...

![](https://media.giphy.com/media/1CNsm9ZkHF0m4/giphy.gif){width=700px lazy}

flavers [Docker](https://github.com/p1nkun1c0rns/commitlinter-github-action/) or [JavaScript](https://github.com/p1nkun1c0rns/maven-settings-action)

---
layout: image-right
image: https://media.giphy.com/media/hT6wgEtwoUt0no87gV/giphy.gif
---

# Put all pieces together

https://github.com/steinbrueckri/kube-score

---

### 🤖 Dependabot

Automated dependency updates for your Ruby, Python, JavaScript, PHP, .NET, Go, Elixir, Rust, Java and Elm.

[![Screenshot](https://dependabot.com/static/eb991d2434b1b73d4e71145f50359ada/23495/screenshot.png)](https://github.com/steinbrueckri/kube-score/pull/23){width=700px lazy}

---

## Configuration via web

![](/images/dependabot.png){width=700px lazy}

---

## Configuration via config

```
version: 1
update_configs:
  - package_manager: "docker"
    directory: "/"
    update_schedule: "weekly"
    automerged_updates:
      - match:
          dependency_type: "all"
          update_type: "all"

  - package_manager: "ruby:bundler"
    directory: "/src"
    update_schedule: "weekly"
    automerged_updates:
      - match:
          dependency_type: "all"
          update_type: "all"

  - package_manager: "github_actions"
    directory: "/"
    update_schedule: "weekly"
    automerged_updates:
      - match:
          dependency_type: "all"
          update_type: "all"
```

---

# LGTM

LGTM is a code analysis platform for development teams to identify vulnerabilities early and prevent them from reaching production.

![Screenshot](/images/lgtm.png)

---

### CodeQL

<small>CodeQL is a code analysis engine for product security teams to quickly find zero-days and variants of critical vulnerabilities.
<br/>[Finding security vulnerabilities in Java with CodeQL - GitHub Satellite 2020](https://www.youtube.com/watch?v=nvCd0Ee4FgE)</small>

![Screenshot](/images/codeql.png)

---

## 🔔 Github Notificatons - By Date
![notificatons1](/images/notifications1.png)

---

## 🔔 Github Notificatons - By Repository
![notificatons2](/images/notifications2.png)

---

## 🔔 Github Notificatons - Mail vs. Web
![notificatons settings](/images/notifications-settings.png)

---

## 🔔 Github Notificatons - Filters
![notificatons filter](/images/notifications-filter.png)

---

## 🕵️‍♂️ How to Search?!

```text
path:.github/workflows google
path:.github/workflows ci
path:.github/workflows release
filename:pom.xml docker
```

---

### somtimes it can also be funny ... 😅

```text
fuck language:Kotlin
```

![search1](/images/search_1.png){width=500px lazy}

![search2](/images/search_2.png){width=500px lazy}

---
layout: image
image: https://media.giphy.com/media/cFkiFMDg3iFoI/giphy.gif
---
---

### Request for Changes

![suggestion1.png](/images/suggestion1.png)

---

![suggestion2.png](/images/suggestion2.png)

---

![suggestion3.png](/images/suggestion3.png)

---

### Draft Pull requests

A draft pull request is styled differently to clearly indicate that it’s in a draft state.

[![pr_draft](/images/pr_draft.png)](https://github.com/steinbrueckri/Github-Demo/pull/1/files){width=200px lazy}

---
layout: cover
---

# 🐞 Github Issues

---

### Issues Templates

![](https://github.blog/wp-content/uploads/2018/05/new-issue-page-with-multiple-templates.png?resize=1604%2C694){width=700px lazy}

---

### Markdown Support

![](/images/markdown_issues.png){width=700px lazy}

---

### Link issues and PRs also to other Repos

![](/images/link_issus.png){width=700px lazy}

---

### Nice example, how you can use issus also ...

[![](/images/issues_vs_jira.png)](https://github.com/dwyl/hq/issues){width=700px lazy}

---

### 📊 Github Projects

![pr_draft](/images/projects.png)

---
layout: cover
---

### 📑 Github Pages

---

[![pages_repo_2](/images/pages_repo_2.png)](https://github.com/steinbrueckri/steinbrueckri.github.io/)

---

[![pages_build](/images/pages_workflow.png)](https://github.com/steinbrueckri/steinbrueckri.github.io/blob/development/.github/workflows/gh-pages.yml)

---

[![pages_build](/images/pages_build.png)](https://github.com/steinbrueckri/steinbrueckri.github.io/runs/745076666?check_suite_focus=true)

---

### 📦 Github Packages

- npm
- docker
- maven
- nuget
- rubygems

> BUT! Packages have some pitfalls
> for example the Docker registry require a Login

---
layout: cover
---

### 👨‍💻 Commandline tools

---

### [hub](https://github.com/github/hub)

```bash
$ hub --help
These GitHub commands are provided by hub:

   api            Low-level GitHub API request interface
   browse         Open a GitHub page in the default browser
   ci-status      Show the status of GitHub checks for a commit
   compare        Open a compare page on GitHub
   create         Create this repository on GitHub and add GitHub as origin
   delete         Delete a repository on GitHub
   fork           Make a fork of a remote repository on GitHub and add as remote
   gist           Make a gist
   issue          List or create GitHub issues
   pr             List or checkout GitHub pull requests
   pull-request   Open a pull request on GitHub
   release        List or create GitHub releases
   sync           Fetch git objects from upstream and update branches
```

---

### [gh](https://github.com/cli/cli)

```bash
$ gh --help
Work seamlessly with GitHub from the command line.

USAGE
gh <command> <subcommand> [flags]

CORE COMMANDS
  issue:      Create and view issues
  pr:         Create, view, and checkout pull requests
  repo:       Create, clone, fork, and view repositories

ADDITIONAL COMMANDS
  completion: Generate shell completion scripts
  config:     Set and get gh settings
  gist:       Create gists
  help:       Help about any command

FLAGS
      --help              Show help for command
  -R, --repo OWNER/REPO   Select another repository using the OWNER/REPO format
      --version           Show gh version

EXAMPLES
  $ gh issue create
  $ gh repo clone
  $ gh pr checkout 321

LEARN MORE
  Use "gh <command> <subcommand> --help" for more information about a command.
  Read the manual at <http://cli.github.com/manual>

FEEDBACK
  Fill out our feedback form <https://forms.gle/umxd3h31c7aMQFKG7>
  Open an issue using “gh issue create -R cli/cli”
```



---
layout: cover
---

### 🎉 Upcomming Features

---

### Codespaces (beta waitlist)

<small>
A complete dev environment within GitHub that lets you contribute immediately
</small>

![Codespace](https://miro.medium.com/max/1264/1*qeLQQaT1i7r35kQ4CQFwEA.gif)

---

### Discussions (beta waitlist)

<small>A new way for software communities to collaborate outside the codebase</small>

[![Discussions](/images/discussions.png)](https://github.com/vercel/next.js/discussions)

---

### Code scanning and secret scanning (beta waitlist)

Helping communities on GitHub produce and consume more secure code

- Show new potential security vulnerabilities in PRs
- [Token scanning](https://help.github.com/en/github/administering-a-repository/about-token-scanning)
- ![code-scanning](/images/code-scanning.png)

---

### GitHub Private Instances (beta waitlist)

Today we introduced our plans for GitHub Private Instances, a new, fully-managed option for our enterprise customers.
Private Instances provides enhanced security, compliance, and policy features including
bring-your-own-key encryption, backup archiving, and compliance with regional data sovereignty requirements.

---

### Funny Tools?

- [https://www.gitmemory.com/heubeck](https://www.gitmemory.com/heubeck)
- [http://gitstalk.netlify.app/heubeck](http://gitstalk.netlify.app/heubeck)
- [https://repo.new](https://repo.new)
