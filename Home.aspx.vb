Partial Class Home
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Username") Is Nothing Then
            Response.Redirect("~/Account/Login.aspx")
            Return
        End If

        If Not IsPostBack Then

            lblUsernameNav.Text = Session("Username").ToString()
            lblUsername.Text = Session("Username").ToString()

            If Session("Character") IsNot Nothing Then
                lblCharacter.Text = Session("Character").ToString()
            End If

        End If

    End Sub


    Protected Sub btnPlayNow_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnPlayNow.Click

        Response.Redirect("~/LevelPage/Levels.aspx")

    End Sub


    Protected Sub btnLogout_Click(
        ByVal sender As Object,
        ByVal e As System.EventArgs
    ) Handles btnLogout.Click

        Session.Clear()
        Session.Abandon()

        Response.Redirect("~/Account/Login.aspx")

    End Sub

End Class