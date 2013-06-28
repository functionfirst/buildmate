Imports Telerik.Web.UI

Partial Class knowledge_base
    Inherits System.Web.UI.Page


    Protected Sub setSearch()
        Dim category = rcbCategory.SelectedValue
        Dim keywords = rtbKeywords.Text
        Dim sql As String

        If keywords.Length > 0 Then
            sql = "SELECT KnowledgeArticles.KnowledgeArticleId, KnowledgeArticles.title, viewcount, dateAdded, KnowledgeCategories.Name " & _
            " FROM KnowledgeArticles LEFT JOIN KnowledgeCategories ON KnowledgeArticles.categoryId = KnowledgeCategories.KnowledgeCategoryId" & _
            " WHERE (keywords LIKE '%%%" & keywords & "%%%' " & _
            " OR article  LIKE '%%%" & keywords & "%%%' " & _
            " OR title LIKE '%%%" & keywords & "%%%') "
            If category > 0 Then
                sql += " AND categoryId = " & category
            End If
        ElseIf category > 0 Then
            sql = "SELECT KnowledgeArticles.KnowledgeArticleId, KnowledgeArticles.title, viewcount, dateAdded, KnowledgeCategories.Name " & _
            " FROM KnowledgeArticles LEFT JOIN KnowledgeCategories ON KnowledgeArticles.categoryId = KnowledgeCategories.KnowledgeCategoryId " & _
            " WHERE categoryId = " & category & _
            " "
        Else
            sql = "SELECT KnowledgeArticles.KnowledgeArticleId, title, viewcount, dateAdded, KnowledgeCategories.Name " & _
            "FROM KnowledgeArticles " & _
            "LEFT JOIN KnowledgeCategories ON KnowledgeArticles.categoryId = KnowledgeCategories.KnowledgeCategoryId"
        End If

        knowledgeBaseDataSource.SelectCommand = sql

        knowledgeBaseDataSource.DataBind()
    End Sub

    Protected Sub btnApplyFilter_Click(sender As Object, e As System.EventArgs) Handles btnApplyFilter.Click
        setSearch()
    End Sub

    Protected Sub rtbKeywords_TextChanged(sender As Object, e As System.EventArgs) Handles rtbKeywords.TextChanged
        setSearch()
    End Sub

    Protected Sub rcbCategory_DataBound(sender As Object, e As System.EventArgs) Handles rcbCategory.DataBound
        rcbCategory.Items.Insert(0, New RadComboBoxItem("All categories", -1))
    End Sub

    Protected Sub rcbCategory_SelectedIndexChanged(o As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbCategory.SelectedIndexChanged
        setSearch()
    End Sub
End Class
