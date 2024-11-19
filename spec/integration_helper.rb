# rubocop:disable all
require 'spec_helper'
require_relative '../config/configuration'

RSpec.configure do |config|
  config.before :suite do
    DB = Configuration.db
    Sequel.extension :migration
    logger = Configuration.logger
    db = Configuration.db
    db.loggers << logger
    Sequel::Migrator.run(db, 'db/migrations')
  end

  config.after :each do
    RepositorioMeGustasContenido.new.delete_all
    RepositorioReproducciones.new.delete_all
    RepositorioUsuarios.new.delete_all
    RepositorioContenido.new.delete_all
    RepositorioEpisodiosPodcast.new.delete_all
  end
end
