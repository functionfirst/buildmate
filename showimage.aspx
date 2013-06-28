<%@ Page Language="VB" %>

<%@Import Namespace="System.Drawing.Imaging" %>
<script runat="server">
    Function ThumbnailCallback() As Boolean
        Return False
    End Function


    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'Read in the image filename to create a thumbnail of
        Dim imageUrl As String = Request.QueryString("img")
        
        If imageUrl.Length > 0 Then
            
            'Read in the width and height
            'Dim setHeight As Integer = Request.QueryString("h")
            Dim setWidth As Integer = Request.QueryString("w")

            'Make sure that the image URL doesn't contain any /'s or \'s
            'If imageUrl.IndexOf("/") >= 0 Or imageUrl.IndexOf("\") >= 0 Then
            'We found a / or \
            'Response.End()
            'End If
    
            'Add on the appropriate directory
            imageUrl = Session("filepath") & "images\logos\" & imageUrl
        
            Dim fullSizeImg As System.Drawing.Image
            fullSizeImg = System.Drawing.Image.FromFile(imageUrl)
        
            Dim origHeight = fullSizeImg.Height
            Dim origWidth = fullSizeImg.Width
            Dim setHeight = origHeight * setWidth / origWidth
        
            If setHeight > 200 Then
                setHeight = 200
                setWidth = origWidth * setHeight / origHeight
            End If

            ' set image format type
            Dim imgFormat As ImageFormat = ImageFormat.Jpeg
            Response.ContentType = "image/jpg"

            ' check if image is gif
            If imageUrl.Split(".")(1) = "gif" Then
                Response.ContentType = "image/gif"
                imgFormat = ImageFormat.Gif
            End If
        
            'Do we need to create a thumbnail?
            If setWidth > 0 And origWidth > setWidth Then
                Dim dummyCallBack As System.Drawing.Image.GetThumbnailImageAbort
                dummyCallBack = New System.Drawing.Image.GetThumbnailImageAbort(AddressOf ThumbnailCallback)

                Dim thumbNailImg As System.Drawing.Image
                thumbNailImg = fullSizeImg.GetThumbnailImage(setWidth, setHeight, dummyCallBack, IntPtr.Zero)

                thumbNailImg.Save(Response.OutputStream, imgFormat)

                'Clean up / Dispose...
                thumbNailImg.Dispose()
            Else
                fullSizeImg.Save(Response.OutputStream, imgFormat)
            End If
    
            'Clean up / Dispose...
            fullSizeImg.Dispose()
        End If
    End Sub

</script>
