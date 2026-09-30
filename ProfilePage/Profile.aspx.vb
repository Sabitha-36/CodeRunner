Imports System
Imports System.Collections.Generic
Imports System.IO
Imports System.Net
Imports System.Web
Imports System.Web.Script.Serialization

Namespace ProfilePage
    Public Class Profile
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Session("Username") Is Nothing Then
                Response.Redirect("~/Account/Login.aspx")
                Exit Sub
            End If

            If Not IsPostBack Then
                LoadUserProfile(Session("Username").ToString())
            End If
        End Sub

        Private Sub LoadUserProfile(ByVal username As String)
            Try
                Dim apiUrl As String = "http://localhost:3000/api/profile?username=" & HttpUtility.UrlEncode(username)
                Dim request As HttpWebRequest = CType(WebRequest.Create(apiUrl), HttpWebRequest)
                request.Method = "GET"

                Using response As HttpWebResponse = CType(request.GetResponse(), HttpWebResponse)
                    Using sr As New StreamReader(response.GetResponseStream())
                        Dim jsonResult As String = sr.ReadToEnd()
                        Dim serializer As New JavaScriptSerializer()
                        Dim profileData As ProfileApiResponse = serializer.Deserialize(Of ProfileApiResponse)(jsonResult)

                        If profileData IsNot Nothing AndAlso profileData.success Then
                            Dim u = profileData.user

                            ' Bind Header Details
                            lblHeaderUsername.Text = u.username
                            lblInfoName.Text = u.username
                            lblInfoID.Text = u._id
                            lblHeaderLevel.Text = u.currentLevel.ToString()
                            lblInfoLevel.Text = u.currentLevel.ToString()
                            lblBestLevel.Text = u.currentLevel.ToString()

                            ' Bind Statistics
                            lblStatTotalScore.Text = u.score.ToString()
                            lblInfoHighScore.Text = u.score.ToString()
                            lblPerfHighScore.Text = u.score.ToString()

                            ' Experience Bar
                            lblCurrentXP.Text = u.xp.ToString()
                            Dim xpPercent As Integer = Math.Min(100, CInt((u.xp / 1000.0) * 100))
                            divXpFill.Style("width") = xpPercent & "%"

                            ' Metrics
                            lblCodesCollected.Text = profileData.totalCodesCollected.ToString()
                            lblStatGamesPlayed.Text = profileData.totalGamesPlayed.ToString()
                            lblStatWins.Text = profileData.totalWins.ToString()

                            If profileData.totalGamesPlayed > 0 Then
                                Dim winRate As Double = (profileData.totalWins / CDbl(profileData.totalGamesPlayed)) * 100
                                lblStatWinRate.Text = Math.Round(winRate) & "%"
                            Else
                                lblStatWinRate.Text = "0%"
                            End If

                            ' Bind Recent Games Repeater
                            If profileData.recentGames IsNot Nothing AndAlso profileData.recentGames.Count > 0 Then
                                rptRecentGames.DataSource = profileData.recentGames
                                rptRecentGames.DataBind()
                            End If
                        End If
                    End Using
                End Using
            Catch ex As Exception
                lblHeaderUsername.Text = username
            End Try
        End Sub

        Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As EventArgs)
            Session.Clear()
            Session.Abandon()
            Response.Redirect("~/Account/Login.aspx")
        End Sub

        Protected Sub btnplay_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnplay.Click
            Response.Redirect("~/LevelPage/Levels.aspx")
        End Sub
    End Class

    ' DATA CONTRACT MODELS
    Public Class UserDocument
        Public Property _id As String
        Public Property username As String
        Public Property currentLevel As Integer
        Public Property score As Integer
        Public Property xp As Integer
    End Class

    Public Class GameSessionDocument
        Public Property level As Integer
        Public Property gameScore As Integer
        Public Property completed As Boolean
        Public Property dateString As String
    End Class

    Public Class ProfileApiResponse
        Public Property success As Boolean
        Public Property user As UserDocument
        Public Property totalCodesCollected As Integer
        Public Property totalGamesPlayed As Integer
        Public Property totalWins As Integer
        Public Property recentGames As List(Of GameSessionDocument)
    End Class
End Namespace