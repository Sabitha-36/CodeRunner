Imports System
Imports System.Net
Imports System.IO
Imports System.Text

Partial Class Account_Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            lblMessage.Visible = False
            lblMessage.Text = ""
        End If

    End Sub


    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        '========================================
        ' GET LOGIN VALUES
        '========================================

        Dim username As String = txtUsername.Text.Trim()
        Dim password As String = txtPassword.Text.Trim()


        '========================================
        ' VALIDATION
        '========================================

        If username.Length = 0 OrElse password.Length = 0 Then

            lblMessage.Text = "Please enter both username and password."
            lblMessage.Visible = True

            Return

        End If


        '========================================
        ' ADMIN LOGIN
        '========================================

        Dim adminUsername As String = "admin123@gmail.com"
        Dim adminPassword As String = "12345"


        If username.Equals(adminUsername, StringComparison.OrdinalIgnoreCase) _
            AndAlso password = adminPassword Then

            'Store admin session
            Session("IsAdmin") = True
            Session("AdminEmail") = username

            System.Diagnostics.Debug.WriteLine(
                "ADMIN LOGIN SUCCESSFUL"
            )


            'Redirect to Admin Dashboard
            Response.Redirect(
                "~/Admin/Dashboard.aspx",
                False
            )

            Context.ApplicationInstance.CompleteRequest()

            Return

        End If


        '========================================
        ' NORMAL USER LOGIN
        '========================================

        Try

            '========================================
            ' NODE.JS API
            '========================================

            Dim apiUrl As String =
                "http://localhost:3000/api/login"


            '========================================
            ' CREATE JSON REQUEST
            '========================================

            Dim json As String =
                "{""username"":""" &
                EscapeJson(username) &
                """,""password"":""" &
                EscapeJson(password) &
                """}"


            System.Diagnostics.Debug.WriteLine(
                "REQUEST JSON = " & json
            )


            '========================================
            ' CREATE REQUEST
            '========================================

            Dim request As HttpWebRequest =
                CType(WebRequest.Create(apiUrl), HttpWebRequest)

            request.Method = "POST"
            request.ContentType = "application/json"
            request.Accept = "application/json"


            Dim data As Byte() =
                Encoding.UTF8.GetBytes(json)

            request.ContentLength = data.Length


            '========================================
            ' SEND REQUEST
            '========================================

            Using requestStream As Stream =
                request.GetRequestStream()

                requestStream.Write(
                    data,
                    0,
                    data.Length
                )

            End Using


            '========================================
            ' GET NODE.JS RESPONSE
            '========================================

            Dim apiResponse As HttpWebResponse =
                CType(request.GetResponse(), HttpWebResponse)


            Dim responseText As String = ""


            Using reader As New StreamReader(
                apiResponse.GetResponseStream())

                responseText = reader.ReadToEnd()

            End Using


            apiResponse.Close()


            System.Diagnostics.Debug.WriteLine(
                "LOGIN RESPONSE: " & responseText
            )


            '========================================
            ' USER LOGIN SUCCESS
            '========================================

            If responseText.Contains("""success"":true") Then


                Dim userId As String =
                    GetJsonValue(responseText, "_id")


                Dim returnedUsername As String =
                    GetJsonValue(responseText, "username")


                Dim character As String =
                    GetJsonValue(responseText, "character")


                System.Diagnostics.Debug.WriteLine(
                    "USER ID = " & userId
                )

                System.Diagnostics.Debug.WriteLine(
                    "USERNAME = " & returnedUsername
                )

                System.Diagnostics.Debug.WriteLine(
                    "CHARACTER = " & character
                )


                '========================================
                ' STORE USER SESSION
                '========================================

                Session("UserID") = userId
                Session("Username") = returnedUsername
                Session("Character") = character
                Session("IsAdmin") = False


                System.Diagnostics.Debug.WriteLine(
                    "USER SESSION CREATED"
                )


                '========================================
                ' REDIRECT USER TO HOME
                '========================================

                Response.Redirect(
                    "~/Home.aspx",
                    False
                )

                Context.ApplicationInstance.CompleteRequest()

                Return


            Else

                lblMessage.Text =
                    "Invalid username or password."

                lblMessage.Visible = True

            End If


        Catch ex As WebException

            System.Diagnostics.Debug.WriteLine(
                "WEB ERROR: " & ex.Message
            )


            If ex.Response IsNot Nothing Then

                Dim errorResponse As HttpWebResponse =
                    CType(ex.Response, HttpWebResponse)


                Dim errorText As String = ""


                Using reader As New StreamReader(
                    errorResponse.GetResponseStream())

                    errorText = reader.ReadToEnd()

                End Using


                errorResponse.Close()


                System.Diagnostics.Debug.WriteLine(
                    "API ERROR RESPONSE: " & errorText
                )


                lblMessage.Text =
                    "Invalid username or password."

                lblMessage.Visible = True


            Else

                lblMessage.Text =
                    "Cannot connect to Node.js server."

                lblMessage.Visible = True

            End If


        Catch ex As Exception

            System.Diagnostics.Debug.WriteLine(
                "GENERAL ERROR: " & ex.ToString()
            )


            lblMessage.Text =
                "Login error: " & ex.Message

            lblMessage.Visible = True

        End Try

    End Sub


    '========================================
    ' ESCAPE JSON
    '========================================

    Private Function EscapeJson(
        ByVal value As String) As String

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


    '========================================
    ' READ SIMPLE JSON VALUE
    '========================================

    Private Function GetJsonValue(
        ByVal json As String,
        ByVal key As String) As String

        Try

            Dim searchText As String =
                """" & key & """:"""


            Dim startPosition As Integer =
                json.IndexOf(searchText)


            If startPosition = -1 Then
                Return ""
            End If


            startPosition =
                startPosition + searchText.Length


            Dim endPosition As Integer =
                json.IndexOf(
                    """",
                    startPosition
                )


            If endPosition = -1 Then
                Return ""
            End If


            Return json.Substring(
                startPosition,
                endPosition - startPosition
            )


        Catch

            Return ""

        End Try

    End Function

End Class