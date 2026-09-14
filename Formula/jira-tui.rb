class JiraTui < Formula
  desc "Terminal UI for JIRA: ticket list, board, and actions in one shell"
  homepage "https://github.com/harsha509/jira-tui"
  url "https://github.com/harsha509/jira-tui/archive/refs/tags/v0.0.1-beta.tar.gz"
  version "0.0.1-beta"
  sha256 "6f87a2fa9d8bcfdb194f8395dabde8877addaec9a2056bd9ee373a16af41361a"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "ci", "--ignore-scripts"
    system "npm", "run", "build"
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      jira-tui reads its settings from the environment:
        JIRA_API_TOKEN  (required) an Atlassian API token
        JIRA_SERVER     e.g. https://yourcompany.atlassian.net
        JIRA_LOGIN      your Atlassian email
        JIRA_PROJECT    project key, e.g. ABC
      If you already use jira-cli, server/login/project are read from
      ~/.config/.jira/.config.yml and only JIRA_API_TOKEN is needed.
      Details: https://github.com/harsha509/jira-tui#configuration
    EOS
  end

  test do
    output = shell_output("#{bin}/jira-tui 2>&1", 1)
    assert_match "jira-tui cannot start", output
  end
end
