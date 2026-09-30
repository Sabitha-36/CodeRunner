Namespace LeaderboardPage

    Partial Class Leaderboard
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            lblUsername.Text = Session("Username").ToString()

        End Sub

    End Class
End Namespace
