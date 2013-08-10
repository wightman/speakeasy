%#single post template
%include shared/header.tpl header=page,logged=logged,username=viewer
<div class="hero-unit tweets">
	%include shared/post.tpl tweet=tweet,username=username
</div>
%include shared/footer.tpl
