node 'gitlab.local' { include ::roles::git_repo_server }
node 'ci1.local' { }
node 'ci2.local' { }
