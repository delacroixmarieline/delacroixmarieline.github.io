Jekyll::Hooks.register :documents, :pre_render do |document|

  # get the current post last modified time
  modification_time = File.mtime( document.path )

  # inject modification_time in post's datas.
  # it will available as *{{ page.last-modified-date }}*
  document.data['last-modified-date'] = modification_time

end

require 'html-proofer'
Jekyll::Hooks.register :site, :post_write do |site|

  config = site.config


  dest = File.expand_path(config["destination"])
  indexPath = "#{dest}/index.html"
  options = {
      'allow_hash_href'=>true,
      'assume_extension'=>true,
      'check_html'=>true,
      'checks_to_ignore'=>[],
      'disable_external'=>true,
      'empty_alt_ignore'=>true,

  }


  # HTMLProofer.check_directory(dest, options).run
  # HTMLProofer.check_file(indexPath, options).run

end
