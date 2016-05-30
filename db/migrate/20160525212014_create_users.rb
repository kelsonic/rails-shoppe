class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.string :oauth_expires_at
      t.string :image_url, default: "https://robohash.org/ipsumipsatemporibus.png?size=300x300&set=set1"
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
