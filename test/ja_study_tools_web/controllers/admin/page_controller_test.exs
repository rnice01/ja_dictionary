defmodule JaStudyToolsWeb.Admin.PageControllerTest do
  use JaStudyToolsWeb.ConnCase
  alias JaStudyTools.Testing.WebHelpers
  import JaStudyTools.Testing.Factory


  test "returns unauthorized for non admin users", %{conn: conn} do
    user = insert(:user)
    conn = WebHelpers.assign_user(user, conn)
    conn = get(conn, "/admin")

    assert redirected_to(conn, 302) =~ "/"

    conn = get(recycle(conn), "/")

    assert get_flash(conn) == %{"error" => "Unauthorized access"}
  end

  test "returns success for admin users", %{conn: conn} do
    admin = insert(:admin)
    conn = WebHelpers.assign_user(admin, conn)
    conn = get(conn, "/admin")

    assert html_response(conn, 200) =~ "JaStudyTools - Admin"
  end
end
