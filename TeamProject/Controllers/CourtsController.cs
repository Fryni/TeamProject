﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TeamProject.Models;

namespace TeamProject.Controllers
{
    public class CourtsController : Controller
    {
        private ProjectDbContext db = new ProjectDbContext();

        // GET: Courts
        public ActionResult Index()
        {
            var court = db.Court.Get();//.Include(c => c.Branch);
            return View(court.ToList());
        }

        // GET: Courts/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Court court = db.Court.Find(id??0);
            if (court == null)
            {
                return HttpNotFound();
            }
            return View(court);
        }

        // GET: Courts/Create
        public ActionResult Create()
        {
            ViewBag.BranchId = new SelectList(db.Branch.Get(), "Id", "Name");
            return View();
        }

        // POST: Courts/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,BranchId,Name,ImageCourt,MaxPlayers,Price")] Court court)
        {
            if (ModelState.IsValid)
            {
                db.Court.Add(court);
                return RedirectToAction("Index");
            }

            ViewBag.BranchId = new SelectList(db.Branch.Get(), "Id", "Name", court.BranchId);
            return View(court);
        }

        // GET: Courts/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Court court = db.Court.Find(id??0);
            if (court == null)
            {
                return HttpNotFound();
            }
            ViewBag.BranchId = new SelectList(db.Branch.Get(), "Id", "Name", court.BranchId);
            return View(court);
        }

        // POST: Courts/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,BranchId,Name,ImageCourt,MaxPlayers,Price")] Court court)
        {
            if (ModelState.IsValid)
            {
                db.Court.Update(court);
                return RedirectToAction("Index");
            }
            ViewBag.BranchId = new SelectList(db.Branch.Get(), "Id", "Name", court.BranchId);
            return View(court);
        }

        // GET: Courts/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Court court = db.Court.Find(id??0);
            if (court == null)
            {
                return HttpNotFound();
            }
            return View(court);
        }

        // POST: Courts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Court court = db.Court.Find(id);
            db.Court.Remove(court.Id);
            return RedirectToAction("Index");
        }


    }
}