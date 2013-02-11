class AppsController < ApplicationController
  def import

		results = Array.new
		a = Mechanize.new { |agent|
			agent.user_agent_alias = 'Mac Safari'
		}

		categories = Category.where("id >= 1 AND id <= 101")
		categories.each{|cat|
			pagectr		= 1
			perpage 	= 24

			while pagectr <= 10 do

				if cat[:id].to_i > 100
					pageurl = "https://play.google.com/store/apps/collection/topselling_#{cat[:category_id].downcase}?start=#{(perpage * (pagectr - 1)).to_s}&num=#{perpage.to_s}"
				else
					pageurl = "https://play.google.com/store/apps/category/#{cat[:category_id]}/collection/topselling_free?start=#{(perpage * (pagectr - 1)).to_s}&num=#{perpage.to_s}"
				end

				p pageurl
				a.get(pageurl) do |page|
				ctr = (perpage * (pagectr - 1)) + 1

					page.search(".snippet-medium").each do |item|
						str = thumbnail = app = company = desc = ''

						thumbnail 	= item.css(".thumbnail-wrapper-container .thumbnail-wrapper a img")
						app 		= item.css(".details div a")
						company 	= item.css(".details span div a")
						desc		= item.css(".details p")

						params 					= Hash.new
						params['img'] 			= thumbnail.first["src"]
						params['url'] 			= app.first["href"]
					  	
					  	params['url'].split('?').second.split('&').each{|p|
					  		tmp = p.split('=')
					  		if tmp.first == 'id'
					  			str = tmp.second
					  		end
					  	}
						params['appid']			= str
						params['appname'] 		= app.first.text
						params['companyname'] 	= company.first.text
						params['companyurl'] 	= company.first["href"]
						params['desc']			= desc.first.text
						#p params['appname']
						#p '=' + ctr.to_s

						app = Apps.find_by_app_id(params['appid'])
						if !app.present?

							company = Companies.find_by_company_id(params['companyname'])
							if !company.present?
								company = Companies.create(:company_name => params['companyname'], :company_id => params['companyname'], :url => params['companyurl'])
							end
							company_id = company[:id]

							app = Apps.create(:appname => params['appname'], :company_id => company_id, :app_id => params['appid'], :desc => params['desc'], :img => params['img'], :url => params['url'])
						end
						app_id = app[:id]

						if !AppCategory.create(:app_id => app_id, :category_id => cat[:id])
							p params
							p ctr
							p cat[:id]
							p pagectr
						end
						#AppRank.create(:app_id => app_id, :category_id => cat[:id], :rank => ctr)

						ctr += 1

					end
				end
				pagectr += 1
			end
		}

		render :text => "Apps import finished"

  end

end
