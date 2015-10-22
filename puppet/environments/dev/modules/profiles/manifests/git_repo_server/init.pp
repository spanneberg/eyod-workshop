class profiles::git_repo_server {

  class { 'gitlab':
    external_url => 'http://gitlab.local',
  }

}
