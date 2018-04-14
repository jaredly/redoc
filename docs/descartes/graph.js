
    (function() {

      var graph = {nodes: [], links: []};

      // Ignore operators
      var keys = Object.keys(DATA).filter(n => DATA[n].name.match(/^[a-zA-z]/));
      var moduleNames = {};
      // Remove things that don't link to anywhere
      keys = keys.filter(k => (toLinks[k] && toLinks[k].length) || DATA[k].values.length);

      const findRecursiveSize = k => {
        if (!DATA[k] || DATA[k].recursiveSize != null) {
          return
        }
        // DATA[k].recursiveSize = Math.sqrt(DATA[k].lines);
        DATA[k].recursiveSize = DATA[k].lines;
        DATA[k].values.forEach(v => {
          findRecursiveSize(v.id);
          DATA[k].recursiveSize += DATA[v.id].recursiveSize
        });
      }
      Object.keys(DATA).forEach(findRecursiveSize);

      var baseSize = 10;

      keys.forEach((k, i) => {
        var item = DATA[k];
        moduleNames[item.moduleName] = true
        var node = {
          x: 500 * Math.cos(i / keys.length * Math.PI) + Math.random() * 100,
          y: 500 * Math.sin(i / keys.length * Math.PI) + Math.random() * 100,
          size: Math.sqrt(item.lines) + baseSize,
          recursiveSize: Math.sqrt(item.recursiveSize) + baseSize,
          id: k,
          name: item.name,
          noDeps: item.values.length === 0,
          moduleName: item.moduleName,
        }
        // graph.nodes[k] = node;
        graph.nodes.push(node)
        DATA[k].values.forEach(({id, name, moduleName}) => {
          let pos = keys.indexOf(id)
          if (pos !== -1) {
            // graph.links.push({source: k, target: id})
            graph.links.push({source: i, target: pos})
          }
        })
      })
      let moduleList = Object.keys(moduleNames);

      var c20 = d3.scaleOrdinal(moduleList.length > 10 ? d3.schemeCategory20 : d3.schemeCategory10);

        ;(function() {

        const {node, div, span} = dsl;
        const root = div({class: 'modulesList'}, [
          div({class: 'modulesTitle'}, ['Module names']),
          ...moduleList.map((name, i) => div({class: 'module'}, [
            div({style: {backgroundColor: c20(i)}, class: 'module-dot'}, []),
            name
          ]))
        ])
        document.getElementById('graph').appendChild(root)
        })();

      var width = window.innerWidth,
          height = 500;

      var svg = d3.select("#graph").append("svg")
          .attr("width", width)
          .attr("height", height);

      svg.append("rect")
        .attr("width", width)
        .attr("height", height)
        .style("fill", "none")
        .style("pointer-events", "all")
        .call(d3.zoom()
            .scaleExtent([1 / 8, 4])
            .on("zoom", zoomed));

      var g = svg.append('g')

      var link = g.selectAll(".link"),
          node = g.selectAll(".node");


      var force = d3.forceSimulation()
            .force("charge", d3.forceManyBody().strength(-700).distanceMin(100).distanceMax(1000))
            .force("link", d3.forceLink().id(function(d) { return d.index }).distance(d => 100))
            .force("center", d3.forceCenter(width / 2, height / 2))
            // .force("y", d3.forceY(0.001))
            // .force("x", d3.forceX(0.001))

      force
          .nodes(graph.nodes)
          .force('link').links(graph.links)

      link = link.data(graph.links)
        .enter()
      line = link.append("line")
          .attr("class", "link");
      dot = link.append("path").attr("class", "arrow");

      node = node.data(graph.nodes)
        .enter()
          .append("g")
          .attr("class", "node")
          .call(d3.drag()
          .on("start", dragstarted)
          .on("drag", dragged)
          .on("end", dragended));


      node.append('circle')
          .attr('r', d => d.recursiveSize)
          .attr('display', d => d.noDeps ? 'none' : '')
          .attr('class', d => d.noDeps ? 'nodeps-ring' : (toLinks[d.id] ? 'ring' : 'entry-ring'));

      node.append('circle')
          .attr('r', d => d.size)
          .attr('class', d => d.noDeps ? 'no-deps' : '')
          // .attr('stroke-width', d => d.noDeps ? 5 : 1)
          .attr('fill', function (d) {
            return c20(moduleList.indexOf(d.moduleName))
              // return color(d.group);
          });

      node.append("text")
          .attr('class', 'background')
          .attr("dx", -18)
          .attr("dy", 8)
          .text(d => d.name);

      node.append("text")
          .attr('class', 'foreground')
          .attr("dx", -18)
          .attr("dy", 8)
          .text(d => d.name);

      force.on("tick", function () { tick() });

      function zoomed() {
        g.attr("transform", d3.event.transform);
      }

      function tick() {
        dot.attr('d', d => {
          let dy = d.target.y - d.source.y;
          let dx = d.target.x - d.source.x;
          let dist = Math.sqrt(dx * dx + dy * dy)
          let theta = Math.atan2(dy, dx);
          // console.log(dy, dx, dist, theta)
          // fail
          let nx = Math.cos(theta) * (dist - 13) + d.source.x;
          let ny = Math.sin(theta) * (dist - 13) + d.source.y;
          let t1 = theta + Math.PI * 7 / 8;
          let t2 = theta - Math.PI * 7 / 8;
          let arrow = 10;
          return `M ${nx} ${ny} L ${nx + Math.cos(t1) * arrow}  ${ny + Math.sin(t1) * arrow} L ${nx + Math.cos(t2) * arrow} ${ny + Math.sin(t2)*arrow}`
          // return `translate(${nx}, ${ny})`
          // `translate(${d.target.x}, ${d.target.y})`
        });
        line.attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });

        node.attr("transform", function (d) {
            return "translate(" + d.x + "," + d.y + ")";
        });

        // moduleList.forEach((n, i) => {
        //   var g = svg.append('g')
        //     .attr('transform', `translate(20, ${20 + i * 20})`)
        //   g.append('circle').attr('r', 10).attr('fill', c20(i))
        //   g.append('text').text(n)
        //   .attr('dx', 20)
        //   .attr('dy', 7)
        // })

      }


      function dblclick(d) {
        d3.select(this).classed("fixed", d.fixed = false);
      }

      // function dragstart(d) {
      //   d3.select(this).classed("fixed", d.fixed = true);
      // }


              function dragstarted(d) {
            if (!d3.event.active) force.alphaTarget(0.5).restart();
            d.fx = d.x;
            d.fy = d.y;
        // d3.select(this).classed("fixed", d.fixed = true);
        location.hash = '#block-' + d.id
        }

        function dragged(d) {
            d.fx = d3.event.x;
            d.fy = d3.event.y;
        }

        function dragended(d) {
            if (!d3.event.active) force.alphaTarget(0.5);
            d.fx = null;
            d.fy = null;
        }
    })();