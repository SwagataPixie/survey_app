require 'csv'

TABLE_NAMES = ['tags', 'question_types']

def sync!
  TABLE_NAMES.each do |table_name|
    klass = Object.const_set(table_name.classify, Class.new(ActiveRecord::Base))
    sync_table(klass, table_name)
  end
end

def sync_table(klass, table_name)
  klass.transaction do
    csv_path = Rails.root.join('db', 'data', "#{table_name}.csv")
    CSV.read(csv_path.to_s, { col_sep: ',', headers: true }).each do |record|
      klass.where(record.to_hash).first_or_create
    end
  end
end

sync!
