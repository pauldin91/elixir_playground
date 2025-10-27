defmodule MvcDemo.AccountTest do
  use MvcDemo.DataCase

  alias MvcDemo.Account

  describe "credentials" do
    alias MvcDemo.Account.Credential

    import MvcDemo.AccountFixtures

    @invalid_attrs %{email: nil}

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Account.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Account.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      valid_attrs = %{email: "some email"}

      assert {:ok, %Credential{} = credential} = Account.create_credential(valid_attrs)
      assert credential.email == "some email"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      update_attrs = %{email: "some updated email"}

      assert {:ok, %Credential{} = credential} = Account.update_credential(credential, update_attrs)
      assert credential.email == "some updated email"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_credential(credential, @invalid_attrs)
      assert credential == Account.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Account.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Account.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Account.change_credential(credential)
    end
  end
end
