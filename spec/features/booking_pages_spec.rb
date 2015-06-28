require 'spec_helper'

describe "Booking pages" do
  def step_1?
    has_selector?("input[type!='hidden'], textarea", count: 3) && find('#booking_current_step').value() == "0"
  end

  def step_2?
    has_selector?("input[type!='hidden']", count: 5) && find('#booking_current_step').value() == "1"
  end

  def step_3?
    has_selector?("input[type!='hidden'], select, textarea", count: 8) && find('#booking_current_step').value() == "2"
  end

  def go_step(step)
    if step >= 2
      fill_in "booking_name", with: booking.name
      click_button ">"
    end
    if step >= 3
      fill_in "booking_quantity", with: booking.quantity
      fill_in "booking_categories_attributes_0_name", with: booking.categories.first.name
      click_button ">"
    end
  end

  subject { page }

  describe "new/create booking" do
    let(:booking) { Booking.build(:booking) }

    describe "all in one step" do
      before { visit new_booking_path(all: 1) }

      it "should show all fields" do
        should have_selector("div.field", count: 7)
      end

      it "should show errors" do
        click_button "Create"
        should have_selector("div.field_with_errors", count: 8)
      end

      it "should create booking" do
        fill_in "name of booking", with: booking.name
        fill_in "booking_quantity", with: booking.quantity
        fill_in "booking_tags", with: booking.tags
        fill_in "booking_categories_attributes_0_name", with: booking.categories.first.name
        expect { click_button "Create" }.to change(Booking, :count).by(1)
      end
    end

    describe "multiple steps" do
      before { visit new_booking_path }

      context "at step 1" do
        it "should be step 1" do
          step_1?.should be_true
        end

        it "should display error and not step forward" do
          click_button ">"
          should have_selector("div.field_with_errors")
          step_1?.should be_true
        end
      end

      context "at step 2" do
        before { go_step(2) }

        it "should be step 2" do
          step_2?.should be_true
        end

        it "should go back successfully" do
          click_button "Back"
          step_1?.should be_true
        end

        it "should display error and not step forward" do
          click_button ">"
          should have_selector("div.field_with_errors")
          step_2?.should be_true
        end
      end

      context "at step 3" do
        before { go_step(3) }

        it "should be step 3" do
          step_3?.should be_true
        end

        it "should go back successfully" do
          click_button "Back"
          step_2?.should be_true
          click_button "Back"
          step_1?.should be_true
        end

        it "should display error and not step forward" do
          click_button "Create"
          should have_selector("div.field_with_errors")
          step_3?.should be_true
        end

        it "should save the booking" do
          fill_in "booking_tags", with: booking.tags
          expect { click_button "Create" }.to change(Booking, :count).by(1)
        end
      end
    end

  end

  describe "edit/update booking" do
    let(:booking) { Booking.create(:booking) }

    describe "all in one step" do
      before do
        visit edit_booking_path(booking, all: 1)
        @required = [:name, :quantity, :tags]
      end

      it "should show all fields" do
        should have_selector("div.field", count: 7)
        @required.each { |field| find("#booking_#{field.to_s}").value().should eq booking[field].to_s }
      end

      it "should show errors" do
        @required.each { |field| find("#booking_#{field.to_s}").set(nil) }
        click_button "Update"
        should have_selector("div.field_with_errors", count: 6)
      end

      it "should update booking" do
        new_name = "Mega booking"
        fill_in "booking_name", with: new_name
        expect { click_button "Update" }.to_not change(Booking, :count)
        booking.reload.name.should eq new_name
      end
    end


    describe "multiple steps" do
      before { visit edit_booking_path(booking) }

      context "at step 1" do
        it "should be step 1" do
          step_1?.should be_true
        end

        it "should display error and not step forward if invalid" do
          fill_in "booking_name", with: nil
          click_button ">"
          should have_selector("div.field_with_errors")
          step_1?.should be_true
        end
      end

      context "at step 2" do
        before { go_step(2) }

        it "should be step 2" do
          step_2?.should be_true
        end

        it "should go back successfully" do
          click_button "<"
          step_1?.should be_true
        end

        it "should display error and not step forward" do
          fill_in "booking_quantity", with: nil
          click_button ">"
          should have_selector("div.field_with_errors")
          step_2?.should be_true
        end
      end

      context "at step 3" do
        before { go_step(3) }

        it "should be step 3" do
          step_3?.should be_true
        end

        it "should go back successfully" do
          click_button "<"
          step_2?.should be_true
          click_button "<"
          step_1?.should be_true
        end

        it "should display error and not step forward" do
          fill_in "booking_tags", with: nil
          click_button "Update"
          should have_selector("div.field_with_errors")
          step_3?.should be_true
        end

        it "should save the booking" do
          tags = booking.tags + ", misc"
          fill_in "booking_tags", with: tags
          expect { click_button "Update" }.to_not change(Booking, :count)
          booking.reload.tags.should eq tags
        end
      end
    end

  end

end
