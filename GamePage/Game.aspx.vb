Imports System
Imports System.Net
Imports System.Text
Imports System.Collections.Generic
Imports System.IO
Imports System.Web.Script.Serialization

Namespace GamePage

    Partial Public Class Game
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object,
                                ByVal e As System.EventArgs) Handles Me.Load

            If Not IsPostBack Then

                If Session("Username") Is Nothing Then
                    Response.Redirect("~/Account/Login.aspx")
                    Return
                End If
                lblUsername.Text = Session("Username").ToString()

                Dim username As String = Convert.ToString(Session("Username"))

                Dim level As Integer = 1

                If Request.QueryString("level") IsNot Nothing Then

                    Integer.TryParse(Request.QueryString("level"), level)

                End If

                hiddenLevel.Value = level.ToString()

                lblLevel.Text = "LEVEL " & level.ToString()


                '------------------------------------
                ' GET TOKENS FROM SESSION
                '------------------------------------
                If Session("LevelTokensJson") IsNot Nothing Then

                    hiddenLevelTokens.Value = Session("LevelTokensJson").ToString()

                Else

                    hiddenLevelTokens.Value = "[]"

                End If


                '------------------------------------
                ' INITIALIZE COLLECTED TOKENS
                '------------------------------------
                hiddenCollectedTokens.Value = "[]"


                '------------------------------------
                ' DEBUG INFORMATION
                '------------------------------------
                System.Diagnostics.Debug.WriteLine("Game Level: " & level.ToString())

                System.Diagnostics.Debug.WriteLine("Level Tokens: " & hiddenLevelTokens.Value)

            End If

        End Sub


        '==================================================
        ' GAME ENDED
        '==================================================

        Protected Sub btnGameEnded_Click(ByVal sender As Object, ByVal e As EventArgs)

            Try

                '==============================
                ' GET USERNAME
                '==============================

                Dim username As String = Convert.ToString(Session("Username"))


                '==============================
                ' GET LEVEL
                '==============================

                Dim level As Integer = 1

                If Session("CurrentLevel") IsNot Nothing Then

                    Integer.TryParse(
                        Session("CurrentLevel").ToString(),
                        level
                    )

                End If


                '==============================
                ' GET COLLECTED CODES
                '==============================

                Dim jsonCodes As String =
                    hiddenCollectedTokens.Value


                'Debug
                Response.Write("<script>alert('Collected JSON: " & jsonCodes.Replace("'", "\'") & "');</script>"
                )


                Dim serializer As New JavaScriptSerializer()


                Dim collectedCodes As List(Of String) = New List(Of String)()


                If Not String.IsNullOrEmpty(jsonCodes) Then

                    collectedCodes = serializer.Deserialize(Of List(Of String))(jsonCodes)

                End If

                '========================================
                ' PASS CODES TO CHALLENGE PAGE
                '========================================

                Session("ChallengeCodes") = collectedCodes

                Session("ChallengeLevel") = level


                '==============================
                ' GET SCORE
                '==============================

                Dim gameScore As Integer = 0

                Integer.TryParse(hiddenScore.Value, gameScore)

                '==============================
                ' LIVES
                '==============================

                Dim gameLives As Integer = 0

                Integer.TryParse(
                    hiddenLives.Value,
                    gameLives
                )


                '==============================
                ' CREATE JSON DATA
                '==============================

                Dim data As New Dictionary(Of String, Object)


                data.Add(
                    "userId",
                    Session("UserId")
                )


                data.Add(
                    "username",
                    username
                )


                data.Add(
                    "level",
                    level
                )


                data.Add(
                    "score",
                    gameScore
                )


                data.Add(
                    "lives",
                    gameLives
               )


                data.Add(
                    "collectedCodes",
                    collectedCodes
                )


                Dim json As String =
                    serializer.Serialize(data)


                '==============================
                ' SEND TO NODE.JS
                '==============================

                Dim client As New WebClient()


                client.Headers(
                    HttpRequestHeader.ContentType
                ) =
                    "application/json"


                Dim res As String =
                    client.UploadString("http://localhost:3000/api/game/save-codes", "POST", json
                    )


                '==============================
                ' GO TO CHALLENGE
                '==============================

                Response.Redirect(
                    "~/ChallengePage/Challenge.aspx?level=" &
                    level.ToString()
                )


            Catch ex As Exception

                Response.Write(
                    "<script>alert('" &
                    ex.Message.Replace("'", "") &
                    "');</script>"
                )

            End Try

        End Sub

        '==================================================
        ' SAVE GAME RESULT TO NODE.JS
        '==================================================

        Private Sub SaveGameResult()

            '------------------------------------------
            ' GET USERNAME FROM SESSION
            '------------------------------------------

            Dim username As String =
                Convert.ToString(Session("Username"))

            If String.IsNullOrEmpty(username) Then

                Response.Redirect("~/Login.aspx")

                Return

            End If


            '------------------------------------------
            ' GET LEVEL
            '------------------------------------------

            Dim level As Integer = 1

            If Not String.IsNullOrEmpty(hiddenLevel.Value) Then

                Integer.TryParse(
                    hiddenLevel.Value,
                    level
                )

            End If


            '------------------------------------------
            ' GET COLLECTED CODES
            '------------------------------------------

            Dim collectedCodes As String =
                Convert.ToString(
                    hiddenCollectedTokens.Value
                )

            If String.IsNullOrEmpty(collectedCodes) Then

                collectedCodes = "[]"

            End If


            '------------------------------------------
            ' GET SCORE
            '------------------------------------------

            Dim score As Integer = 0

            Integer.TryParse(
                hiddenScore.Value,
                score
            )

            '========================================
            ' LIVES
            '========================================

            Dim lives As Integer = 0

            Integer.TryParse(
                hiddenLives.Value,
                lives
            )
            '------------------------------------------
            ' CREATE JSON
            '------------------------------------------

            Dim json As String =
                "{" &
                """username"":""" &
                EscapeJson(username) &
                """," &
                """level"":" &
                level.ToString() &
                "," &
                """score"":" &
                score.ToString() &
                "," &
                """lives"":" &
                lives.ToString() &
                "," &
                """collectedCodes"":" &
                collectedCodes &
                "," &
                """completed"":true" &
                "}"


            '------------------------------------------
            ' SEND TO NODE.JS
            '------------------------------------------

            Dim request As HttpWebRequest =
                CType(
                    WebRequest.Create(
                        "http://localhost:3000/api/save-code"
                    ), 
                    HttpWebRequest
                )


            request.Method = "POST"

            request.ContentType =
                "application/json"


            Dim data As Byte() =
                Encoding.UTF8.GetBytes(json)


            request.ContentLength =
                data.Length


            Using stream As Stream =
                request.GetRequestStream()

                stream.Write(
                    data,
                    0,
                    data.Length
                )

            End Using


            '------------------------------------------
            ' GET RESPONSE
            '------------------------------------------

            Using response As HttpWebResponse =
                CType(
                    request.GetResponse(), 
                    HttpWebResponse
                )

                Using reader As New StreamReader(
                    response.GetResponseStream()
                )

                    Dim result As String =
                        reader.ReadToEnd()

                    'Optional:
                    'Response.Write(result)

                End Using

            End Using


            '------------------------------------------
            ' GO TO CHALLENGE PAGE
            '------------------------------------------

            Response.Redirect(
                "~/ChallengePage/Challenge.aspx?level=" &
                level.ToString()
            )

        End Sub


        '==================================================
        ' ESCAPE JSON
        '==================================================

        Private Function EscapeJson(
            ByVal value As String
        ) As String

            If value Is Nothing Then

                Return ""

            End If

            Return value.Replace(
                "\",
                "\\"
            ).Replace(
                """",
                "\"""
            )

        End Function

        Private Sub SaveCollectedCodes()

            Try

                Dim username As String =
                    Convert.ToString(Session("Username"))

                Dim level As Integer =
                    Convert.ToInt32(Session("CurrentLevel"))

                Dim collected As List(Of String) =
                    TryCast(Session("CollectedTokens"), List(Of String))

                If collected Is Nothing Then

                    collected = New List(Of String)()

                End If

                Dim data As New Dictionary(Of String, Object)

                data.Add("username", username)
                data.Add("level", level)
                data.Add("collectedTokens", collected)
                data.Add("score", 0)

                Dim serializer As New JavaScriptSerializer()

                Dim json As String =
                    serializer.Serialize(data)

                Dim client As New WebClient()

                client.Headers(HttpRequestHeader.ContentType) =
                    "application/json"

                Dim res As String =
                    client.UploadString(
                        "http://localhost:3000/api/game/save-codes",
                        "POST",
                        json
                    )

                Response.Write(res)

            Catch ex As Exception

                Response.Write(
                    "<script>alert('" &
                    ex.Message.Replace("'", "") &
                    "');</script>"
                )

            End Try

        End Sub
    End Class

End Namespace