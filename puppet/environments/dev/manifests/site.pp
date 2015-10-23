node 'gitlab.local' { 
  include ::roles::git_repo_server 
}

node 'ci1.local' { 
  include ::roles::artifact_repo 
}

node 'ci2.local' { }
