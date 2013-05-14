require 'capistrano/recipes/deploy/strategy/copy'
require 'fileutils'

module Capistrano
  module Deploy
    module Strategy

      # This class extends copy strategy for deployments, adding
      # triggers before and after each separate task in the copy
      # strategy deploy task.
      class CopyWithTriggers < Copy

        def deploy!

          configuration.trigger('strategy:before:copy')
          copy_cache ? run_copy_cache_strategy : run_copy_strategy
          create_revision_file
          configuration.trigger('strategy:after:copy')

          configuration.trigger('strategy:before:compress_repository')
          compress_repository
          configuration.trigger('strategy:after:compress_repository')

          configuration.trigger('strategy:before:upload_remote_file')
          upload_remote_file!
          configuration.trigger('strategy:after:upload_remote_file')

          configuration.trigger('strategy:before:decompress_remote_file')
          decompress_remote_file
          configuration.trigger('strategy:after:decompress_remote_file')

        ensure
          FileUtils.rm filename rescue nil
          FileUtils.rm_rf destination rescue nil
        end

        # Distributes the file to the remote servers
        def upload_remote_file!
          args = [filename, remote_filename]
          args << { :via => configuration[:copy_via] } if configuration[:copy_via]

          upload(*args)
        end

      end
    end
  end
end
