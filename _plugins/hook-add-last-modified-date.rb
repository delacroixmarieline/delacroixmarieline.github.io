Jekyll::Hooks.register :documents, :pre_render do |document|

  # get the current post last modified time
  modification_time = File.mtime( document.path )

  # inject modification_time in post's datas.
  # it will available as *{{ page.last-modified-date }}*
  document.data['last-modified-date'] = modification_time

end
