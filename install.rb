#!/usr/bin/env ruby
require 'readline'
require 'fileutils'

class DotfilesInstaller
  CONFIG = {
    :home     => File.join(ENV['HOME']),
    :dotfiles => FileUtils.pwd
  }

  def initialize
    remove_installed_dotfiles
    install_dotfiles
    puts "\nDONE!"
  end

private

  def remove_installed_dotfiles
    puts "Uninstalling dotfiles"
    all_installed_dotfiles.each do |file|
      puts "- Uninstalling #{File.basename(file)}"
      uninstall(file)
    end
  end

  def install_dotfiles
    puts "\nInstalling dotfiles:"
    all_dotfiles.each do |file|
      install(file)
    end
  end

  def dotfile_home_path(dotfile)
    File.join(CONFIG[:home], File.basename(dotfile))
  end

  def uninstall(file)
    File.unlink(file)
  end

  def install(dotfile)
    if(File.exists?(dotfile_home_path(dotfile)))
      red "- Failed installing #{dotfile_home_path(dotfile)}, file already exists!"
      backup_and_try_again?(dotfile)
    else
      File.symlink(dotfile, dotfile_home_path(dotfile))
      green "- Installed #{dotfile_home_path(dotfile)}"
    end
  end

  def backup_and_try_again?(dotfile)
    if(ask("  Backup and try again? (y/n)") == "y")
      dotfile_path        = dotfile_home_path(dotfile)
      backup_dotfile_path = "#{dotfile_path}_#{current_time}"

      puts "  Moving file to #{backup_dotfile_path}"
      FileUtils.mv(dotfile_path, backup_dotfile_path)

      install(dotfile)
    end
  end

  # -------------------------------------------------------------------------- #

  def all_dotfiles
    Dir.glob(File.join(files_path, '*'), File::FNM_DOTMATCH).reject do |file|
      ['.', '..'].include?(File.basename(file)) # skip . and ..
    end
  end

  def all_installed_dotfiles
    Dir.glob(File.join(CONFIG[:home], '*'), File::FNM_DOTMATCH).reject do |file|
      !File.symlink?(file) or File.readlink(file) !~ /#{files_path}/
    end
  end

  def files_path
    File.join(CONFIG[:dotfiles], 'files')
  end

  def green(msg)
    color("32", msg)
  end

  def red(msg)
    color("31", msg)
  end

  def color(fg, msg)
    puts "\033[#{fg};1m#{msg}\033[0m"
  end

  def ask(msg, default = nil)
    question = default.nil? ? "#{msg}: " : "#{msg} [#{default}]: "
    answer = Readline::readline(question)
    answer == "" ? default : answer
  end

  def current_time
    Time.now.strftime("%Y%m%d%H%M%S")
  end
end

DotfilesInstaller.new
