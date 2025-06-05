require 'faraday'
require 'nokogiri'
require 'time'
require 'date'
require 'i18n'

I18n.config.available_locales = :es
I18n.locale = :es

class ArticleScraper
  def self.scrape_and_save(url)
    response = Faraday.get(url) do |req|
      req.headers['User-Agent'] = 'Ruby Scraper Bot'
    end

    html = response.body
    doc = Nokogiri::HTML(html)

   
    doc.search('script, style, img, nav, footer, aside, header, .ad, .ads, .advertisement').remove

    title = doc.at('title')&.text&.strip
    content = doc.search('p').map(&:text).join("\n\n").strip

    date = nil

    
    meta_selectors = [
      'meta[property="article:published_time"]',
      'meta[name="pubdate"]',
      'meta[name="date"]',
      'meta[property="og:published_time"]'
    ]

    meta_selectors.each do |selector|
      node = doc.at(selector)
      if node&.[]('content')
        begin
          parsed = Time.parse(node['content'])
          date = parsed if parsed <= Time.now
          break if date
        rescue; end
      end
    end

    
    if date.nil?
      timestamp_matches = doc.to_s.scan(/\d{10,13}/)
      timestamp_matches.each do |ts|
        begin
          ts = ts.to_i
          ts /= 1000 if ts > 9999999999
          parsed = Time.at(ts).utc
          if parsed <= Time.now
            date = parsed.iso8601
            break
          end
        rescue; end
      end
    end

    if date.nil?
      short_date = doc.text[/\b\d{1,2} [a-z]{3} \d{4}\b/i]
      if short_date
        begin
          parsed = Date.parse(short_date)
          date = parsed.iso8601 if parsed <= Date.today
        rescue; end
      end
    end

   
    if date.nil?
      text_date = doc.at('span.timestamp')&.text&.strip
      if text_date && text_date =~ /\d{1,2} de (\w+) de \d{4}/i
        begin
          meses = {
            'enero' => '01', 'febrero' => '02', 'marzo' => '03', 'abril' => '04', 'mayo' => '05', 'junio' => '06',
            'julio' => '07', 'agosto' => '08', 'septiembre' => '09', 'octubre' => '10', 'noviembre' => '11', 'diciembre' => '12'
          }
          mes_nombre = $1.downcase
          mes_numero = meses[mes_nombre]
          if mes_numero
            fecha_convertida = text_date.gsub(/(\d{1,2}) de (\w+) de (\d{4})/, "\\3-#{mes_numero}-\\1")
            parsed = Date.parse(fecha_convertida)
            date = parsed.iso8601 if parsed <= Date.today
          end
        rescue; end
      end
    end

    if title.present? && content.present? && url.present?
      Article.create!(
        title: title,
        content: content,
        link: url,
        published_at: date.presence
      )
    else
      raise "Faltan campos obligatorios: #{[title, content, url].map.with_index { |v, i| v.present? ? nil : %w[title content link][i] }.compact.join(', ')}"
    end
  end
end
