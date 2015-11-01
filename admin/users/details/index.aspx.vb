
Partial Class admin_users_details
    Inherits MyBaseClass

    Private Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        If e.Exception Is Nothing Then
            showNotification("Subscription Updated", "Your changes were saved successfully")
        Else
            showNotification("Error while saving :(", "Your changes were not saved! The error has been automatically reported to an administrator", True)

            reportError(e.Exception)
            e.ExceptionHandled = True
        End If
    End Sub
End Class
