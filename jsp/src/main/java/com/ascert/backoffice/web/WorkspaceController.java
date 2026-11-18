package com.ascert.backoffice.web;

import com.ascert.backoffice.model.Preferences;
import com.ascert.backoffice.service.SampleData;
import java.util.Collections;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WorkspaceController {

    private static final String PREFERENCES = "preferences";

    private final SampleData sampleData;

    public WorkspaceController(SampleData sampleData) {
        this.sampleData = sampleData;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("stylesheets", Collections.singletonList("dashboard.css"));
        return "dashboard";
    }

    @GetMapping("/qdsdmanager")
    public String qdsd(Model model) {
        model.addAttribute("devices", sampleData.getQdsdDevices());
        return "qdsd";
    }

    @GetMapping("/qdsdmanager/qdsdDetails")
    public String qdsdDetails(Model model) {
        model.addAttribute("stylesheets", java.util.Arrays.asList(
                "qdsdDetails.css", "component.css", "overview.css"));
        return "qdsd-details";
    }

    @GetMapping("/factoryprovising")
    public String factory(Model model) {
        model.addAttribute("devices", sampleData.getFactoryDevices());
        return "factory";
    }

    @GetMapping("/factoryprovising/detail")
    public String factoryDetail(Model model) {
        model.addAttribute("stylesheets", Collections.singletonList("factoryprovisioning.css"));
        return "factory-detail";
    }

    @GetMapping("/report")
    public String reports(Model model) {
        model.addAttribute("stylesheets", Collections.singletonList("report.css"));
        return "reports";
    }

    @GetMapping("/report/{slug}")
    public String report(@PathVariable("slug") String slug, Model model) {
        String[] meta = reportMeta(slug);
        if (meta == null) {
            return "redirect:/report";
        }
        model.addAttribute("title", meta[0]);
        model.addAttribute("placeholder", meta[1]);
        model.addAttribute("rows", sampleData.getReportRows());
        model.addAttribute("stylesheets", Collections.singletonList("report.css"));
        return "report";
    }

    @GetMapping("/settings")
    public String settings(HttpSession session, Model model) {
        model.addAttribute("prefs", preferences(session));
        model.addAttribute("stylesheets", Collections.singletonList("settings.css"));
        return "settings";
    }

    @PostMapping("/settings")
    public String saveSettings(
            @RequestParam(value = "email", defaultValue = "false") boolean email,
            @RequestParam(value = "digest", defaultValue = "false") boolean digest,
            @RequestParam(value = "sessionLock", defaultValue = "false") boolean sessionLock,
            HttpSession session) {
        Preferences prefs = preferences(session);
        prefs.setEmail(email);
        prefs.setDigest(digest);
        prefs.setSessionLock(sessionLock);
        return "redirect:/settings?saved=1";
    }

    private Preferences preferences(HttpSession session) {
        Preferences prefs = (Preferences) session.getAttribute(PREFERENCES);
        if (prefs == null) {
            prefs = new Preferences();
            session.setAttribute(PREFERENCES, prefs);
        }
        return prefs;
    }

    private static String[] reportMeta(String slug) {
        if ("provisioning-report".equals(slug)) {
            return new String[] {"Provisioning Report", "Search provisioning report"};
        }
        if ("qdsdusage-report".equals(slug)) {
            return new String[] {"QDSD Usage Report", "Search QDSD usage report"};
        }
        if ("device-report".equals(slug)) {
            return new String[] {"Device Report", "Search device report"};
        }
        if ("failure-report".equals(slug)) {
            return new String[] {"Failure Report", "Search failure report"};
        }
        if ("dsc-download-report".equals(slug)) {
            return new String[] {"DSC Download Report", "Search DSC download report"};
        }
        if ("sign-report".equals(slug)) {
            return new String[] {"Signing Report", "Search signing report"};
        }
        return null;
    }
}
