Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Web.Script.Serialization
Imports System.Web.UI

Namespace ChallengePage

    Partial Public Class Challenge

        Inherits System.Web.UI.Page


        Protected Sub Page_Load(
            ByVal sender As Object,
            ByVal e As System.EventArgs
        ) Handles Me.Load


            If Not IsPostBack Then

                '========================================
                ' CHECK LOGIN
                '========================================

                If Session("Username") Is Nothing Then

                    Response.Redirect("~/Account/Login.aspx")

                    Return

                End If


                '========================================
                ' USERNAME
                '========================================

                Dim username As String =
                    Convert.ToString(Session("Username"))


                lblUsername.Text = username


                hiddenUsername.Value = username


                '========================================
                ' USER ID
                '========================================

                If Session("UserId") IsNot Nothing Then

                    hiddenUserId.Value =
                        Convert.ToString(Session("UserId"))

                Else

                    hiddenUserId.Value =
                        ""

                End If


                '========================================
                ' GET LEVEL
                '========================================

                Dim level As Integer = 1


                If Request.QueryString("level") IsNot Nothing Then

                    Integer.TryParse(
                        Request.QueryString("level"),
                        level
                    )

                ElseIf Session("ChallengeLevel") IsNot Nothing Then

                    Integer.TryParse(
                        Session("ChallengeLevel").ToString(),
                        level
                    )

                End If


                hiddenLevel.Value =
                    level.ToString()


                lblLevel.Text =
                    "LEVEL " & level.ToString()


                '========================================
                ' GET COLLECTED CODES
                ' FROM GAME.ASPX
                '========================================

                Dim collectedCodes As List(Of String) =
                    Nothing


                If Session("ChallengeCodes") IsNot Nothing Then

                    collectedCodes =
                        TryCast(
                            Session("ChallengeCodes"), 
                            List(Of String)
                        )

                End If


                '========================================
                ' DISPLAY COLLECTED CODES
                '========================================

                If collectedCodes Is Nothing OrElse
                   collectedCodes.Count = 0 Then

                    litCollectedCodes.Text =
                        "<span style='color:red;font-weight:bold;'>" &
                        "No collected codes were received." &
                        "</span>"

                Else

                    Dim html As New StringBuilder()


                    For Each token As String In collectedCodes

                        html.Append(
                            "<span class='token'>" &
                            Server.HtmlEncode(token) &
                            "</span>"
                        )

                    Next


                    litCollectedCodes.Text =
                        html.ToString()

                End If


                '========================================
                ' PROBLEM
                '========================================

                litProblem.Text =
                    GetProblem(level)


                '========================================
                ' EXPECTED OUTPUT
                '========================================

                litExpectedOutput.Text =
                    Server.HtmlEncode(
                        GetExpectedOutput(level)
                    )

            End If

        End Sub


        '====================================================
        ' GET PROBLEM
        '====================================================

        Private Function GetProblem(
            ByVal level As Integer
        ) As String


            Select Case level


                Case 1

                    Return "Write a Python program to calculate the sum of three numbers. " &
                           "Use the collected code tokens to create the correct program. " &
                           "The output should be 60."


                Case 2

                    Return "Write a Python program to find the greatest among three numbers. " &
                           "The numbers are 10, 25 and 15. " &
                           "The output should be 25."


                Case 3

                    Return "Write a Python program to check whether 15 is odd or even. " &
                           "The output should be Odd."


                Case 4

                    Return "Write a Python program to check whether -10 is positive or negative. " &
                           "The output should be Negative."


                Case 5

                    Return "Write a Python program to check whether the text 'madam' is a palindrome. " &
                           "The output should be Palindrome."


                Case 6

                    Return "Write a Python program to calculate the square root and cube root of 64. " &
                           "Print the square root first and cube root second."


                Case 7

                    Return "Write a Python program to calculate simple interest. " &
                           "Principal = 10000, Rate = 5 and Time = 2."


                Case 8

                    Return "Write a Python program to calculate the total and percentage of marks " &
                           "80, 75 and 90. Print total first and percentage second."


                Case 9

                    Return "Write Python functions for addition, subtraction, multiplication and division. " &
                           "Call the functions using 10 and 5 and print the four results."


                Case 10

                    Return "Create an Employee class with name and salary. " &
                           "Calculate a 10% bonus for an employee whose salary is 10000."


                Case Else

                    Return "Solve the programming problem using the collected code."

            End Select

        End Function


        '====================================================
        ' EXPECTED OUTPUT
        '====================================================

        Private Function GetExpectedOutput(
            ByVal level As Integer
        ) As String


            Select Case level


                Case 1

                    Return "60"


                Case 2

                    Return "25"


                Case 3

                    Return "Odd"


                Case 4

                    Return "Negative"


                Case 5

                    Return "Palindrome"


                Case 6

                    Return "8.0" &
                           Environment.NewLine &
                           "4.0"


                Case 7

                    Return "1000.0"


                Case 8

                    Return "245" &
                           Environment.NewLine &
                           "81.66666666666667"


                Case 9

                    Return "15" &
                           Environment.NewLine &
                           "5" &
                           Environment.NewLine &
                           "50" &
                           Environment.NewLine &
                           "2.0"


                Case 10

                    Return "1000.0"


                Case Else

                    Return ""

            End Select

        End Function

    End Class

End Namespace