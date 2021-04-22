module Opus
  macro opus_getter(type, name, opus_name = nil, is_bool = false, reverse_bool = false, enum_name = nil, converter = nil)
    {% opus_name ||= name.id.upcase %}
    {% is_bool = true if reverse_bool %}
    def {{name.id}}
      val = 0
      LibOpus.opus_{{type.id}}_ctl(@{{type.id}}, LibOpus::OPUS_GET_{{opus_name}}_REQUEST, pointerof(val))
      {% if is_bool %}
        {% if reverse_bool %}
          val == 0
        {% else %}
          val == 1
        {% end %}
      {% elsif enum_name %}
        {{enum_name.id}}.from_value val
      {% elsif converter %}
        {{ converter }}
      {% else %}
        val
      {% end %}
    end
  end

  macro opus_setter(type, name, opus_name = nil, is_bool = false, reverse_bool = false, enum_name = nil, converter = nil)
    {% opus_name ||= name.id.upcase %}
    {% is_bool = true if reverse_bool %}
    def {{name.id}}=(val)
      {% if is_bool %}
        {% if reverse_bool %}
          new_val = val ? 0 : 1
        {% else %}
          new_val = val ? 1 : 0
        {% end %}
      {% elsif enum_name %}
        new_val = val
      {% elsif converter %}
        new_val = {{ converter }}
      {% else %}
        new_val = val
      {% end %}
      LibOpus.opus_{{type.id}}_ctl(@{{type.id}}, LibOpus::OPUS_SET_{{opus_name}}_REQUEST, new_val)
      val
    end
  end
end
