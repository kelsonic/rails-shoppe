require 'rails_helper'


feature 'Admin can do stuff with products' do

  before do
    User.create!(
      username: "jim",
      admin: false,
      email: "jim@jim.com",
      password: "jimjim"
    )
    User.create!(
      username: "admin",
      admin: true,
      email: "admin@admin.com",
      password: "adminadmin"
    )
  end

  feature 'regular users cannot go to admin page' do

    background do
      visit login_path
      within(".form") do
        fill_in "Email", with: "jim@jim.com"
        fill_in "Password", with: "jimjim"
      end
      click_button "Log in"
    end

    scenario 'non-admin cannot go to admin page' do
      visit '/admin'
      expect(page).to have_text "You must be an admin to access this content."
    end

  end

  feature 'STEP 0: admin goes to login page' do

    background do
      visit login_path
      within(".form") do
        fill_in "Email", with: "admin@admin.com"
        fill_in "Password", with: "adminadmin"
      end
      click_button "Log in"
    end

    scenario 'STEP 1: admin can go to admin page' do
      visit '/admin'
      expect(page).to have_link "New Product"
    end

    feature 'STEP 2: admin can go to new product page' do

      background do
        visit '/admin'
        first(:link, "New Product").click
      end

      scenario 'admin goes to new product page' do
        expect(page).to have_button "Create Product"
      end

      feature 'STEP 3: admin can create product' do

        feature 'product has validations' do

          background do
            visit '/products/new'
            click_button "Create Product"
          end

          scenario 'product validations are present' do
            expect(page).to have_text "Name can't be blank"
            expect(page).to have_text "Image url can't be blank"
            expect(page).to have_text "Description can't be blank"
            expect(page).to have_text "Description is too short (minimum is 5 characters)"
            expect(page).to have_text "Inventory quantity can't be blank"
            expect(page).to have_text "Inventory quantity is not a number"
          end

        end

        background do
          within("form") do
            fill_in "Name", with: "Robot 2.0"
            fill_in "Image url", with: "http://www.timsackett.com/wp-content/uploads/2013/06/irobot.png"
            fill_in "Description", with: "Get the newest version of the robot that will kill everyone and everything ASAP!"
            fill_in "Inventory quantity", with: "22"
            fill_in "Price", with: "99.99"
          end
          click_button "Create Product"
        end

        scenario "admin creates a new product" do
          expect(page).to have_text "Product was successfully created."
        end

        feature 'cannot add a quantity that is greater than inventory' do

          background do
            fill_in "quantity", with: "23"
            click_button "Add to Cart"
          end

          scenario 'adds too much to cart compared to inventory' do
            expect(page).to have_text "Sorry. We don't have that item in stock for the quantity specified."
          end

        end

        feature 'can add products and quantities to their cart' do

          background do
            fill_in "quantity", with: "21"
            click_button "Add to Cart"
          end

          scenario 'adds a product and quantity to the cart' do
            expect(page).to have_text "2099.79"
          end

          feature 'can remove an item from the cart' do

            background do
              click_link "remove"
            end

            scenario 'cart does not have removed item' do
              expect(page).not_to have_text "Robot 2.0"
            end

            feature 'can checkout' do

              background do
                visit root_path
                first(:link, "Show").click
                fill_in "quantity", with: "21"
                click_button "Add to Cart"
                click_link "Checkout"
              end

              scenario 'can access confirm order page' do
                expect(page).to have_text "Robot 2.0"
                expect(page).to have_text "Purchase"
              end

              feature 'can complete an order' do

                background do
                  click_link "Purchase"
                end

                scenario do
                  expect(page).to have_text "Thank you for your order, admin!"
                  expect(page).to have_text "2099.79"
                end

                feature 'can view previous orders' do

                  background do
                    click_link "Order History"
                  end

                  scenario 'can view previous orders' do
                    expect(page).to have_text Date.today.strftime("%m/%d/%y")
                    expect(page).to have_text "2099.79"
                  end

                  feature 'has a cleared cart after making an order' do

                    background do
                      visit my_cart_path
                    end

                    scenario "goes to cart after making an order and notices a perfectly clean cart" do
                      expect(page).to have_text "$0"
                      expect(page).to have_text "Checkout"
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
