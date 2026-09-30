Imports System
Imports System.Net
Imports System.IO
Imports System.Web.Script.Serialization
Imports System.Collections.Generic
Imports System.Data
Imports System.Collections

Namespace Admin

    Partial Class Dashboard
        Inherits System.Web.UI.Page

        Private Const API_URL As String = "http://localhost:3000"

        ' =========================================================
        ' PAGE LOAD
        ' =========================================================

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

            If Not IsPostBack Then
                LoadDashboard()
            End If

        End Sub


        ' =========================================================
        ' LOAD DASHBOARD
        ' =========================================================

        Private Sub LoadDashboard()

            Try

                LoadStatistics()
                LoadPlayers()

            Catch ex As Exception

                ShowMessage("Unable to connect to Node.js backend: " & ex.Message)

            End Try

        End Sub


        ' =========================================================
        ' LOAD STATISTICS
        ' =========================================================

        Private Sub LoadStatistics()

            Dim json As String =
                GetApiData(API_URL & "/api/admin/stats")

            Dim serializer As New JavaScriptSerializer()

            Dim data As Dictionary(Of String, Object) =
                serializer.Deserialize(Of Dictionary(Of String, Object))(json)

            If data Is Nothing Then
                ShowMessage("Unable to read statistics.")
                Return
            End If

            If data.ContainsKey("success") AndAlso
               Convert.ToBoolean(data("success")) Then

                If data.ContainsKey("totalPlayers") Then
                    lblPlayerCount.Text =
                        Convert.ToString(data("totalPlayers"))
                Else
                    lblPlayerCount.Text = "0"
                End If

                If data.ContainsKey("onlinePlayers") Then
                    lblOnlineCount.Text =
                        Convert.ToString(data("onlinePlayers"))
                Else
                    lblOnlineCount.Text = "0"
                End If

                If data.ContainsKey("gamesPlayed") Then
                    lblGamesPlayed.Text =
                        Convert.ToString(data("gamesPlayed"))
                Else
                    lblGamesPlayed.Text = "0"
                End If

                If data.ContainsKey("highestScore") Then
                    lblHighestScore.Text =
                        Convert.ToString(data("highestScore"))
                Else
                    lblHighestScore.Text = "0"
                End If

            Else

                ShowMessage("Unable to load dashboard statistics.")

            End If

        End Sub


        ' =========================================================
        ' LOAD PLAYERS
        ' =========================================================

        Private Sub LoadPlayers()

            Try

                Dim json As String =
                    GetApiData(API_URL & "/api/admin/players")

                Dim serializer As New JavaScriptSerializer()

                Dim data As Dictionary(Of String, Object) =
                    serializer.Deserialize(Of Dictionary(Of String, Object))(json)

                If data Is Nothing Then
                    ShowMessage("No data received from backend.")
                    Return
                End If

                If Not data.ContainsKey("players") Then
                    ShowMessage("Backend response does not contain players.")
                    Return
                End If

                ' JavaScriptSerializer converts JSON arrays
                ' into ArrayList in .NET Framework
                Dim players As ArrayList =
                    TryCast(data("players"), ArrayList)

                If players Is Nothing Then
                    ShowMessage("Unable to read player data.")
                    Return
                End If

                Dim dt As DataTable =
                    CreatePlayerTable()

                For Each item As Object In players

                    Dim player As Dictionary(Of String, Object) =
                        TryCast(item, Dictionary(Of String, Object))

                    If player Is Nothing Then
                        Continue For
                    End If

                    AddPlayerRow(dt, player)

                Next

                gvPlayers.DataSource = dt
                gvPlayers.DataBind()

            Catch ex As Exception

                ShowMessage("Unable to load players: " & ex.Message)

            End Try

        End Sub


        ' =========================================================
        ' SEARCH PLAYERS
        ' =========================================================

        Private Sub SearchPlayers(ByVal searchText As String)

            Try

                Dim url As String =
                    API_URL &
                    "/api/admin/search?search=" &
                    Server.UrlEncode(searchText)

                Dim json As String =
                    GetApiData(url)

                Dim serializer As New JavaScriptSerializer()

                Dim data As Dictionary(Of String, Object) =
                    serializer.Deserialize(Of Dictionary(Of String, Object))(json)

                If data Is Nothing Then
                    ShowMessage("No data received from backend.")
                    Return
                End If

                If Not data.ContainsKey("players") Then
                    ShowMessage("No players found.")
                    Return
                End If

                ' IMPORTANT:
                ' JavaScriptSerializer returns JSON arrays as ArrayList
                Dim players As ArrayList =
                    TryCast(data("players"), ArrayList)

                If players Is Nothing Then
                    ShowMessage("Unable to read player data.")
                    Return
                End If

                Dim dt As DataTable =
                    CreatePlayerTable()

                For Each item As Object In players

                    Dim player As Dictionary(Of String, Object) =
                        TryCast(item, Dictionary(Of String, Object))

                    If player Is Nothing Then
                        Continue For
                    End If

                    AddPlayerRow(dt, player)

                Next

                gvPlayers.DataSource = dt
                gvPlayers.DataBind()

                If dt.Rows.Count = 0 Then

                    ShowMessage(
                        "No player found for: " &
                        searchText
                    )

                Else

                    lblMessage.Visible = False

                End If

            Catch ex As Exception

                ShowMessage(
                    "Search error: " &
                    ex.Message
                )

            End Try

        End Sub


        ' =========================================================
        ' SEARCH BUTTON
        ' =========================================================

        Protected Sub btnSearch_Click(
            ByVal sender As Object,
            ByVal e As EventArgs
        )

            Try

                Dim searchText As String =
                    txtSearch.Text.Trim()

                If searchText = "" Then

                    LoadPlayers()

                    Return

                End If

                ' Call the SearchPlayers method
                ' instead of duplicating the search code here
                SearchPlayers(searchText)

            Catch ex As Exception

                ShowMessage(
                    "Search error: " &
                    ex.Message
                )

            End Try

        End Sub


        ' =========================================================
        ' CLEAR SEARCH
        ' =========================================================

        Protected Sub btnClearSearch_Click(
            ByVal sender As Object,
            ByVal e As EventArgs
        )

            txtSearch.Text = ""

            LoadPlayers()

        End Sub


        ' =========================================================
        ' REFRESH
        ' =========================================================

        Protected Sub btnRefresh_Click(
            ByVal sender As Object,
            ByVal e As EventArgs
        )

            LoadDashboard()

        End Sub


        ' =========================================================
        ' GAME SETTINGS
        ' =========================================================

        Protected Sub btnGameSettings_Click(
            ByVal sender As Object,
            ByVal e As EventArgs
        )

            Response.Redirect("~/GameSettings.aspx")

        End Sub


        ' =========================================================
        ' EXIT ADMIN
        ' =========================================================

        Protected Sub btnLogout_Click(
            ByVal sender As Object,
            ByVal e As EventArgs
        )

            Session.Clear()
            Session.Abandon()

            Response.Redirect("~/Home.aspx")

        End Sub


        ' =========================================================
        ' API GET REQUEST
        ' =========================================================

        Private Function GetApiData(
            ByVal url As String
        ) As String

            Dim request As HttpWebRequest =
                CType(
                    WebRequest.Create(url), 
                    HttpWebRequest
                )

            request.Method = "GET"

            request.ContentType =
                "application/json"

            Using response As HttpWebResponse =
                CType(
                    request.GetResponse(), 
                    HttpWebResponse
                )

                Using reader As New StreamReader(
                    response.GetResponseStream()
                )

                    Return reader.ReadToEnd()

                End Using

            End Using

        End Function


        ' =========================================================
        ' CREATE PLAYER DATATABLE
        ' =========================================================

        Private Function CreatePlayerTable() As DataTable

            Dim dt As New DataTable()

            dt.Columns.Add("username")
            dt.Columns.Add("email")
            dt.Columns.Add("character")
            dt.Columns.Add("level")
            dt.Columns.Add("score")
            dt.Columns.Add("gamesPlayed")
            dt.Columns.Add("lastLogin")
            dt.Columns.Add("status")

            Return dt

        End Function


        ' =========================================================
        ' ADD PLAYER ROW
        ' =========================================================

        Private Sub AddPlayerRow(
            ByVal dt As DataTable,
            ByVal player As Dictionary(Of String, Object)
        )

            Dim row As DataRow =
                dt.NewRow()

            row("username") =
                GetValue(player, "username")

            row("email") =
                GetValue(player, "email")

            row("character") =
                GetValue(player, "character")

            row("level") =
                GetValue(player, "level")

            row("score") =
                GetValue(player, "score")

            row("gamesPlayed") =
                GetValue(player, "gamesPlayed")

            row("lastLogin") =
                GetValue(player, "lastLogin")

            row("status") =
                GetValue(player, "status")

            dt.Rows.Add(row)

        End Sub


        ' =========================================================
        ' GET DICTIONARY VALUE
        ' =========================================================

        Private Function GetValue(
            ByVal data As Dictionary(Of String, Object),
            ByVal key As String
        ) As String

            If data Is Nothing Then
                Return ""
            End If

            If Not data.ContainsKey(key) Then
                Return ""
            End If

            If data(key) Is Nothing Then
                Return ""
            End If

            Return data(key).ToString()

        End Function


        ' =========================================================
        ' SHOW MESSAGE
        ' =========================================================

        Private Sub ShowMessage(
            ByVal message As String
        )

            lblMessage.Text = message
            lblMessage.Visible = True

        End Sub

    End Class

End Namespace
