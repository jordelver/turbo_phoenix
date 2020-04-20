defmodule TurboPhoenixWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, translate_error(error), class: "help is-danger is-size-6")
    end)
  end

  @doc """
  Output a CSS class for form inputs with errors.
  """
  def field_error(form, field) do
    if Keyword.has_key?(form.errors, field) do
      "is-danger"
    end
  end

  @doc """
  Generates an error icon tag for inlined form input errors.
  """
  def error_icon(form, field) do
    if Keyword.has_key?(form.errors, field) do
      """
      <span class="icon is-small is-right">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
          aria-hidden="true" role="img">
          <path fill="currentColor" d="M569.517 440.013C587.975 472.007 564.806
            512 527.94 512H48.054c-36.937 0-59.999-40.055-41.577-71.987L246.423
            23.985c18.467-32.009 64.72-31.951 83.154 0l239.94 416.028zM288
            354c-25.405 0-46 20.595-46 46s20.595 46 46 46 46-20.595
            46-46-20.595-46-46-46zm-43.673-165.346l7.418 136c.347 6.364 5.609
            11.346 11.982 11.346h48.546c6.373 0 11.635-4.982
            11.982-11.346l7.418-136c.375-6.874-5.098-12.654-11.982-12.654h-63.383c-6.884
            0-12.356 5.78-11.981 12.654z"/>
        </svg>
      </span>
      """
      |> raw
    end
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(TurboPhoenixWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(TurboPhoenixWeb.Gettext, "errors", msg, opts)
    end
  end
end
