import os

html_content = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Technical Documentation: Containerization vs Virtualization</title>
    <style>
        body { font-family: 'Consolas', 'Monaco', monospace; line-height: 1.6; color: #d1d1d1; max-width: 1100px; margin: 0 auto; padding: 40px; background-color: #1a1a1a; }
        header { border-bottom: 2px solid #3498db; padding-bottom: 20px; margin-bottom: 40px; }
        h1 { color: #3498db; margin: 0; font-size: 2rem; }
        h2 { color: #2ecc71; margin-top: 30px; border-left: 4px solid #2ecc71; padding-left: 15px; }
        h3 { color: #f1c40f; margin-top: 20px; }
        .section { background: #262626; padding: 25px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #333; }
        code { background: #3d3d3d; padding: 2px 6px; border-radius: 3px; color: #e74c3c; }
        .highlight { color: #3498db; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: #111; }
        th, td { border: 1px solid #444; padding: 12px; text-align: left; }
        th { background: #333; color: #2ecc71; }
        .architecture-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        pre { background: #000; padding: 20px; border-radius: 5px; border: 1px solid #444; color: #00ff00; }
    </style>
</head>
<body>

<header>
    <h1>Infrastructure Architecture: VM vs Containers</h1>
    <p>Low-level analysis of virtualization levels and resource management.</p>
</header>

<div class="section">
    <h2>1. Virtual Machines (Hardware Virtualization)</h2>
    <p>Virtual Machines operate by abstracting the physical hardware. This is achieved via a <b>Hypervisor</b> (e.g., KVM, Xen, VMware).</p>
    <ul>
        <li><span class="highlight">Full Stack:</span> Each VM includes a complete Guest Operating System, including its own Kernel, device drivers, and network stack.</li>
        <li><span class="highlight">Isolation Boundary:</span> Isolation occurs at the hardware level. The Hypervisor partitions physical CPU and RAM, creating a security boundary that is difficult to breach.</li>
        <li><span class="highlight">Resource Overhead:</span> Because each VM runs a full OS, significant RAM and CPU are consumed by the Guest Kernel and system background processes before the application even starts.</li>
    </ul>
</div>

<div class="section">
    <h2>2. Containers (OS-level Virtualization)</h2>
    <p>Containers abstract the <b>Operating System User Space</b>. They leverage the Host OS Kernel rather than hardware virtualization.</p>
    <ul>
        <li><span class="highlight">Shared Kernel:</span> All containers running on a host share the same Linux Kernel. This eliminates the need for a Guest OS.</li>
        <li><span class="highlight">Isolation Mechanism:</span> Uses <b>Namespaces</b> (for visibility) and <b>Cgroups</b> (for resource allocation). It is a logical isolation of processes rather than physical hardware partitioning.</li>
        <li><span class="highlight">Efficiency:</span> Since they lack a Guest OS, containers boot in milliseconds and have negligible performance overhead compared to native processes.</li>
    </ul>
</div>

<div class="section">
    <h2>3. Comparative Technical Analysis</h2>
    <table>
        <thead>
            <tr>
                <th>Feature</th>
                <th>Virtual Machines (VM)</th>
                <th>Containers (Docker)</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><b>Abstraction</b></td>
                <td>Physical Hardware</td>
                <td>Operating System (Kernel)</td>
            </tr>
            <tr>
                <td><b>Guest OS</b></td>
                <td>Full OS required per VM</td>
                <td>No Guest OS (Shares Host Kernel)</td>
            </tr>
            <tr>
                <td><b>Isolation</b></td>
                <td>Hardware-level (High Security)</td>
                <td>Process-level (Software Isolation)</td>
            </tr>
            <tr>
                <td><b>Boot Time</b></td>
                <td>Minutes (Full OS boot cycle)</td>
                <td>Milliseconds (Process start)</td>
            </tr>
            <tr>
                <td><b>Resource Usage</b></td>
                <td>Static (Pre-allocated RAM/Disk)</td>
                <td>Dynamic (Scales with usage)</td>
            </tr>
            <tr>
                <td><b>Storage</b></td>
                <td>Large (GBs per VM)</td>
                <td>Small (MBs per Image Layer)</td>
            </tr>
        </tbody>
    </table>
</div>

<div class="section">
    <h2>4. Core Logic Summary</h2>
    <div class="architecture-grid">
        <div>
            <h3>VM Architecture</h3>
            <pre>
[ Application ]
[ Libs/Bins   ]
[ Guest OS    ] (Includes Kernel)
[ Hypervisor  ]
[ Physical HW ]
            </pre>
        </div>
        <div>
            <h3>Container Architecture</h3>
            <pre>
[ Application ]
[ Libs/Bins   ]
[ Container Runtime ]
[ Host OS Kernel ]
[ Physical HW ]
            </pre>
        </div>
    </div>
</div>

<div class="section">
    <h2>5. Advanced Resource Management</h2>
    <p>In a <b>VM environment</b>, if you allocate 8GB of RAM to a VM, those 8GB are locked to that VM regardless of actual usage. In a <b>Container environment</b>, resources are governed by the Kernel's <b>Cgroups</b>. This allows for 'bursting' where containers can use available host resources dynamically, resulting in much higher density (running more applications on the same hardware).</p>
</div>

</body>
</html>
"""

file_name = "vm_vs_docker_tech.html"
with open(file_name, "w") as f:
    f.write(html_content)

print(f"Technical Documentation generated: {os.path.abspath(file_name)}")