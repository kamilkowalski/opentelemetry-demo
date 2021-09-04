defmodule CmsWeb.TimeTrackingController do
  use CmsWeb, :controller

  def show(conn, _params) do
    render(conn, "show.html")
  end

  def update(conn, _parms) do
    conn =
      case Cms.TimeTracking.cluck_in() do
        :ok -> put_flash(conn, :info, "Clucked in successfully!")
        :error -> put_flash(conn, :error, "Error clucking in!")
      end

    redirect(conn, to: Routes.time_tracking_path(conn, :show))
  end
end
