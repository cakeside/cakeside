ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Creations" do
          para "recently added creations:"
           ul do
             Creation.all.first(16).map do |creation|
               li link_to(creation.name, admin_creation_path(creation))
             end
           end
        end
      end
    end
  end
end
