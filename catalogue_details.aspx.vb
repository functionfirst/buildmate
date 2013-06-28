Partial Class manager_catalogue_details
    Inherits System.Web.UI.Page

    Protected Sub Validate_OnClick()
        Page.Validate("editGroup")
    End Sub

    Protected Sub Validate_Insert()
        Page.Validate("insertGroup")
    End Sub
End Class
