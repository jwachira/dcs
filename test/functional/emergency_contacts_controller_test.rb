require 'test_helper'

class EmergencyContactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emergency_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emergency_contact" do
    assert_difference('EmergencyContact.count') do
      post :create, :emergency_contact => { }
    end

    assert_redirected_to emergency_contact_path(assigns(:emergency_contact))
  end

  test "should show emergency_contact" do
    get :show, :id => emergency_contacts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => emergency_contacts(:one).to_param
    assert_response :success
  end

  test "should update emergency_contact" do
    put :update, :id => emergency_contacts(:one).to_param, :emergency_contact => { }
    assert_redirected_to emergency_contact_path(assigns(:emergency_contact))
  end

  test "should destroy emergency_contact" do
    assert_difference('EmergencyContact.count', -1) do
      delete :destroy, :id => emergency_contacts(:one).to_param
    end

    assert_redirected_to emergency_contacts_path
  end
end
