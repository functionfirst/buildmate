Imports Telerik.Web.UI
Imports System.IO
Imports System.Data.SqlClient
Imports Encore.PayPal.Nvp

Partial Class settings
    Inherits MyBaseClass

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        If RadUpload1.UploadedFiles.Count > 0 Then
            ' check for filename and update the user profile with the new logo
            Dim filename As String = RadUpload1.UploadedFiles.Item(0).GetName()
            If Not filename Is Nothing And Len(filename) > 0 Then
                ' grab name of previous logo
                Dim origFileName As String = CType(fvCompanyLogo.Row.FindControl("origImage"), HiddenField).Value

                ' update 
                updateImageDataSource.UpdateParameters("image").DefaultValue = filename
                updateImageDataSource.Update()

                ' rebind the image
                fvCompanyLogo.DataBind()

                ' delete image if possible
                Dim filepath As String = Session("filepath") & "images\logos\" & origFileName
                Try
                    If File.Exists(filepath) Then
                        If File.OpenRead(filepath).CanRead Then
                            File.Delete(filepath)
                        End If
                    End If
                Catch ex As Exception
                    Trace.Write(ex.Message)
                End Try
            End If

            showNotification("Logo Uploaded", "Your logo was uploaded successfully")
        Else
            showNotification("Error Uploading Logo", "Please ensure your file is in .jpg or .gif formats and the file size is under 500kb", True)
        End If

        ' send response to page
        'uploadResponse.Visible = True
    End Sub

    Protected Sub RadUpload1_FileExists(ByVal sender As Object, ByVal e As Telerik.Web.UI.Upload.UploadedFileEventArgs) Handles RadUpload1.FileExists
        Dim counter As Integer = 1
        Dim file As UploadedFile = e.UploadedFile
        Dim targetFolder As String = Server.MapPath(RadUpload1.TargetFolder)
        Dim targetFileName As String = Path.Combine(targetFolder, file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension())
        While System.IO.File.Exists(targetFileName)
            System.Math.Max(System.Threading.Interlocked.Increment(counter), counter - 1)
            targetFileName = Path.Combine(targetFolder, file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension())
        End While
        file.SaveAs(targetFileName)
    End Sub

    Protected Sub Validate_Change()
        Page.Validate("ChangePassword1")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlSettings"), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub fvContactDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvContactDetails.ItemUpdated
        showNotification("Contact Details Updated", "Your changes have been saved successfully")
    End Sub

    Protected Sub fvAddressDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvAddressDetails.ItemUpdated
        showNotification("Address Details Updated", "Your changes have been saved successfully")

    End Sub

    Protected Sub fvCompanyDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvCompanyDetails.ItemUpdated
        showNotification("Company Details Updated", "Your changes have been saved successfully")
    End Sub

    Protected Sub fvNotifications_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvNotifications.ItemUpdated
        showNotification("Notification Settings Updated", "Your changes have been saved successfully")
    End Sub
End Class
