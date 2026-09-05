Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Web.Script.Serialization

Partial Class Account_Register
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    End Sub

    Protected Sub btnRegister_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnRegister.Click
        Dim username As String = txtUsername.Text.Trim()
        Dim email As String = txtEmail.Text.Trim()
        Dim password As String = txtPassword.Text.Trim()
        Dim confirmPassword As String = txtConfirmPassword.Text.Trim()

        If String.IsNullOrEmpty(username) OrElse String.IsNullOrEmpty(email) OrElse String.IsNullOrEmpty(password) Then
            ShowMessage("All fields are required.", True)
            Exit Sub
        End If

        If password <> confirmPassword Then
            ShowMessage("Passwords do not match.", True)
            Exit Sub
        End If

        Try
            Dim apiUrl As String = "http://localhost:3000/api/register"
            Dim serializer As New JavaScriptSerializer()

            Dim payloadObj = New With {
                Key .username = username,
                Key .email = email,
                Key .password = password
            }
            Dim jsonPayload As String = serializer.Serialize(payloadObj)
            Dim byteArray As Byte() = Encoding.UTF8.GetBytes(jsonPayload)

            Dim request As HttpWebRequest = CType(WebRequest.Create(apiUrl), HttpWebRequest)
            request.Method = "POST"
            request.ContentType = "application/json"
            request.ContentLength = byteArray.Length

            Using dataStream As Stream = request.GetRequestStream()
                dataStream.Write(byteArray, 0, byteArray.Length)
            End Using

            Dim responseJson As String = ""
            Using response As HttpWebResponse = CType(request.GetResponse(), HttpWebResponse)
                Using reader As New StreamReader(response.GetResponseStream())
                    responseJson = reader.ReadToEnd()
                End Using
            End Using

            Dim responseData = serializer.Deserialize(Of Dictionary(Of String, Object))(responseJson)

            If responseData IsNot Nothing AndAlso responseData.ContainsKey("success") AndAlso CBool(responseData("success")) = True Then
                Response.Redirect("Login.aspx?status=registered")
            Else
                Dim errorMsg As String = "Registration failed."
                If responseData IsNot Nothing AndAlso responseData.ContainsKey("message") Then
                    errorMsg = responseData("message").ToString()
                End If
                ShowMessage(errorMsg, True)
            End If

        Catch ex As WebException
            If ex.Response IsNot Nothing Then
                Using stream = ex.Response.GetResponseStream()
                    Using reader = New StreamReader(stream)
                        Dim responseJson As String = reader.ReadToEnd()
                        Dim serializer As New JavaScriptSerializer()
                        Dim responseData = serializer.Deserialize(Of Dictionary(Of String, Object))(responseJson)

                        If responseData IsNot Nothing AndAlso responseData.ContainsKey("message") Then
                            ShowMessage(responseData("message").ToString(), True)
                        Else
                            ShowMessage("Registration failed or user already exists.", True)
                        End If
                    End Using
                End Using
            Else
                ShowMessage("Unable to connect to Node.js backend server.", True)
            End If
        Catch ex As Exception
            ShowMessage("Error: " & ex.Message, True)
        End Try

    End Sub

    Private Sub ShowMessage(ByVal message As String, ByVal isError As Boolean)
        lblMessage.Text = message
        lblMessage.Visible = True
        If isError Then
            lblMessage.CssClass = "alert-msg"
            lblMessage.Attributes("style") = "background-color: #ef4444;"
        Else
            lblMessage.CssClass = "alert-msg"
            lblMessage.Attributes("style") = "background-color: #10b981;"
        End If
    End Sub
End Class